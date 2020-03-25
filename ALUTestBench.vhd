--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:59:35 03/25/2020
-- Design Name:   
-- Module Name:   C:/Users/japem/Documents/VHDL/MicroArchitecture/ALUTestBench.vhd
-- Project Name:  MicroArchitecture
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FourBitALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALUTestBench IS
END ALUTestBench;
 
ARCHITECTURE behavior OF ALUTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FourBitALU
    PORT(
         CLK : IN  std_logic;
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         INVA : IN  std_logic;
         ENA : IN  std_logic;
         ENB : IN  std_logic;
         INC : IN  std_logic;
         F : IN  std_logic_vector(1 downto 0);
         OUTPUT : OUT  std_logic_vector(3 downto 0);
         CARRY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');
   signal INVA : std_logic := '0';
   signal ENA : std_logic := '0';
   signal ENB : std_logic := '0';
   signal INC : std_logic := '0';
   signal F : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal OUTPUT : std_logic_vector(3 downto 0);
   signal CARRY : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FourBitALU PORT MAP (
          CLK => CLK,
          A => A,
          B => B,
          INVA => INVA,
          ENA => ENA,
          ENB => ENB,
          INC => INC,
          F => F,
          OUTPUT => OUTPUT,
          CARRY => CARRY
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
