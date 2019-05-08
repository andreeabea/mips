----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2019 02:24:45 PM
-- Design Name: 
-- Module Name: InstrDecode - Behavioral
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

entity InstrDecode is
port(clk: in std_logic;
RegWrite: in std_logic;
Instr: in std_logic_vector(15 downto 0);
RegDst: in std_logic;
ExtOp: in std_logic;
WD: in std_logic_vector(15 downto 0);
RD1: out std_logic_vector(15 downto 0);
RD2: out std_logic_vector(15 downto 0);
Ext_Imm:out std_logic_vector(15 downto 0);
func: out std_logic_vector(2 downto 0);
sa: out std_logic;
wa: in std_logic_vector(15 downto 0));
end InstrDecode;

architecture Behavioral of InstrDecode is

component reg_file is
port (
clk : in std_logic;
ra1 : in std_logic_vector (2 downto 0);
ra2 : in std_logic_vector (2 downto 0);
wa : in std_logic_vector (2 downto 0);
wd : in std_logic_vector (15 downto 0);
wen : in std_logic;
rd1 : out std_logic_vector (15 downto 0);
rd2 : out std_logic_vector (15 downto 0)
);
end component;
signal mux_out: std_logic_vector(2 downto 0);
signal ex: std_logic_vector(8 downto 0);
signal rs: std_logic_vector(2 downto 0);
signal rt: std_logic_vector(2 downto 0);
signal rd: std_logic_vector(2 downto 0);
begin

rs<=Instr(12 downto 10);
rt<=Instr(9 downto 7);
rd<=Instr(6 downto 4);
reg: reg_file port map(clk,rs,rt,mux_out,WD,RegWrite,rd1,rd2);

--mux: process (RegDst,Instr)
--begin
--case RegDst is
--when '0'=>mux_out<=rt;
--when '1'=>mux_out<=rd;
--end case;
--end process mux;
mux_out<=wa;
func<=Instr(2 downto 0);
sa<=Instr(3);
ex<=(others=>Instr(6));
Ext_Imm<="000000000"&Instr(6 downto 0) when ExtOp='0' else ex&Instr(6 downto 0);

end Behavioral;
