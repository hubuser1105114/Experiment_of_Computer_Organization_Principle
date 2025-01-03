library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity CONTROLR is
port(
     control :in std_logic_vector(31 downto 0);
     R,W, RW, PCc1,PCinc,PCc3:out std_logic;
     ACCclear,MBR_MARc,PC_MARc:out std_logic;
     ACC_MBRc,MBR_OPc,MBR_BRc:out std_logic;
     CONTRout:out std_logic_vector(3 downto 0);
     CARc  :out std_logic_vector(3 downto 0);
     CAR   :out std_logic_vector(7 downto 0));
end CONTROLR;
architecture behave of CONTROLR is
begin
  process(control)
  begin
       CAR<=control(7 downto 0);
       PCc1<=control(8);
       PCinc<=control(9);
       PCc3<=control(10);
       ACCclear<=control(11);
       CONTRout<=control(15 downto 12);
       R<=control(16);
       W<=control(17);
       MBR_MARc<=control(18);
       PC_MARc<=control(19);
       ACC_MBRc<=control(20);
       MBR_OPc<=control(21);
       MBR_BRc<=control(22);
       CARc<=control(26 downto 23);
       RW<=control(17);
end process;
end behave;