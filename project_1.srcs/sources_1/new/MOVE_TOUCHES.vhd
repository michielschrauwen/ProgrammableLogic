----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.12.2016 17:06:36
-- Design Name: 
-- Module Name: MOVE_TOUCHES - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MOVE_TOUCHES is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_IN : in STD_LOGIC_VECTOR(7 downto 0);
           Y_IN : in STD_LOGIC_VECTOR(7 downto 0);
           LEFT : out STD_LOGIC;
           RIGHT : out STD_LOGIC);
end MOVE_TOUCHES;

architecture Behavioral of MOVE_TOUCHES is

begin
process(CLK)
variable X: integer range 0 to 255 :=0;
variable Y : integer range 0 to 255 := 0;

begin
if(CLK'event and CLK= '1') then
    X:= to_integer(unsigned(X_IN));
    Y:= to_integer(unsigned(Y_IN));

    if(X > 200 and X<240 and Y < 200) then
        RIGHT <= '1';
        LEFT <= '0';
    elsif( X < 50  and Y < 200)  then
        LEFT <= '1';
        RIGHT <= '0'; 
    else
        LEFT <= '0';
        RIGHT <= '0';  
    end if;
end if;
end process;   

end Behavioral;
