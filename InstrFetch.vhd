----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2019 04:24:32 PM
-- Design Name: 
-- Module Name: InstrFetch - Behavioral
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

entity InstrFetch is
port(clk: in std_logic;
branchAddr: in std_logic_vector(15 downto 0);
jumpAddr: in std_logic_vector(15 downto 0);
PCsrc: in std_logic;
jump: in std_logic;
reset: in std_logic;
WE: in std_logic;
instr: out std_logic_vector(15 downto 0);
PCout: out std_logic_vector(15 downto 0));
end InstrFetch;

architecture Behavioral of InstrFetch is

component PCReg is
port(clk: in std_logic;
reset: in std_logic;
WE: in std_logic;
addr: in std_logic_vector(15 downto 0);
pc: out std_logic_vector(15 downto 0));
end component;

component rom is
port(clk: in std_logic;
addr: in std_logic_vector(7 downto 0);
digits: out std_logic_vector(15 downto 0)
);
end component;

signal ad: std_logic_vector(15 downto 0);
signal adrom: std_logic_vector(15 downto 0);
signal adder: std_logic_vector(15 downto 0);
signal content: std_logic_vector(15 downto 0);
signal muxout: std_logic_vector(15 downto 0);
begin

pc: PCreg port map(clk,reset,WE,ad,adrom);
romm: rom port map(clk,adrom(7 downto 0),content);
instr<=content;
adder<=adrom+1;
PCout<=adder;

mux1: process(PCsrc)
begin
case PCsrc is
when '0' => muxout<=adder;
when '1'=> muxout<=branchAddr;
when others=>muxout<=(others=>'0');
end case;
end process mux1;

mux2: process(jump)
begin
case jump is
when '0'=> ad<=muxout;
when '1'=> ad<=jumpAddr;
when others=>ad<=(others=>'0');
end case;
end process mux2;

end Behavioral;
