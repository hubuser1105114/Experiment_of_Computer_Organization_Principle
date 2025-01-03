library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity PC is
port( 
     clk,PCjmp,PCc1,PCinc,PCc3,reset:in std_logic;
     CONTRalu  :in std_logic_vector(3 downto 0);
     MBR_PC   :in std_logic_vector(7 downto 0);
     PCout      :buffer std_logic_vector(7 downto 0)
	  );
end PC;
architecture behave of PC is
begin
  process(clk)
  begin
    if(clk'event and clk='0')then
      if reset='1' then
         if CONTRalu="0101" then
           if PCjmp='1' then            PCout<=MBR_PC;
            elsif PCjmp='0' then PCout<=PCout+1;
           end if;
         end if;
         if PCc1='1' then          PCout<="00000000";       end if;
         if PCinc='1' then          PCout<=PCout+1;         end if;
         if PCc3='1' then          PCout<=MBR_PC;         end if;
      else PCout<="00000000";
      end if;
    end if;
  end process;
end behave;