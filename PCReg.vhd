----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2019 04:15:51 PM
-- Design Name: 
-- Module Name: PCReg - Behavioral
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

entity PCReg is
port(clk: in std_logic;
reset: in std_logic;
WE: in std_logic;
addr: in std_logic_vector(15 downto 0);
pc: out std_logic_vector(15 downto 0));
end PCReg;

architecture Behavioral of PCReg is

begin

process(clk,addr,WE,reset)
begin
if rising_edge(clk) then
    if reset='1' then
        pc<=(others=>'0');
    elsif WE='1' then
        pc<=addr;
    end if;
end if;
end process;
        


end Behavioral;
