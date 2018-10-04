----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2016 16:10:59
-- Design Name: 
-- Module Name: Block_1 - Behavioral
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

entity Block_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POSITION : in integer range 0 to 531;
           Y_POSITION : in integer range 0 to 287;
           B_EN : out STD_LOGIC);
end Block_1;

architecture Behavioral of Block_1 is

begin
u1: process(CLK, RESET, X_POSITION, Y_POSITION)
begin
if(CLK'event and CLK='1') then
    if(RESET = '1') then
    B_EN <= '0';
    else
        if((X_POSITION > 145 and X_POSITION <=185) and  (Y_POSITION >= 50 and Y_POSITION <= 75)) then
            B_EN <= '1';
        elsif((X_POSITION > 295 and X_POSITION <=335) and  (Y_POSITION >= 50 and Y_POSITION <= 75)) then
            B_EN <= '1';
        elsif((X_POSITION > 445 and X_POSITION <=485) and  (Y_POSITION >= 50 and Y_POSITION <= 75)) then
            B_EN <= '1';
        elsif((X_POSITION > 70 and X_POSITION <=110) and  (Y_POSITION >= 100 and Y_POSITION <= 125)) then
            B_EN <= '1';
        elsif((X_POSITION > 220 and X_POSITION <=260) and  (Y_POSITION >= 100 and Y_POSITION <= 125)) then
            B_EN <= '1';
        elsif((X_POSITION > 370 and X_POSITION <=410) and  (Y_POSITION >= 100 and Y_POSITION <= 125)) then
            B_EN <= '1';
        else
            B_EN <= '0';
        end if;
    end if;
end if;
end process;

end Behavioral;
