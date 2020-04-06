----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:16:41 03/26/2020 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
    Port ( 
		CLK : in  STD_LOGIC;
		LED : out STD_LOGIC_VECTOR (7 downto 0)
	 );
end CPU;

architecture Behavioral of CPU is

-- program memory

	type ram_type is array (0 to 63) of STD_LOGIC_VECTOR (7 downto 0);
	signal PROG : ram_type := (X"01", X"00", X"03", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00");
										

-- ALU control signals

	signal ALUControlBus 		: STD_LOGIC_VECTOR (5 downto 0) := "000000";
	signal ALUfunc					: STD_LOGIC_VECTOR (7 downto 0) := x"00";
	signal ALUOutputRegister 	: STD_LOGIC_VECTOR (7 downto 0) := x"00";
	signal ALUcarry				: STD_LOGIC := '0';
	
	
-- CPU registers and busses
	
	signal PC 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- program counter
	signal cmd 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- current operation command
	signal A 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- A BUS
	signal B 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- B BUS
	signal C 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- C BUS
	
-- general purpose registers
	type reg_type is array (0 to 3) of STD_LOGIC_VECTOR (7 downto 0);
	signal REG : reg_type := (x"00", x"00", x"00", x"00");
	
-- register control signals
	signal AddressA 	: STD_LOGIC_VECTOR (1 downto 0) := "ZZ";
	signal AddressB 	: STD_LOGIC_VECTOR (1 downto 0) := "ZZ";
	signal AddressC 	: STD_LOGIC_VECTOR (1 downto 0) := "ZZ";

	
begin


-- register multiplexer

-- A 
with AddressA select
	A <= 	REG(0) 	when "00",
			REG(1) 	when "01",
			REG(2) 	when "10",
			REG(3) 	when "11",
			"ZZZZZZZZ" 	when others; 
-- B
with AddressB select
	B <= 	REG(0) 	when "00",
			REG(1) 	when "01",
			REG(2) 	when "10",
			REG(3) 	when "11",
			"ZZZZZZZZ" 	when others; 
-- C 
REG(0) <= C when AddressC = "00" else "ZZZZZZZZ";
REG(1) <= C when AddressC = "01" else "ZZZZZZZZ";
REG(2) <= C when AddressC = "10" else "ZZZZZZZZ";
REG(3) <= C when AddressC = "11" else "ZZZZZZZZ";


-- connect output to LEDs
LED <= C;

-- connect ALU output to C bus
C <= ALUOutputRegister;



-- ALU function decoder
ALUController : entity work.ALUController
	Port Map(
		FUNC 		=> ALUfunc,
		OUTPUT 	=> ALUControlBus
	);


-- ALU mapping
ALU : entity work.EightBitALU
	Port Map(
		A 			=> A,
		B			=> B,
		INVA		=> ALUControlBus(1),
      ENA		=> ALUControlBus(3),
		ENB		=> ALUControlBus(2),
		INC 		=> ALUControlBus(0),
		F(0)		=> ALUControlBus(4),
		F(1)		=> ALUControlBus(5),
		OUTPUT	=> ALUOutputRegister,
		CARRY		=> ALUcarry
	);



-- connect cmd til PROG
cmd <= PROG(conv_integer(PC));

process (CLK)
begin
	if rising_edge(CLK) then
		PC <= PC + 1;
	end if;
end process;

process (cmd,PROG,PC)
begin
	case (cmd) is
		when x"00" => -- NOP
			ALUfunc <= x"00";
			AddressA <= "ZZ";
			AddressB <= "ZZ";
			AddressC <= "ZZ";
		when x"01" => -- LDAi
			ALUfunc <= x"01";
			AddressA <= "ZZ";
			AddressB <= "ZZ";
			A <= PROG(conv_integer(PC + 2));
			B <= x"00";
			AddressC <= PROG(conv_integer(PC + 1))(1 downto 0);
			PC <= PC + 2;
		when others => -- NOP
			ALUfunc <= x"00";
			AddressA <= "ZZ";
			AddressB <= "ZZ";
			AddressC <= "ZZ";
	end case;
end process;






end Behavioral;

