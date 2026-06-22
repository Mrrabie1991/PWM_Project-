library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pwm_comparator is

    Port (
        count          : in  STD_LOGIC_VECTOR(15 downto 0);
        duty_effective : in  STD_LOGIC_VECTOR(15 downto 0);

        pwm_out        : out STD_LOGIC
    );

end pwm_comparator;



architecture Behavioral of pwm_comparator is

begin


    process(count, duty_effective)

    begin


        if unsigned(count) < unsigned(duty_effective) then

            pwm_out <= '1';


        else

            pwm_out <= '0';


        end if;


    end process;



end Behavioral;