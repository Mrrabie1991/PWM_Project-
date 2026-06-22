library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Testbench Entity (Empty, no ports)
entity pwm_tb is
end pwm_tb;

architecture Behavioral of pwm_tb is
    -- Testbench signals
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal period_in   : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal duty_in     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal load_period : STD_LOGIC := '0';
    signal load_duty   : STD_LOGIC := '0';
    signal pwm_out     : STD_LOGIC;

    constant clk_period : time := 20 ns; -- 50 MHz clock
begin

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Instantiate the Unit Under Test (UUT)
    DUT : entity work.pwm_top
        port map (
            clk          => clk,
            reset        => reset,
            period_in    => period_in,
            duty_in      => duty_in,
            load_period  => load_period,
            load_duty    => load_duty,
            pwm_out      => pwm_out
        );

    -- Stimulus process: Applying test scenarios
    stimulus : process
    begin
        -- 1. Initial Reset
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 100 ns;

        -- 2. Test Scenario 1: Normal operation (Period=10, Duty=3) -> 30% duty
        period_in <= std_logic_vector(to_unsigned(10, 16));
        duty_in   <= std_logic_vector(to_unsigned(3, 16));
        load_period <= '1';
        load_duty   <= '1';
        wait for clk_period;
        load_period <= '0';
        load_duty   <= '0';
        wait for 600 ns; -- Observe multiple cycles

        -- 3. Test Scenario 2: Changing Duty (Period=10, Duty=7) -> 70% duty
        duty_in <= std_logic_vector(to_unsigned(7, 16));
        load_duty <= '1';
        wait for clk_period;
        load_duty <= '0';
        wait for 600 ns;

        -- 4. Test Scenario 3: Edge Case - Duty > Period (Period=10, Duty=15)
        -- Expectation: Duty Limiter activates, output stays HIGH (100% duty)
        duty_in <= std_logic_vector(to_unsigned(15, 16));
        load_duty <= '1';
        wait for clk_period;
        load_duty <= '0';
        wait for 600 ns;

        -- 5. Test Scenario 4: Edge Case - Period = 0
        -- Expectation: Counter freezes, output stays LOW (Safe mode)
        period_in <= (others => '0');
        duty_in   <= std_logic_vector(to_unsigned(5, 16));
        load_period <= '1';
        load_duty   <= '1';
        wait for clk_period;
        load_period <= '0';
        load_duty   <= '0';
        wait for 400 ns;

        -- End of simulation
        report "Simulation Finished Successfully!" severity note;
        wait;
    end process;

end Behavioral;