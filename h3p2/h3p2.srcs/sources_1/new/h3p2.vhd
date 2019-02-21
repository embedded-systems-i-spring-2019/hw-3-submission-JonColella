library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h3p2 is
    Port ( X : in STD_LOGIC_VECTOR (7 downto 0);
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           Z : in STD_LOGIC_VECTOR (7 downto 0);
           DS : in STD_LOGIC;
           MS : in STD_LOGIC_VECTOR (1 downto 0);
           CLK : in STD_LOGIC;
           RA : inout STD_LOGIC_VECTOR (7 downto 0);
           RB : inout STD_LOGIC_VECTOR (7 downto 0));
end h3p2;

architecture rtl_ckt of h3p2 is
    signal ra_ld, rb_ld : std_logic;
    signal mux_out : std_logic_vector (7 downto 0);
begin
    --mux4
    with MS select
    mux_out <= RB when "00",
               Z  when "01",
               Y  when "10",
               X  when "11",
               (others => '0') when others;
               
    --decode 1:2
    ra_ld <= DS;
    rb_ld <= NOT(DS);
               
    reg_a: process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (ra_ld = '1') then
                RA <= mux_out;
            end if;
        end if;
    end process;
    
    reg_b: process(CLK)
    begin
        if (falling_edge(CLK)) then
            if (rb_ld = '1') then
                RB <= RA;
            end if;
        end if;
    end process;

end rtl_ckt;
