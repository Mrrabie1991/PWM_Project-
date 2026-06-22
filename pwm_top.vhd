library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity pwm_top is

    Port (

        clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;

        period_in    : in  STD_LOGIC_VECTOR(15 downto 0);
        duty_in      : in  STD_LOGIC_VECTOR(15 downto 0);

        load_period  : in  STD_LOGIC;
        load_duty    : in  STD_LOGIC;

        pwm_out      : out STD_LOGIC

    );

end pwm_top;



architecture Structural of pwm_top is



    signal period_value     : STD_LOGIC_VECTOR(15 downto 0);

    signal duty_value       : STD_LOGIC_VECTOR(15 downto 0);

    signal duty_effective   : STD_LOGIC_VECTOR(15 downto 0);

    signal count            : STD_LOGIC_VECTOR(15 downto 0);



begin




    PERIOD_REGISTER : entity work.period_reg

        port map (

            clk          => clk,

            reset        => reset,

            load_period  => load_period,

            period_in    => period_in,

            period_value => period_value

        );





    DUTY_REGISTER : entity work.duty_reg

        port map (

            clk        => clk,

            reset      => reset,

            load_duty  => load_duty,

            duty_in    => duty_in,

            duty_value => duty_value

        );





    PWM_COUNTER : entity work.pwm_counter

        port map (

            clk          => clk,

            reset        => reset,

            period_value => period_value,

            count        => count

        );





    DUTY_LIMITER : entity work.duty_limiter

        port map (

            duty_value     => duty_value,

            period_value   => period_value,

            duty_effective => duty_effective

        );





    PWM_COMPARATOR : entity work.pwm_comparator

        port map (

            count          => count,

            duty_effective => duty_effective,

            pwm_out        => pwm_out

        );



end Structural;