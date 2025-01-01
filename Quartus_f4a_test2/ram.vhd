library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
entity ram is 
    port ( 
        r_w, en, reset: in STD_LOGIC; 
        aBus: in STD_LOGIC_VECTOR(7 downto 0);  ----数据总线输入
        dBus: inout STD_LOGIC_VECTOR(7 downto 0) 
    ); 
end ram; 
architecture ramArch of ram is 
type ram_typ is array(0 to 63) of STD_LOGIC_VECTOR(7 downto 0);    --自定义一个1*1维数组，64行8位
signal ram: ram_typ; 
begin 
  process(
en, reset, r_w, aBus, dBus
) begin 
   if reset = '1' then       --如果复位信号为“1”
    ram(0) <= x"0C";         --load指令                                  --x为16进制
    ram(1) <= x"3D";         --sub指令                                    --为初始值
    ram(2) <= x"2D";         --add指令
    ram(3) <= x"1E";         --store指令
    ram(4) <= x"4D";         --mul(异或)指令
    ram(5) <= x"60";         --求补指令
    ram(6) <= x"5D";         --div(或非)指令
    ram(7) <= x"B8";         --branch指令
    ram(8) <= x"7D";         --and指令
	 ram(9) <= x"8D";         --or指令
	 ram(10) <= x"9C";        --not指令
	 ram(11) <= x"A1";        --halt指令
    ram(12) <=x"05" ;         --数据
	 ram(13) <=x"0B" ;         --数据
	 ram(14) <=x"00" ;
	 elsif r_w = '0' then       --复位信号为“0”，r_w信号为“0”，将dBus存入ram, mem_rw="0",传给r_w,执行store指令
    ram(conv_integer(unsigned(aBus))) <= dBus; 
   end if; 
  end process; 
  dBus <= ram(conv_integer(unsigned(aBus)))           --取ram的数据到dBus
  when reset = '0' and en = '1' and r_w = '1' else    --复位信号为“0”，en为“1”，r_w为“1”
   "ZZZZZZZZ"; 
end ramArch; 