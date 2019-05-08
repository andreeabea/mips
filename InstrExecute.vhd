----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2019 04:31:59 PM
-- Design Name: 
-- Module Name: InstrExecute - Behavioral
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstrExecute is
    Port ( PC : in STD_LOGIC_VECTOR (15 downto 0);
           rd1 : in STD_LOGIC_VECTOR (15 downto 0);
           rd2 : in STD_LOGIC_VECTOR (15 downto 0);
           ext_imm : in STD_LOGIC_VECTOR (15 downto 0);
           func : in STD_LOGIC_VECTOR (2 downto 0);
           sa : in STD_LOGIC;
           ALUSrc : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           zero : out STD_LOGIC;
           ALURes : out STD_LOGIC_VECTOR (15 downto 0);
           branchAddr : out STD_LOGIC_VECTOR (15 downto 0));
end InstrExecute;

architecture Behavioral of InstrExecute is

signal ALUCtrl : STD_LOGIC_VECTOR(2 downto 0);
signal mux_out : STD_LOGIC_VECTOR(15 downto 0);
signal res : STD_LOGIC_VECTOR(15 downto 0);
signal sllv:STD_LOGIC_VECTOR(15 downto 0);

begin

    branchAddr <= PC + ext_imm;
  
    mux_out<=rd2 when ALUSrc='0' else ext_imm; 
    
    ALUControl:
    process(func, ALUOp)
    begin
        case ALUOp is
            when "000" => ALUCtrl<=func; -- R-type
            when "001" => ALUCtrl<="000"; --addi
            when "010" => ALUCtrl<="000"; --lw 
            when "011" => ALUCtrl<="000"; --sw 
            when "100" => ALUCtrl<="001"; --beq 
            when "101" => ALUCtrl<="110"; --xori 
            when "110" => ALUCtrl<="110"; --bltz
            when "111" => ALUCtrl<="110"; --jmp
            when others => ALUCtrl <= "100";
        end case;
    end process;
    
    sllv <= mux_out when rd1 = x"0000" else
                        mux_out(14 downto 0) & "0" when rd1 = x"0001" else
                        mux_out(13 downto 0) & "00" when rd1 = x"0002" else
                        mux_out(12 downto 0) & "000" when rd1 = x"0003" else
                        mux_out(11 downto 0) & "0000" when rd1 = x"0004" else
                        mux_out(10 downto 0) & "00000" when rd1 = x"0005" else
                        mux_out(9 downto 0)  & "000000" when rd1 = x"0006" else
                        mux_out(8 downto 0)  & "0000000" when rd1 = x"0007" else
                        mux_out(7 downto 0)  & "00000000" when rd1 = x"0008" else
                        mux_out(6 downto 0)  & "000000000" when rd1 = x"0009" else
                        mux_out(5 downto 0)  & "0000000000" when rd1 = x"000A" else
                        mux_out(4 downto 0)  & "00000000000" when rd1 = x"000B" else
                        mux_out(3 downto 0)  & "000000000000" when rd1 = x"000C" else
                        mux_out(2 downto 0)  & "0000000000000" when rd1 = x"000D" else
                        mux_out(1 downto 0)  & "00000000000000" when rd1 = x"000E" else
                        mux_out(0)           & "000000000000000" when rd1 = x"000F" else
                        x"0000";

    ALU:
    process(ALUCtrl, rd1, mux_out, sa)
    begin
        case ALUCtrl is
            when "000" => res <= rd1 + mux_out;
            when "001" => res <= rd1 - mux_out;
            when "010" => res <= mux_out(14 downto 0) & '0';
            when "011" => res <= '0' & mux_out(15 downto 1);
            when "100" => res <= rd1 and mux_out;
            when "101" => res <= rd1 or mux_out;
            when "110" => res <= rd1 xor mux_out;
            when "111" => res<=sllv;
            when others => res <= (others => '0');
        end case;
        
        if res = x"0000" then
            zero <= '1';
        else 
            zero <= '0';
        end if;
        
        ALURes <= res;
        
    end process;

end Behavioral;
