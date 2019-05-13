----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2019 04:57:39 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is

component MPG is
port(b: in std_logic;
enable: out std_logic;
clk: in std_logic);
end component;

component display is
    port(clk: in std_logic;
    digit0: in STD_LOGIC_VECTOR (3 downto 0);
    digit1: in STD_LOGIC_VECTOR (3 downto 0);
    digit2: in STD_LOGIC_VECTOR (3 downto 0);
    digit3: in STD_LOGIC_VECTOR (3 downto 0);
    cat:   out   STD_LOGIC_VECTOR (6 downto 0);
    an: out std_logic_vector(3 downto 0));
end component;

component InstrFetch is
port(clk: in std_logic;
branchAddr: in std_logic_vector(15 downto 0);
jumpAddr: in std_logic_vector(15 downto 0);
PCsrc: in std_logic;
jump: in std_logic;
reset: in std_logic;
WE: in std_logic;
instr: out std_logic_vector(15 downto 0);
PCout: out std_logic_vector(15 downto 0));
end component;

component InstrDecode is
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
wa: in std_logic_vector(2 downto 0));
end component;

component CtrlUnit is
 port(instr: in std_logic_vector(15 downto 0);
 RegDst: out std_logic;
 ExtOp: out std_logic;
 ALUSrc: out std_logic;
 Branch: out std_logic;
 Jump: out std_logic;
 ALUOp: out std_logic_vector(2 downto 0);
 MemWrite: out std_logic;
 MemtoReg: out std_logic;
 RegWrite: out std_logic;
 bEqZ: out std_logic);
end component;

component InstrExecute is
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
end component;

component MemUnit is
port(clk: in std_logic;
MemWrite: in std_logic;
ALUResIn: in std_logic_vector(15 downto 0);
RD2: in std_logic_vector(15 downto 0);
MemData: out std_logic_vector(15 downto 0);
ALUResOut: out std_logic_vector(15 downto 0));
end component;

signal digits: std_logic_vector(15 downto 0);
signal digits1: std_logic_vector(15 downto 0);
signal digits2: std_logic_vector(15 downto 0);
signal RegDst: std_logic;
signal ExtOp: std_logic;
signal ALUSrc: std_logic;
signal Branch: std_logic;
signal Jump: std_logic;
signal ALUOp: std_logic_vector(2 downto 0);
signal MemWrite: std_logic;
signal MemtoReg: std_logic;
signal RegWrite: std_logic;
signal RegWr: std_logic;
signal MemWr: std_logic;
signal WD: std_logic_vector(15 downto 0);
signal RD1: std_logic_vector(15 downto 0);
signal RD2: std_logic_vector(15 downto 0);
signal ext: std_logic_vector(15 downto 0);
signal func: std_logic_vector(2 downto 0);
signal sa: std_logic;
signal bEqZ: std_logic;
signal zero: std_logic;
signal ALURes: std_logic_vector(15 downto 0);
signal branchAddr: std_logic_vector(15 downto 0);
signal btn0: std_logic;
signal btn1: std_logic;
signal s1, s2: std_logic;
signal DMout: std_logic_vector(15 downto 0);
signal jmpAddr: std_logic_vector(15 downto 0);
signal memData: std_logic_vector(15 downto 0);
signal ALUResOut: std_logic_vector(15 downto 0);

