library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Duty Limiter Entity
-- Saturates the duty value to ensure it never exceeds the period.
-- Corner Case: If duty_value > period_value, output clamps to period_value (100% duty).
entity duty_limiter is
    Port (
        duty_value     : in  STD_LOGIC_VECTOR(15 downto 0);
        period_value   : in  STD_LOGIC_VECTOR(15 downto 0);
        duty_effective : out STD_LOGIC_VECTOR(15 downto 0)
    );
end duty_limiter;

architecture Behavioral of duty_limiter is
begin

    -- Combinational logic (No clock needed)
    process(duty_value, period_value)
    begin
        if unsigned(duty_value) > unsigned(period_value) then
            -- Clamp to period (results in 100% duty cycle)
            duty_effective <= period_value;
        else
            -- Pass the valid duty value through
            duty_effective <= duty_value;
        end if;
    end process;

end Behavioral;