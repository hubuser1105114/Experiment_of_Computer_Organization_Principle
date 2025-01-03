library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity MBR is
port( 
     clk, reset, MBR_OPc, ACC_MBRc,R,W:in std_logic;
     ACC_MBR :in std_logic_vector(15 downto 0);
     RAM_MBR :in std_logic_vector(15 downto 0);
     MBR_RAM :out std_logic_vector(15 downto 0);
     MBR_BR  :out std_logic_vector(15 downto 0);
     MBR_OP  :out std_logic_vector(7 downto 0);
     MBR_MAR :out std_logic_vector(7 downto 0);
     MBR_PC  :out std_logic_vector(7 downto 0)
	  );
end MBR;
architecture behave of MBR is
begin
  process(clk)
  variable temp:std_logic_vector(15 downto 0);
  begin
    if(clk'event and clk='0')then
     if reset='1' then
       if ACC_MBRc='1' then    temp:=ACC_MBR;   end if;
       if R='1'        then    MBR_BR<=RAM_MBR;     end if;
       if W='1'        then    MBR_RAM<=temp;      end if;
       MBR_MAR<=RAM_MBR(7 downto 0);
       MBR_PC<=RAM_MBR(7 downto 0);
       if MBR_OPc='1' then   MBR_OP<=RAM_MBR(15 downto 8);    end if;
      else MBR_BR<=x"0000";
           MBR_MAR<="00000000";
           MBR_OP<="00000000";
           MBR_PC<="00000000";
      end if;
    end if;
  end process;
end behave;