library IEEE; 
use IEEE.std_logic_1164.all; 
entity top_level is                ----声明实体外部接口
    port ( 
        clk, reset:   in  STD_LOGIC; 
        abusX:        out STD_LOGIC_VECTOR(7 downto 0); --数据总线输出
        dbusX:        out STD_LOGIC_VECTOR(7 downto 0); 
        mem_enDX, mem_rwX:  out STD_LOGIC; 
        pc_enAX, pc_ldX, pc_incX: 
out STD_LOGIC; 
        ir_enAX, ir_enDX, ir_ldX:
 out STD_LOGIC; 
        acc_enDX, acc_ldX, acc_selAluX:
 out STD_LOGIC; 
        acc_QX:    out STD_LOGIC_VECTOR(7 downto 0); 
        alu_accZX:   out STD_LOGIC; 
        alu_opX:   out STD_LOGIC_VECTOR(3 downto 0) 
    ); 
end top_level; 
architecture topArch of top_level is 
component program_counter 
    port ( 
        clk, en_A, ld, inc, reset: in STD_LOGIC; 
        aBus: out STD_LOGIC_VECTOR(7 downto 0); 
        dBus: in STD_LOGIC_VECTOR(7 downto 0) 
    ); 
end component; 
component instruction_register 
    port ( 
        clk, en_A, en_D, ld, reset: in STD_LOGIC; 
        aBus: out STD_LOGIC_VECTOR(7 downto 0); 
        dBus: inout STD_LOGIC_VECTOR(7 downto 0); 
        load, store, add, sub,mul,div,neg,andd,orr,nott, halt, branch: out STD_LOGIC 
           ); 
end component; 
component accumulator 
    port ( 
        clk, en_D, ld, selAlu, reset: in STD_LOGIC; 
        aluD: in STD_LOGIC_VECTOR(7 downto 0); 
        dBus: inout STD_LOGIC_VECTOR(7 downto 0); 
        q: out STD_LOGIC_VECTOR(7 downto 0) 
    ); 
end component; 
component alu 
    port ( 
        op: in STD_LOGIC_VECTOR(3 downto 0); 
        accD: in STD_LOGIC_VECTOR(7 downto 0); 
        dBus: in STD_LOGIC_VECTOR(7 downto 0); 
        result: out STD_LOGIC_VECTOR(7 downto 0); 
        accZ: out STD_LOGIC 
    ); 
end component; 

component ram 
    port ( 
        r_w, en, reset: in STD_LOGIC; 
        aBus: in STD_LOGIC_VECTOR(7 downto 0); 
        dBus: inout STD_LOGIC_VECTOR(7 downto 0) 
    ); 
end component; 
component controller 
    port ( 
     clk, reset:   in  STD_LOGIC; 
     mem_enD, mem_rw:   out STD_LOGIC; 
     pc_enA, pc_ld, pc_inc:   out STD_LOGIC; 
     ir_enA, ir_enD, ir_ld:   out STD_LOGIC; 
     ir_load, ir_store, ir_add: in  STD_LOGIC; 
     ir_sub,  ir_mul, ir_div:  in STD_LOGIC;
     ir_and,  ir_or, ir_not: in  STD_LOGIC;
     ir_neg, ir_halt, ir_branch:  in  STD_LOGIC; 
     acc_enD, acc_ld, acc_selAlu:  out STD_LOGIC; 
     alu_op:    out STD_LOGIC_VECTOR(3 downto 0) 
    ); 
end component; 
signal abus: STD_LOGIC_VECTOR(7 downto 0); 
signal dbus: STD_LOGIC_VECTOR(7 downto 0); 
signal mem_enD, mem_rw:   STD_LOGIC; 
signal pc_enA, pc_ld, pc_inc:  STD_LOGIC; 
signal ir_enA, ir_enD, ir_ld:  STD_LOGIC; 
signal ir_load, ir_store, ir_add: STD_LOGIC; 
signal ir_sub,  ir_mul, ir_div: STD_LOGIC;
signal ir_and, ir_or, ir_not: STD_LOGIC;
signal ir_negate, ir_halt, ir_branch: STD_LOGIC; 
signal acc_enD, acc_ld, acc_selAlu: STD_LOGIC; 
signal acc_Q:    STD_LOGIC_VECTOR(7 downto 0); 
signal alu_op:    STD_LOGIC_VECTOR(3 downto 0); 
signal alu_accZ:   STD_LOGIC; 
signal alu_result:   STD_LOGIC_VECTOR(7 downto 0); 
begin 
  pc: program_counter port map(clk, pc_enA, pc_ld, pc_inc, reset, abus, dbus); 
  ir: instruction_register port map(clk, ir_enA, ir_enD, ir_ld, reset, abus,dbus,ir_load,ir_store,ir_add,ir_sub,ir_mul,ir_div,ir_negate,ir_and,ir_or,ir_not, ir_halt, ir_branch ); 
  acc: accumulator port map(clk, acc_enD, acc_ld, acc_selAlu, reset, alu_result, dbus, acc_Q); 
  aluu: alu port map(alu_op, acc_Q, dbus, alu_result, alu_accZ); 
  mem: ram port map(mem_rw, mem_enD, reset, abus, dbus); 
  ctl: controller port map (
clk, reset, mem_enD, mem_rw, pc_enA, pc_ld, pc_inc, 
      ir_enA, ir_enD, ir_ld, ir_load, ir_store, ir_add,ir_sub,
ir_mul,ir_div,ir_and,ir_or,ir_not,
      ir_negate, ir_halt, ir_branch,acc_enD,
 acc_ld, acc_selAlu, alu_op
); 
   abusX <= abus; 
   dbusX <= dbus; 
   mem_enDX <= mem_enD; 
   mem_rwX <= mem_rw; 
   pc_enAX <= pc_enA; 
   pc_ldX <= pc_ld; 
   pc_incX <= pc_inc; 
   ir_enAX <= ir_enA; 
   ir_enDX <= ir_enD; 
   ir_ldX <= ir_ld; 
   acc_enDX <= acc_enD; 
   acc_ldX <= acc_ld; 
   acc_selAluX <= acc_selAlu; 
   acc_QX <= acc_Q; 
   alu_opX <= alu_op; 
   alu_accZX <= alu_accZ;
end topArch;