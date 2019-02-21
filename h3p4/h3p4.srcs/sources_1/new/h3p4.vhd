library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h3p4 is
    port ( LDA, LDB, S0, S1, RD, CLK: in std_logic;
            X, Y : in std_logic_vector (7 downto 0);
            RA, RB : inout std_logic_vector (7 downto 0));
end h3p4;

architecture rtl_ckt of h3p4 is
signal first_mux_out, second_mux_out : std_logic_vector (7 downto 0);
signal ldb_and_out, lda_and_out : std_logic;

begin
    
    reg_a: process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (lda_and_out = '1') then
                RA <= second_mux_out;
            end if;
        end if;
    end process;
    
    reg_b: process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (ldb_and_out = '1') then
                RB <= first_mux_out;
            end if;
        end if;
    end process;
    
     --mux2
    with S1 select
    first_mux_out <= Y when '0',
                     X  when '1',
                     (others => '0') when others;
               
     --mux2
    with S0 select
    second_mux_out <= Y when '0',
                      RB  when '1',
                      (others => '0') when others;
                      
    ldb_and_out <= NOT(RD) AND LDB;
    lda_and_out <= RD AND LDA;
    

end rtl_ckt;
