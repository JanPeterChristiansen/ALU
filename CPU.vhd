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
	signal PROG : ram_type := (X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00",
										X"00", X"00", X"00", X"00", X"00", X"00", X"00", X"00");
										

-- ALU control signals

	signal ALUControlBus : STD_LOGIC_VECTOR (5 downto 0) := "000000";
	signal ALUcarry		: STD_LOGIC;
	
	
-- CPU registers and busses
	
	signal PC 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- program counter
	signal A 		: STD_LOGIC_VECTOR (7 downto 0) := x"0a"; 	-- A BUS
	signal B 		: STD_LOGIC_VECTOR (7 downto 0) := x"03"; 	-- B BUS
	signal C 		: STD_LOGIC_VECTOR (7 downto 0) := x"00"; 	-- C BUS
	signal cmd 		: STD_LOGIC_VECTOR (7 downto 0) := x"05"; 	-- current operation command
	
begin

-- connect output to LEDs
LED <= C;


-- connect cmd til PROG
-- cmd <= PROG(conv_integer(PC));


-- ALU controller
ALUController : entity work.ALUController
	Port Map(
		FUNC 		=> cmd,
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
		F(0)		=> ALUControlBus(5),
		F(1)		=> ALUControlBus(4),
		OUTPUT	=> C,
		CARRY		=> ALUcarry
	);







end Behavioral;

