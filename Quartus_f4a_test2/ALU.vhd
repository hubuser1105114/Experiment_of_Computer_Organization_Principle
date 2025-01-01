library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 

entity alu is                           -----实体声明外部接口
    port ( 
        op: in STD_LOGIC_VECTOR(3 downto 0);   --选择控制运算类型
        accD: in STD_LOGIC_VECTOR(7 downto 0); -- 累加器的8位数据
        dBus: in STD_LOGIC_VECTOR(7 downto 0); -- 数据总线用于运算
        result: out STD_LOGIC_VECTOR(7 downto 0);   --结果的输出
        accZ: out STD_LOGIC 
); 
end alu; 

architecture aluArch of alu is 
begin 
  result <= accD + dBus when op="0010" else           --加法运算
            accD - dBus when op="0011" else           --减法运算
				accD xor dBus when op="0100" else         --异或运算(mul)
				accD nor dBus when op="0101" else         --或非运算(div)
				(not accD)+"00000001"when op="0110"else   --求补运算
				accD and dBus when op="0111"else          --与运算
				accD or  dBus when op="1000"else          --或运算
				not accD      when op="1001"else          --非运算
				"00000000";
 accZ <= not (accD(0) or  accD(1) or  accD(2) or  accD(3) or 
          accD(4) or  accD(5) or  accD(6) or  accD(7)
); 
end aluArch;