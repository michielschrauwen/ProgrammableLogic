----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2016 20:05:51
-- Design Name: 
-- Module Name: V_SYNC_TB - Behavioral
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

entity V_SYNC_1_TB is
--  Port ( );
end V_SYNC_1_TB;

architecture Behavioral of V_SYNC_1_TB is

component V_SYNC_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           VS_EN : in STD_LOGIC;
           V_SYNC : out STD_LOGIC;
           Y_POS : out  STD_LOGIC_VECTOR(8 downto 0);
           DISP_Y : out STD_LOGIC);
end component;

signal CLK: std_logic;
signal RESET: std_logic;
signal VS_EN: std_logic;
signal V_SYNC: std_logic;
signal Y_POS: STD_LOGIC_VECTOR(8 downto 0);
signal DISP_Y: std_logic;
constant clock_period : time := 8 ns;


begin

u1: V_SYNC_1 port map(CLK => CLK, RESET => RESET, VS_EN => VS_EN, V_SYNC => V_SYNC, Y_POS => Y_POS, DISP_Y => DISP_Y);

u2:process
begin
    CLK<='1';
    wait for clock_period/2;
    CLK<='0';
    wait for clock_period/2;
end process;

u3: process
begin
RESET <= '1';
VS_EN <= '0';
wait for clock_period;
VS_EN <='1';
RESET <= '0';
wait;
end process;
end Behavioral;
