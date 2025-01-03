library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity CAR is
port( clk,reset :in std_logic;
     CARc  :in std_logic_vector(3 downto 0);
     CAR,OP   :in std_logic_vector(7 downto 0);
     CARout:buffer std_logic_vector(7 downto 0));
end CAR;
architecture behave of CAR is
begin
  process(clk)
  begin
    if(clk'event and clk='1')then
     if reset='1' then
      if CARc="1000" then         CARout<="00000000";       end if;
      if CARc="0100" then         CARout<=OP+CARout;        end if;
      if CARc="0010" then         CARout<=CAR;              end if;
      if CARc="0001" then         CARout<=CARout+1;         end if;
     else CARout<="00000000";
     end if;
    end if;
 end process;
end behave;