----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2016 20:56:48
-- Design Name: 
-- Module Name: CLK_DELAY_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_DELAY_TB is
--  Port ( );
end CLK_DELAY_TB;

architecture Behavioral of CLK_DELAY_TB is

component CLK_DELAY is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC;
           CE_FIX : out STD_LOGIC);
end component;

signal CLK: std_logic;
signal RESET: std_logic;
signal CLK_OUT: std_logic;
signal CE_FIX: std_logic;
constant clock_period : time := 8 ns;

begin

u1: CLK_DELAY port map(CLK => CLK, RESET => RESET, CLK_OUT => CLK_OUT, CE_FIX => CE_FIX);

u2:process
begin
    CLK<='1';
    wait for clock_period/2;
    CLK<='0';
    wait for clock_period/2;
end process;


end Behavioral;
