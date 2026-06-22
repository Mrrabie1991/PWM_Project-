library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Duty Register Entity
-- Stores the PWM duty cycle value.
-- Loads new data when 'load_duty' strobe is active.
entity duty_reg is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        load_duty  : in  STD_LOGIC;
        duty_in    : in  STD_LOGIC_VECTOR(15 downto 0);
        duty_value : out STD_LOGIC_VECTOR(15 downto 0)
    );
end duty_reg;

architecture Behavioral of duty_reg is
    signal duty_reg_internal : STD_LOGIC_VECTOR(15 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                duty_reg_internal <= (others => '0'); -- Reset to zero
            elsif load_duty = '1' then
                duty_reg_internal <= duty_in;         -- Latch new duty value
            end if;
        end if;
    end process;

    duty_value <= duty_reg_internal;

end Behavioral;