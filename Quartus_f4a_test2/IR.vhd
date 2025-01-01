library IEEE; 
use IEEE.std_logic_1164.all; 

entity instruction_register is          ----声明实体外部接口
    port ( 
        clk, en_A, en_D, ld, reset: in STD_LOGIC; 
        aBus: out STD_LOGIC_VECTOR(7 downto 0); ----数据总线输出
        dBus: inout STD_LOGIC_VECTOR(7 downto 0); 
        load, store, add, sub,mul,div,andd,orr,nott,neg, halt, branch: out STD_LOGIC 
        ); 
end instruction_register; 

architecture irArch of instruction_register is 
signal irReg: STD_LOGIC_VECTOR(7 downto 0); 
begin 
  process(clk) begin 
   if clk'event and clk = '0' then   -- 下降沿
	if reset = '1' then               -- 复位信号为“1”
     irReg <= "00000000";            
    elsif ld = '1' then              --ld信号为"1"
     irReg <= dBus; 
    end if; 
   end if; 
  end process; 
  aBus <= "0000" & irReg(3 downto 0) when en_A = '1' else 
     "ZZZZZZZZ"; 
  dBus <= "0000" & irReg(3 downto 0) when en_D = '1' else 
     "ZZZZZZZZ"; 
  load    <= '1' when irReg(7 downto 4) = "0000"  else '0'; 
  store   <= '1' when irReg(7 downto 4) = "0001"  else '0'; 
  add     <= '1' when irReg(7 downto 4) = "0010"  else '0'; 
  sub     <= '1' when irReg(7 downto 4) = "0011"  else '0';
  mul     <= '1' when irReg(7 downto 4) = "0100"  else '0';
  div     <= '1' when irReg(7 downto 4) = "0101"  else '0';
  neg     <= '1' when irReg = "0110" & "0000"     else '0'; 
  andd    <= '1' when irReg (7 downto 4) = "0111" else '0';
  orr     <= '1' when irReg (7 downto 4) = "1000" else '0';
  nott    <= '1' when irReg (7 downto 4) = "1001" else '0';
  halt    <= '1' when irReg = "1010" & "0001"     else '0'; 
  branch  <= '1' when irReg(7 downto 4) = "1011"  else '0'; 

end irArch; 