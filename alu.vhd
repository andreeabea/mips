----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2019 01:24:28 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
port(clk : in STD_LOGIC;
btn : in STD_LOGIC;
sw : in STD_LOGIC_VECTOR (7 downto 0);
digits : out STD_LOGIC_VECTOR (15 downto 0);
zero: out std_logic);
end alu;

architecture Behavioral of alu is

signal count: std_logic_vector(1 downto 0);
signal ext1: std_logic_vector(15 downto 0);
signal ext2: std_logic_vector(15 downto 0);
signal ext3: std_logic_vector(15 downto 0);
signal sum: std_logic_vector(15 downto 0);
signal diff: std_logic_vector(15 downto 0);
signal sleft: std_logic_vector(15 downto 0);
signal sright: std_logic_vector(15 downto 0);
signal di: std_logic_vector(15 downto 0);

begin

counter: process(clk,btn)
begin
if (rising_edge(clk)) then
    if(btn='1') then
        if (count="11") then
            count<=(others=>'0');
        else count<=count+1;
        end if;
    end if;
end if;
end process counter;

ext1<="000000000000"&sw(3 downto 0);
ext2<="000000000000"&sw(7 downto 4);
ext3<="00000000"&sw(7 downto 0);

sum<=ext1+ext2;
diff<=ext1-ext2;
sleft<=ext3(13 downto 0)&"00";
sright<="00"&ext3(15 downto 2);

--digits
mux:process(count)
begin
case count is
    when "00"=>di<=sum;
    when "01"=>di<=diff;
    when "10"=>di<=sleft;
    when "11"=>di<=sright;
end case;
end process mux;

zero<='1' when di=0 else '0';
digits<=di;

end Behavioral;