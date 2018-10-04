----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.12.2016 14:50:42
-- Design Name: 
-- Module Name: GAME_OVER - Behavioral
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

entity GAME_OVER is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in STD_LOGIC;
           Y_POSITION : in STD_LOGIC;
           G_EN : out STD_LOGIC);
end GAME_OVER;

architecture Behavioral of GAME_OVER is

begin
u1: process(clk)
begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
    G_EN <= '0';
    end if;
end if;
end process;


end Behavioral;
