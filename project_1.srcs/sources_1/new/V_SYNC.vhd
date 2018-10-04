----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2016 16:20:39
-- Design Name: 
-- Module Name: V_SYNC - Behavioral
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

entity V_SYNC_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           VS_EN : in STD_LOGIC;
           V_SYNC : out STD_LOGIC;
           Y_POS : out integer range 0 to 287;
           draw : out STD_LOGIC;
           DISP_Y : out STD_LOGIC);
end V_SYNC_1;

architecture Behavioral of V_SYNC_1 is
begin
u0: process(CLK, RESET, VS_EN)
    variable i: integer range 0 to 287;
    begin
        if(CLK'event and CLK='1') then
            if (RESET = '1') then
                Y_POS <= 0;
                V_SYNC <= '0';
                DISP_Y <= '0';
            else
                if(VS_EN = '1') then
                    if(i < 287) then                
                        i := i+1;
                        Y_POS <= i;
                    else
                        i := 0;
                        Y_POS <= 0;
                    end if;
                end if;
                if(i < 6) then                  --vertical pulse width 6
                    V_SYNC <= '0';
                else
                    V_SYNC <= '1';
                end if;
            end if;
            if(i > 10) and (i < 283) then       --back porch = 4, front porch = 5, display length is 272
                DISP_Y <= '1';
            else
                DISP_Y <= '0';
                
            end if;
        end if;
end process;           
end Behavioral;
