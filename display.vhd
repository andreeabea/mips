----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2019 05:06:10 PM
-- Design Name: 
-- Module Name: display - Behavioral
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

entity display is
    port(clk: in std_logic;
    digit0: in STD_LOGIC_VECTOR (3 downto 0);
    digit1: in STD_LOGIC_VECTOR (3 downto 0);
    digit2: in STD_LOGIC_VECTOR (3 downto 0);
    digit3: in STD_LOGIC_VECTOR (3 downto 0);
    cat:   out   STD_LOGIC_VECTOR (6 downto 0);
    an: out std_logic_vector(3 downto 0));
end display;

architecture Behavioral of display is
signal count: std_logic_vector(15 downto 0):=(others=>'0');
signal HEX: std_logic_vector(3 downto 0):="0000";
begin

--process for counter
counter: process(clk)
begin
if (rising_edge(clk)) then
    if(count="1111111111111111") then
        count<=(others=>'0');
    else count<=count+1;
    end if;
end if;
end process counter;

--processes for the 2 multiplexers
mux1: process(count(15 downto 14))
begin
case count(15 downto 14) is
    when "00" => HEX<=digit0;
    when "01" => HEX<=digit1;
    when "10" => HEX<=digit2;
    when "11" => HEX<=digit3;
end case;
end process mux1;

mux2: process(count(15 downto 14))
begin
case count(15 downto 14) is
    when "00" => an<="1110";
    when "01" => an<="1101";
    when "10" => an<="1011";
    when "11" => an<="0111";
end case;
end process mux2;

--HEX-to-seven-segment decoder
--
-- segment encoinputg
--      0
--     ---
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3

   with HEX SELect
   cat<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "0001000" when "1010",   --A
         "0000011" when "1011",   --b
         "1000110" when "1100",   --C
         "0100001" when "1101",   --d
         "0000110" when "1110",   --E
         "0001110" when "1111",   --F
         "1000000" when others;   --0

end Behavioral;
