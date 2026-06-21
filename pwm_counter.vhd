library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pwm_counter is

    Port (
        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;

        period_value : in  STD_LOGIC_VECTOR(15 downto 0);

        count        : out STD_LOGIC_VECTOR(15 downto 0)
    );

end pwm_counter;



architecture Behavioral of pwm_counter is

    signal count_internal : unsigned(15 downto 0);

begin


    process(clk)

    begin

        if rising_edge(clk) then


            if reset = '1' then

                count_internal <= (others => '0');


            elsif unsigned(period_value) = 0 then

                count_internal <= (others => '0');


            elsif count_internal >= unsigned(period_value) - 1 then

                count_internal <= (others => '0');


            else

                count_internal <= count_internal + 1;


            end if;


        end if;


    end process;



    count <= std_logic_vector(count_internal);



end Behavioral;