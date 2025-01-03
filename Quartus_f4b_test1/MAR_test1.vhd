library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity MAR is
port( 
     clk,PC_MARc,MBR_MARc:in std_logic;
     PC,MBR_MAR:in std_logic_vector(7 downto 0);
     MARout:out std_logic_vector(7 downto 0)
	  );
end MAR;
architecture behave of MAR is
begin
  process(clk)
  begin
    if(clk'event and clk='1')then
       if PC_MARc='1' then      MARout<=PC;           end if;
       if MBR_MARc='1' then     MARout<=MBR_MAR;      end if;
    end if;
  end process;
end behave;