----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:25:06 03/25/2020 
-- Design Name: 
-- Module Name:    FourBitALU - Behavioral 
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

entity EightBitALU is
   Port ( 
		A 			: in  	STD_LOGIC_VECTOR (7 downto 0);
		B 			: in  	STD_LOGIC_VECTOR (7 downto 0);
		INVA 		: in  	STD_LOGIC;  
      ENA 		: in 		STD_LOGIC; 
		ENB 		: in 		STD_LOGIC;
		INC 		: in 		STD_LOGIC;
		F 			: in  	STD_LOGIC_VECTOR (1 downto 0);
		OUTPUT 	: out  	STD_LOGIC_VECTOR (7 downto 0);
		CARRY 	: out 	STD_LOGIC
	);
	
end EightBitALU;

architecture Behavioral of EightBitALU is

	signal QA 	: STD_LOGIC_VECTOR (7 downto 0);
	signal QB 	: STD_LOGIC_VECTOR (7 downto 0);
	signal SUM 	: STD_LOGIC_VECTOR (7 downto 0);

begin

-- selects input
InputSelect : entity work.InputSelect
	Port Map(
		A => A,
		ENA => ENA,
		INVA => INVA,
		B => B,
		ENB => ENB,
		QA => QA,
		QB => QB
	);


-- adds A and B with carry
Adder : entity work.Adder
	Port Map(
		A => QA,
		B => QB,
		INC => INC,
		SUM => SUM,
		CARRY => CARRY
	);


-- selects output
OutputSelect : entity work.OutputSelect
	Port Map(
		A => QA,
		B => QB,
		SUM => SUM,
		F => F,
		OUTPUT => OUTPUT
	);


end Behavioral;

