library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h3p5 is
    port (SL1, SL2, CLK : in std_logic;
          A, B, C : in std_logic_vector (7 downto 0);
          RAX, RBX : out std_logic_vector (7 downto 0));
end h3p5;

architecture rtl_ckt of h3p5 is

signal rega_ld, regb_ld : std_logic;
signal mux_output : std_logic_vector (7 downto 0);

begin

    --decode 2:1
    rega_ld <= SL1;
    regb_ld <= NOT(SL1);
    
    --mux2
    with SL2 select
    mux_output <= C when '0',
                  B when '1',
                  (others => '0') when others;
    
reg_a: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (rega_ld = '1') then
                RAX <= A;
            end if;
        end if;
    end process;
    
    reg_b: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (regb_ld = '1') then
                RBX <= mux_output;
            end if;
        end if;
    end process;
    
end rtl_ckt;
