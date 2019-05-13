----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 02:33:22 PM
-- Design Name: 
-- Module Name: rom - Behavioral
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

entity rom is
port(clk: in std_logic;
addr: in std_logic_vector(7 downto 0);
digits: out std_logic_vector(15 downto 0)
);
end rom;

architecture Behavioral of rom is

type content is array(0 to 255) of std_logic_vector(15 downto 0);
signal mem: content :=(
x"4500", --lw
x"0000",
x"0000",
x"0000",
x"09B0", --add
x"1141", --sub 
x"2481", --addi 
x"8684", --beq
x"0000",
x"0000", 
x"0000",
x"E000", --jmp
x"0000",
x"7980", --sw 
x"7E00", --sw
others => x"0000" );

begin

digits<=mem(conv_integer(addr));

end Behavioral;
