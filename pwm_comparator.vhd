library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- PWM Comparator Entity
-- Compares current counter value with effective duty value.
-- Outputs '1' when count < duty_effective, otherwise '0'.
entity pwm_comparator is
    Port (
        count          : in  STD_LOGIC_VECTOR(15 downto 0);
        duty_effective : in  STD_LOGIC_VECTOR(15 downto 0);
        pwm_out        : out STD_LOGIC
    );
end pwm_comparator;

architecture Behavioral of pwm_comparator is
begin

    -- Combinational logic (No clock needed)
    process(count, duty_effective)
    begin
        if unsigned(count) < unsigned(duty_effective) then
            pwm_out <= '1';   -- Turn ON during the duty phase
        else
            pwm_out <= '0';   -- Turn OFF for the rest of the period
        end if;
    end process;

end Behavioral;