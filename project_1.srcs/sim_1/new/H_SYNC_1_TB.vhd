----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2016 20:26:39
-- Design Name: 
-- Module Name: H_SYNC_1_TB - Behavioral
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

entity H_SYNC_1_TB is
--  Port ( );
end H_SYNC_1_TB;

architecture Behavioral of H_SYNC_1_TB is

component H_SYNC_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POS : out STD_LOGIC_VECTOR(9 downto 0);
           DISP_X : out STD_LOGIC;
           H_SYNC : out STD_LOGIC;
           H_CE : in STD_LOGIC;
           VS_EN : out STD_LOGIC);
end component;

signal CLK: std_logic;
signal RESET: std_logic;
signal X_POS: STD_LOGIC_VECTOR(9 downto 0);
signal DISP_X: std_logic;
signal H_SYNC: std_logic;
signal H_CE: std_logic;
signal VS_EN: std_logic;
constant clock_period : time := 8 ns;

begin

u1: H_SYNC_1 port map(CLK => CLK, RESET => RESET, X_POS => X_POS, DISP_X => DISP_X, H_SYNC => H_SYNC, H_CE => H_CE, VS_EN => VS_EN);

u2:process
begin
    CLK<='1';
    wait for clock_period/2;
    CLK<='0';
    wait for clock_period/2;
end process;

u3:process
begin
RESET <= '1';
H_CE <= '0';
wait for clock_period;
H_CE <='1';
RESET <= '0';
wait;
end process;

end Behavioral;
