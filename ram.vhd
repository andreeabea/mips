----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 05:25:24 PM
-- Design Name: 
-- Module Name: ram - Behavioral
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

entity ram is
 port ( clk : in std_logic;
 we : in std_logic;
 addr : in std_logic_vector(7 downto 0);
 do : out std_logic_vector(15 downto 0));
end ram;

architecture Behavioral of ram is
 type ram_type is array (0 to 7) of std_logic_vector (15 downto 0);
 signal RAM: ram_type :=(
 x"0001", 
 x"0002", 
 x"0003",
 x"0004",
 x"0005",
 x"0006",
 x"0007",
 x"0008");

 signal shifted : std_logic_vector(15 downto 0);
 signal nb : std_logic_vector(15 downto 0);
 
begin

 process (clk)
 begin
 if clk'event and clk = '1' then
    if we = '1' then
        RAM(conv_integer(addr)) <= shifted;
    end if;
 end if;
 end process;
 
 nb<=RAM(conv_integer(addr));
 shifted<=nb(13 downto 0)&"00";
 do<=shifted;
 
end Behavioral;