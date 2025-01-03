library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity IR is
port(  opcode  :in std_logic_vector(7 downto 0);
       IRout   :out std_logic_vector(7 downto 0));
end IR;
architecture behave of IR is
begin
    IRout<=opcode;
end behave;