library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity duty_limiter is

    Port (
        duty_value      : in  STD_LOGIC_VECTOR(15 downto 0);
        period_value    : in  STD_LOGIC_VECTOR(15 downto 0);

        duty_effective  : out STD_LOGIC_VECTOR(15 downto 0)
    );

end duty_limiter;



architecture Behavioral of duty_limiter is

begin


    process(duty_value, period_value)

    begin


        if unsigned(duty_value) > unsigned(period_value) then

            duty_effective <= period_value;


        else

            duty_effective <= duty_value;


        end if;


    end process;



end Behavioral;