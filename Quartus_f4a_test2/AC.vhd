library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 

entity accumulator is                   ----声明外部实体接口
    port ( 
        clk, en_D, ld, selAlu, reset: in STD_LOGIC; --时钟信号
        aluD: in STD_LOGIC_VECTOR(7 downto 0); 
        dBus: inout STD_LOGIC_VECTOR(7 downto 0); 
        q: out STD_LOGIC_VECTOR(7 downto 0) 
    ); 
end accumulator; 

architecture accArch of accumulator is 
signal accReg: STD_LOGIC_VECTOR(7 downto 0); 

begin 
  process(clk) begin 
   if clk'event and clk = '1' then 
    if reset = '1' then 
     accReg <= "00000000"; 
    elsif ld = '1' and selAlu = '1' then 
     accReg <= aluD; 
    elsif ld = '1' and selAlu = '0' then 
     accReg <= dBus; 
    end if; 
   end if; 
  end process; 
  dBus <= accReg when en_D = '1' else 
     "ZZZZZZZZ"; 
  q <= accReg; 
end accArch;