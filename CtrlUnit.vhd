----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2019 03:02:37 PM
-- Design Name: 
-- Module Name: CtrlUnit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CtrlUnit is
 port(instr: in std_logic_vector(15 downto 0);
 RegDst: out std_logic;
 ExtOp: out std_logic;
 ALUSrc: out std_logic;
 Branch: out std_logic;
 Jump: out std_logic;
 ALUOp: out std_logic_vector(2 downto 0);
 MemWrite: out std_logic;
 MemtoReg: out std_logic;
 RegWrite: out std_logic;
 bEqZ: out std_logic);
end CtrlUnit;

architecture Behavioral of CtrlUnit is

begin


process(instr(15 downto 13))
begin
case instr(15 downto 13) is
when "000"=>RegDst<='1';----------R-type
            ExtOp<='0';
            ALUSrc<='0';
            Branch<='0';
            Jump<='0';
            ALUOp<="000";
            MemWrite<='0';
            MemtoReg<='0';
            RegWrite<='1';
            bEqz<='0';
     when "001"=>RegDst<='0';---------addi
                 ExtOp<='1';
                 ALUSrc<='1';
                 Branch<='0';
                 Jump<='0';
                 ALUOp<="001";
                 MemWrite<='0';
                 MemtoReg<='0';
                 RegWrite<='1';
                 bEqz<='0';
    when "010"=>RegDst<='0';--------lw
                ExtOp<='1';
                ALUSrc<='1';
                Branch<='0';
                Jump<='0';
                ALUOp<="010";
                MemWrite<='0';
                MemtoReg<='1';
                RegWrite<='1'; 
                bEqz<='0';
     when "011"=>RegDst<='0';------------sw
                 ExtOp<='1';
                 ALUSrc<='1';
                 Branch<='0';
                 Jump<='0';
                 ALUOp<="000";
                 MemWrite<='1';
                 MemtoReg<='0';
                 RegWrite<='0';  
                 bEqz<='0';
   when "100"=>RegDst<='0';------------beq
               ExtOp<='1';
               ALUSrc<='0';
               Branch<='1';
               Jump<='0';
               ALUOp<="100";
               MemWrite<='0';
               MemtoReg<='0';
               RegWrite<='0'; 
               bEqz<='0';  
     when "101"=>RegDst<='0';------------xori
                             ExtOp<='1';
                             ALUSrc<='1';
                             Branch<='0';
                             Jump<='0';
                             ALUOp<="101";
                             MemWrite<='0';
                             MemtoReg<='0';
                             RegWrite<='1'; 
                             bEqz<='0'; 
    when "110"=>RegDst<='0';------------bltz
                                           ExtOp<='1';
                                           ALUSrc<='0';
                                           Branch<='0';
                                           Jump<='0';
                                           ALUOp<="110";
                                           MemWrite<='0';
                                           MemtoReg<='0';
                                           RegWrite<='0';
                                           bEqz<='0';
     when "111"=>RegDst<='0';------------jmp
                                            ExtOp<='0';
                                            ALUSrc<='0';
                                            Jump<='1';
                                            ALUOp<="111";
                                            MemWrite<='0';
                                            MemtoReg<='0';
                                            RegWrite<='0';  
                                            bEqz<='0';    
    when others=>RegDst<='0';
                              ExtOp<='0';
                              ALUSrc<='0';
                              Branch<='0';
                              Jump<='0';
                              ALUOp<="111";
                              MemWrite<='0';
                              MemtoReg<='0';
                              RegWrite<='0';  
                              bEqz<='0';               
 end case;
 end process;
end Behavioral;
