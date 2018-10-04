----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2016 17:00:18
-- Design Name: 
-- Module Name: move_delay - Behavioral
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

entity move_delay is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           MOVE_CLK : out STD_LOGIC);
end move_delay;

architecture Behavioral of move_delay is

begin
u0:process(CLK, RESET)
variable i : integer range 0 to 800000 := 0;
begin
if(CLK'event and CLK = '1')then
     if(RESET = '1')then
           i := 0;
           MOVE_CLK <= '0';               
     else            
            if i < 800000 then
            i := i + 1;
            else
            i :=0;
            end if;
            if i = 800000 then
            MOVE_CLK <='1';
            else
            MOVE_CLK <='0';
            end if;
     end if;
end if;    
end process;
end Behavioral;
