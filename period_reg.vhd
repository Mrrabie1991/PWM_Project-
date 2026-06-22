library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Period Register Entity
-- Stores the PWM period value (determines output frequency).
-- Loads new data when 'load_period' strobe is active.
entity period_reg is
    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        load_period  : in  STD_LOGIC;
        period_in    : in  STD_LOGIC_VECTOR(15 downto 0);
        period_value : out STD_LOGIC_VECTOR(15 downto 0)
    );
end period_reg;

architecture Behavioral of period_reg is
    signal period_reg_internal : STD_LOGIC_VECTOR(15 downto 0);
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                period_reg_internal <= (others => '0'); -- Reset to safe zero state
            elsif load_period = '1' then
                period_reg_internal <= period_in;       -- Latch new period value
            end if;
        end if;
    end process;

    period_value <= period_reg_internal;

end Behavioral;