----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2019 12:42:47 AM
-- Design Name: 
-- Module Name: MemUnit - Behavioral
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

entity MemUnit is
port(clk: in std_logic;
MemWrite: in std_logic;
ALUResIn: in std_logic_vector(15 downto 0);
RD2: in std_logic_vector(15 downto 0);
MemData: out std_logic_vector(15 downto 0);
ALUResOut: out std_logic_vector(15 downto 0));
end MemUnit;

architecture Behavioral of MemUnit is

type memory is array (0 to 7) of std_logic_vector(15 downto 0);
signal mem: memory :=(
x"0001",
x"0002",
x"0003",
x"0004",
x"0005",
x"0006",
others=>x"0000");
begin

process(clk,ALUResIn)
begin
if rising_edge(clk) then
        if MemWrite='1' then
            mem(conv_integer(ALUResIn))<=RD2;
        end if;
     end if;
end process;

MemData<=mem(conv_integer(ALUResIn));
ALUResOut<=ALUResIn;

end Behavioral;
