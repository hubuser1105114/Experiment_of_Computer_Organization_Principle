library IEEE; 
use IEEE.std_logic_1164.all; 
entity controller is                       ----声明实体外部接口
    port ( 
     clk, reset: in  STD_LOGIC; 
     mem_enD, mem_rw:   out STD_LOGIC; 
     pc_enA, pc_ld, pc_inc:   out STD_LOGIC; 
     ir_enA, ir_enD, ir_ld:   out STD_LOGIC; 
     ir_load, ir_store, ir_add: in  STD_LOGIC; 
     ir_sub,ir_mul,ir_div:  in STD_LOGIC;
     ir_and,ir_or, ir_not:  in STD_LOGIC;
     ir_neg, ir_halt, ir_branch:  in  STD_LOGIC; 
     acc_enD, acc_ld, acc_selAlu:  out STD_LOGIC; 
     alu_op:    out STD_LOGIC_VECTOR(3 downto 0) 
    ); 
end controller; 
architecture controllerArch of controller is 
type state_type is ( reset_state, 
   fetch0, fetch1, 
   load0, load1, 
   store0, store1, 
   add0, add1, 
   sub0, sub1,
   mul0, mul1,
   div0, div1,
   and0, and1,
   or0,  or1,
   not0, not1,
   negate0, negate1, 
   halt, 
   branch0, branch1 
   ); 
signal state: state_type; 
begin 
  process(clk) begin 
  if clk'event and clk = '1' then              --时钟信号出现上升沿
	if reset = '1' then state <= reset_state;   --复位信号为“1”，那么state为reset_state(0)
	else                                        --复位信号为“0”
       case state is 
       when reset_state => state <= fetch0; 
       when fetch0      => state <= fetch1; 
       when fetch1      => 
         
			if ir_load    = '1' then state <= load0; 
      elsif ir_store   = '1' then state <= store0; 
      elsif ir_add     = '1' then state <= add0; 
      elsif ir_sub     = '1' then state <= sub0;
      elsif ir_mul     = '1' then state <= mul0;
      elsif ir_div     = '1' then state <= div0;
      elsif ir_and     = '1' then state <= and0;
      elsif ir_or      = '1' then state <= or0;
      elsif ir_not     = '1' then state <= not0; 
      elsif ir_neg     = '1' then state <= negate0; 
      elsif ir_halt    = '1' then state <= halt; 
      elsif ir_branch  = '1' then state <= branch0; 
      end if; 
     when load0 =>  state <= load1; 
     when load1 =>  state <= fetch0; 
     when store0 =>  state <= store1; 
     when store1 => state <= fetch0; 
     when add0 =>  state <= add1; 
     when add1 =>  state <= fetch0; 
     when sub0 =>  state <= sub1;
     when sub1 =>  state <= fetch0;
     when mul0 =>  state <= mul1;
     when mul1 =>  state <=fetch0;
     when div0 =>  state <=div1;
     when div1 =>  state <=fetch0;
     when and0 =>  state <=and1;
     when and1 =>  state <=fetch0;
     when or0  =>  state <=or1;
     when or1  =>  state <=fetch0;
     when not0 =>  state <=not1;
     when not1 =>  state <=fetch0;
     when negate0 => state <= negate1; 
     when negate1 => state <= fetch0; 
     when halt =>  state <= halt; 
     when branch0 => state <= branch1; 
     when branch1 => state <= fetch0; 
     when others =>  state <= halt; 
     end case; 
    end if; 
   end if; 
  end process; 
  process(clk) begin -- special process for memory write timing 
   if clk'event and clk = '0' then 
    if state = store0 then 
     mem_rw <= '0'; 
    else 
     mem_rw <= '1'; 
    end if; 
   end if; 
  end process; 
  mem_enD <= '1'   when state =  fetch0 or state =  fetch1 or 
     state =   load0 or state =   load1 or 
     state =    add0 or state =    add1 or
     state =    sub0 or state =    sub1 or
     state =    mul0 or state =    mul1 or
     state =    div0 or state =    div1 or
     state =    and0 or state =    and1 or
     state =    or0  or state =    or1 else '0'; 
  pc_enA <= '1'    when state =  fetch0 or
          state = fetch1   else '0'; 
  pc_ld <= '1'    when state = branch0  
       else '0'; 
  pc_inc <= '1'    when state = fetch1 
       else '0'; 
  ir_enA <= '1'    when state = load0 or 
     state = load1 or state = store0 or
     state =  store1 or state =  add0 or 
     state =  add1 or   state =    sub0 or 
     state =    sub1 or state =    mul0 or
     state =    mul1 or state =    div0 or
     state =    div1 or state =    and0 or
     state =    and1 or state =    or0  or
     state =    or1        else '0'; 

	  --   控制PC能否输出到aBus

  ir_enD <= '1'    when state = branch0  
       else '0'; 
  ir_ld <= '1'    when state = fetch1 
       else '0'; 
  acc_enD <= '1'   when state =  store0 or state =  store1  else '0'; 
  acc_ld <= '1'    when state =  load1 or state =   add1 or state = negate1  
                   or state =  sub1 or state = mul1 or state = div1
                   or state = and1 or state = or1 or state = not1  else '0'; 
  acc_selAlu <='1' when state = add1 or state = negate1 or state =  sub1 or 
                    state = mul1 or state = div1  or state = and1 or
                    state = or1 or state = not1  else '0'; 
  alu_op <= "0010" when state = add0 or state = add1 
       else "0011" when state = sub0 or state = sub1
       else "0100" when state = mul0 or state = mul1
       else "0101" when state = div0 or state = div1
       else "0110" when state = negate0 or state = negate1
       else "0111" when state = and0 or state = and1
       else "1000" when state = or0 or state = or1
       else "1001" when state = not0 or state = not1
		 else "0000";
       
  --alu_op <= "01"   when state =  add0 or state =  add1  else "00"; 
end controllerArch; 