library ieee;
use ieee.std_logic_1164.all;

entity BR is
port(
      MBR_BRc:in   std_logic;
       MBR_BR:in   std_logic_vector(15 downto 0);
        BRout:out  std_logic_vector(15 downto 0)
	 );
end BR;
architecture behave of BR is
begin
  process(MBR_BRc)
  begin
       if MBR_BRc='1' then     BRout <= MBR_BR;     
  end if;
  end process;
  end behave;