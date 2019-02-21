library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h3p3 is
    port(LDA, LDB, S0, S1, CLK : in std_logic;
        X, Y : in std_logic_vector (7 downto 0);
        RB : inout std_logic_vector (7 downto 0));
end h3p3;

architecture rtl_ckt of h3p3 is
signal first_mux_out, second_mux_out, rega_out : std_logic_vector (7 downto 0);
begin
    
    reg_a: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                rega_out <= first_mux_out;
            end if;
        end if;
    end process;
    
    reg_b: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDB = '1') then
                RB <= second_mux_out;
            end if;
        end if;
    end process;
    
     --mux2
    with S1 select
    first_mux_out <= RB when '0',
                     X  when '1',
                     (others => '0') when others;
               
     --mux2
    with S0 select
    second_mux_out <= Y when '0',
                      rega_out  when '1',
                      (others => '0') when others;
    
end rtl_ckt;
