----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2016 20:28:27
-- Design Name: 
-- Module Name: LCD_TB - Behavioral
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

entity LCD_TB is
--  Port ( );
end LCD_TB;

architecture Behavioral of LCD_TB is

component LCD is
    Port ( RESET : in STD_LOGIC;
           CLK : in STD_LOGIC;
           H_SYNC : out STD_LOGIC;
           V_SYNC : out STD_LOGIC;
           DISP_EN : out STD_LOGIC;
           DCLK: out STD_LOGIC;
           RED : out STD_LOGIC_VECTOR(7 downto 0);
           GREEN : out STD_LOGIC_VECTOR (5 downto 0);
           BLUE : out STD_LOGIC_VECTOR (3 downto 0);
           PWM: out STD_LOGIC;
           GND : out STD_LOGIC);
end component;

signal RESET :  STD_LOGIC;
signal CLK :  STD_LOGIC;
signal H_SYNC :  STD_LOGIC;
signal V_SYNC :  STD_LOGIC;
signal DISP_EN :  STD_LOGIC;
signal DCLK:  STD_LOGIC;
signal RED : STD_LOGIC_VECTOR(7 downto 0);
signal GREEN :  STD_LOGIC_VECTOR (5 downto 0);
signal BLUE :  STD_LOGIC_VECTOR (3 downto 0);
signal PWM:  STD_LOGIC;
signal GND : STD_LOGIC;
constant clock_period : time := 8 ns;

begin

u1: LCD port map(RESET => RESET, CLK => CLK, H_SYNC => H_SYNC, V_SYNC => V_SYNC, DISP_EN => DISP_EN, DCLK => DCLK, RED => RED, GREEN => GREEN, BLUE => BLUE, PWM => PWM, GND => GND);

u2:process
begin
    CLK<='1';
    wait for clock_period/2;
    CLK<='0';
    wait for clock_period/2;
end process;

process
begin
    RESET <= '1';
    wait for 5*clock_period;
    RESET<= '0';
    wait;
end process;


end Behavioral;
