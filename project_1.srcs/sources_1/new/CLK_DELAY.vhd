----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2016 17:10:00
-- Design Name: 
-- Module Name: CLK_DELAY - Behavioral
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

--Clock delay for display
entity CLK_DELAY is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC;
           CE_FIX : out STD_LOGIC);
end CLK_DELAY;

architecture Behavioral of CLK_DELAY is

begin
u0:process(CLK, RESET)
    variable i : integer range 0 to 13 := 0;
    begin
    if(CLK'event and CLK = '1')then
         if(RESET = '1')then
               i := 0;
               CLK_OUT <= '0';               
               else            
                if i < 13 then
                i := i + 1;
                else
                i :=0;
                end if;
                if i = 13 then
                CE_FIX<='1';
                else
                CE_FIX<='0';
                end if;
                if(i < 7) then 
                CLK_OUT <= '1';
                else
                CLK_OUT <= '0';
                end if;
         end if;
    end if;    
   end process;
end Behavioral;