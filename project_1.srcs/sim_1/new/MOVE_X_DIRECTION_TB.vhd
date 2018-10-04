----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2016 16:19:19
-- Design Name: 
-- Module Name: MOVE_X_DIRECTION_TB - Behavioral
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

entity MOVE_X_DIRECTION_TB is
--  Port ( );
end MOVE_X_DIRECTION_TB;

architecture Behavioral of MOVE_X_DIRECTION_TB is

component MOVE_X_DIRECTION is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE : in STD_LOGIC;
           X_POSITION_OUT : out integer range -240 to 240;
           X_MIN : in STD_LOGIC;
           X_PLUS : in STD_LOGIC);
end component;

signal CLK : STD_LOGIC;
signal RESET : STD_LOGIC;
signal CE : STD_LOGIC;
signal X_POSITION_OUT : integer range -240 to 240;
signal X_MIN : STD_LOGIC;
signal X_PLUS : STD_LOGIC;
constant clock_period : time := 8 ns;

begin

u1: MOVE_X_DIRECTION port map(CLK => CLK, RESET => RESET, CE => CE, X_POSITION_OUT => X_POSITION_OUT, X_MIN => X_MIN, X_PLUS => X_PLUS);

u2:process
begin
    CLK<='1';
    wait for clock_period/2;
    CLK<='0';
    wait for clock_period/2;
end process;

u3:process
begin
    CE <= '0';
    RESET <= '0';
    X_MIN <= '0';
    X_PLUS <= '0';
    wait for clock_period;
        CE <= '1';
        X_PLUS <= '1';
    wait for clock_period*20;
        CE <= '0';
        X_PLUS <= '0';
    wait;
end process;

end Behavioral;
