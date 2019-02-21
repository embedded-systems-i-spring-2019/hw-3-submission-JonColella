library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h3p1 is
    port (A, B : in std_logic_vector (7 downto 0 );
          LDA, SEL, CLK : in std_logic;
          F : out std_logic_vector (7 downto 0));
end h3p1;

architecture rtl_ckt of h3p1 is
    signal mux_result : std_logic_vector (7 downto 0);
begin
    
    with SEL select
    mux_result <= A when '1',
                  B when '0',
              (others => '0') when others;
    
    reg: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                F <= mux_result;
            end if;
        end if;
    end process;

end rtl_ckt;
