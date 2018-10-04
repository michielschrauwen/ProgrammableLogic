----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2016 16:20:39
-- Design Name: 
-- Module Name: H_SYNC - Behavioral
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

entity H_SYNC_1 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X_POS : out integer range 0 to 531;
           DISP_X : out STD_LOGIC;
           H_SYNC : out STD_LOGIC;
           H_CE : in STD_LOGIC;
           VS_EN : out STD_LOGIC);
end H_SYNC_1;

architecture Behavioral of H_SYNC_1 is

begin
u1:process(CLK, RESET, H_CE)
    variable i : Integer range 0 to 531;
    begin
        if(CLK'event and CLK = '1') then
            if(RESET = '1') then
                i := 0;
                DISP_X <= '0';
                H_SYNC <= '0';
                VS_EN <= '0';
            else
                if(H_CE = '1') then
                
                    if(i < 530) then
                        i := i+1;
                        X_POS <= i;
                    else
                        i := 0;
                        X_POS <= 0;
                    end if;
                end if;
                if(i < 22)  then                    --horizontal pulse width 22
                    H_SYNC <= '0';
                else
                    H_SYNC <= '1';
                end if;
            end if;
            if(i > 42) and (i<523)  then            --back porch = 20, front porch = 8 and display length = 480
                DISP_X <= '1';
            else
                DISP_X <= '0';
            end if;
            if( i =530 and H_CE = '1') then         -- enable V_sync clock enable so that V_SYNC goes up by 1
                VS_EN <= '1';
            else
                VS_EN <= '0';
            end if;
        end if;
    end process;    
end Behavioral;