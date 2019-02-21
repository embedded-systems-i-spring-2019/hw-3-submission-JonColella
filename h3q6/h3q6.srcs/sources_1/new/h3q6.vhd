library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h3q6 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           SEL1 : in STD_LOGIC;
           SEL2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           C : in STD_LOGIC_VECTOR (7 downto 0);
           RAP : out STD_LOGIC_VECTOR (7 downto 0);
           RBP : out STD_LOGIC_VECTOR (7 downto 0));
end h3q6;

architecture rtl_ckt of h3q6 is

signal mux_output : std_logic_vector (7 downto 0);
signal rega_ld, regb_ld : std_logic;

begin

  --mux2
    with SEL1 select
    mux_output <= B when '0',
                  A  when '1',
                  (others => '0') when others;
                     
  --decode 2:1
    rega_ld <= SEL2;
    regb_ld <= NOT(SEL2);

    reg_a: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (rega_ld = '1') then
                RAP <= mux_output;
            end if;
        end if;
    end process;
    
    reg_b: process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (regb_ld = '1') then
                RBP<= C;
            end if;
        end if;
    end process;
end rtl_ckt;