signal instrID, pcID, pcEX, rd1EX, rd2EX, extEX, branchAddrMEM, ALUResMEM, rd2MEM, memDataWB, ALUResWB: std_logic_vector(15 downto 0);
signal waEX, funcEX, waMEM, waWB, rtEX, rdEX, mEX, mMEM: std_logic_vector(2 downto 0);
signal wbEX, wbMEM, wbWB: std_logic_vector(1 downto 0);
signal saEX, zeroMEM, rd11MEM: std_logic;
signal exEX: std_logic_vector(4 downto 0);
begin

 debounce1: MPG port map(btn(0), btn0, clk);
 debounce2: MPG port map(btn(1), btn1, clk);

 WD <= ALUResWB when wbWB(1)='0' else memDataWB;
 waEX<=rtEX when exEX(4)='0' else rdEX;

 iff: InstrFetch port map(clk,branchAddrMEM,jmpAddr,s2,Jump,btn0,btn1,digits1,digits2);
 ctrlU: CtrlUnit port map(instrID,RegDst,ExtOp,ALUSrc,Branch,Jump,ALUOp,MemWrite,MemtoReg,RegWrite,bEqZ);
 instrD: InstrDecode port map(clk,RegWr,instrID,RegDst,ExtOp,WD,RD1,RD2,ext,func,sa,waWB);
 InstrExec: InstrExecute port map (pcEX, rd1EX, rd2EX, extEX, funcEX, saEX, exEX(3), exEX(2 downto 0), zero, ALURes, branchAddr);
 MemU: MemUnit port map (clk,MemWr,ALUResMEM,rd2MEM,memData,ALUResOut);
 
 RegWr<=wbWB(0) and btn1;
 MemWr<=mMem(0) and btn1;
 
 s1<=mMEM(2) and rd11MEM;
 s2<=s1 or (MMem(1) and zeroMEM);
 jmpAddr<=pcID(15 downto 14) & instrID(12 downto 0) & '0';
 
 idReg: process(clk,btn1)
     begin
     if rising_edge(clk) then
         if btn1='1' then 
             pcID<=digits2;
             instrID<=digits1;
         end if;
      end if;
  end process idReg;
  
  exReg: process(clk,btn1)
      begin
      if rising_edge(clk) then
         if btn1='1' then
            wbEX(1)<=MemToReg;
            wbEX(0)<=RegWrite;
            mEX(0)<=MemWrite;
            mEX(1)<=Branch;
            mEX(2)<=beqz;
            exEX(2 downto 0)<=ALUOp;
            exEX(3)<=ALUSrc;
            exEX(4)<=RegDst;
            pcEX<=pcID;
            rd1EX<=RD1;
            rd2EX<=RD2;
            extEX<=ext;
            saEX<=sa;
            funcEX<=func;
            rtEX<=instrID(9 downto 7);
            rdEX<=instrID(6 downto 4);
         end if;
       end if;
  end process;
  
  memReg: process(clk,btn1)
        begin
        if rising_edge(clk) then
           if btn1='1' then
              waMEM<=waEX;
              wbMEM<=wbEX;
              mMEM<=mEX;
              branchAddrMEM<=branchAddr;
              zeroMEM<=zero;
              ALUResMEM<=ALURes;
              rd2MEM<=rd2EX;
              rd11MEM<=rd1EX(15);
           end if;
         end if;
    end process;
 
  wbReg: process(clk,btn1)
           begin
           if rising_edge(clk) then
              if btn1='1' then
                wbWB<=wbMEM;
                waWB<=waMEM;
                memDataWB<=memData;
                ALUResWB<=ALUResMEM;
              end if;
            end if;
  end process;
  
 process(sw(7 downto 5))
 begin
 case sw(7 downto 5) is
 when "000"=> digits<=instrID;
 when "001"=> digits<=digits2;
 when "010"=>digits<=RD1;
 when "011"=>digits<=RD2;
 when "100"=>digits<= x"000" & '0' & waWB;
 when "101"=>digits<=ALURes;
 when "111"=>digits<=wd;
 when others=>digits<=ext;
 end case;
 end process;
 
 process(sw(0))
 begin
 case sw(0) is
 when '0'=>led(7 downto 0)<=RegDst&ExtOp&ALUSrc&Branch&Jump&MemWrite&MemtoReg&RegWrite;
          -- led(15)<=wbWb(0);
 when '1'=>led(7 downto 0)<="00000"&ALUOp;
 end case;
 end process;
 
 led(15)<=zero;
 
 displ: display port map (clk, digits(3 downto 0), digits(7 downto 4), digits(11 downto 8), digits(15 downto 12), cat, an);
 
end Behavioral;
