----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2019 12:47:17 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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

entity MPG is
port(b: in std_logic;
enable: out std_logic;
clk: in std_logic);
end MPG;

architecture Behavioral of MPG is

component reg is
port(clk: in std_logic;
enable: in std_logic_vector(15 downto 0);
data: in std_logic;
Q: out std_logic);
end component;

signal count: std_logic_vector(15 downto 0):=(others=>'0');
signal s1: std_logic;
signal s2: std_logic;
signal s3: std_logic;

begin

counter: process(clk)
begin
if (rising_edge(clk)) then
    if (count="1111111111111111") then
        count<=(others=>'0');
    else count<=count+1;
    end if;
end if;
end process counter;

reg1: reg port map (clk,count,b,s1);
reg2: reg port map (clk,"1111111111111111",s1,s2);
reg3: reg port map (clk,"1111111111111111",s2,s3);

enable<=s2 and (not(s3));

end Behavioral;
