library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ALU is
port( clk,reset,ACCclear:in std_logic;
     aluCONTR :in std_logic_vector(3 downto 0);
     BR       :in std_logic_vector(15 downto 0);
     PCjmp    :out std_logic;
     ACC      :buffer std_logic_vector(15 downto 0));
end ALU;
architecture behave of ALU is
begin
  process(clk)
  begin
    if(clk'event and clk='0')then
     if reset='0' then ACC<=x"0000";
      else
       if ACCclear='1' then        ACC<=x"0000";       end if;
       if aluCONTR="0011" then   ACC<=BR+ACC;      end if;      --ADD
       if aluCONTR="0100" then   ACC<=ACC-BR;       end if;      --SUB
       if aluCONTR="0110" then   ACC<=ACC and BR;   end if;      --AND
       if aluCONTR="0111" then   ACC<=ACC or BR;    end if;       --OR
       if aluCONTR="1000" then   ACC<=not ACC;      end if;       --NOT
       if aluCONTR="1001" then                                   --SRR
          ACC(14 downto 0)<=ACC(15 downto 1);    ACC(15)<='0';
       end if;
       if aluCONTR="1010" then                                   --SRL
          ACC(15 downto 1)<=ACC(14 downto 0);     ACC(0)<='0';
       end if;
       if aluCONTR="1011" then   ACC <= ACC(7 downto 0)*BR(7 downto 0);       end if;     --MPY
      end if;
     end if;
     if ACC>0 then         PCjmp<='1';
         else PCjmp<='0';
     end if;
  end process;
end behave;