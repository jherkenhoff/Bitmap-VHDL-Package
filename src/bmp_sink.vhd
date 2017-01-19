-------------------------------------------------------------------------------
-- File       : bmp_sink.vhd
-- Author     : mr-kenhoff
-------------------------------------------------------------------------------
-- Description:
--      Takes a data stream and saves it to a bitmap image

-- Target: GHDL
-- Dependencies: bmp_pkg.vhd
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bmp_pkg.all;

entity bmp_sink is
    generic (
        FILENAME : string
    );
    port (
        clk_i       : in    std_logic;
        rst_i       : in    std_logic;

        val_i       : in    std_logic;
        dat_i       : in    std_logic_vector(23 downto 0);
        rdy_o       : out   std_logic := '1';
        eol_i       : in    std_logic;
        eof_i       : in    std_logic;

        halt_i      : in    std_logic
    );
end entity;

architecture behavioural of bmp_sink is

begin



    sink_process : process( clk_i )
        variable sink_bmp : bmp_ptr;
        variable sink_pix : bmp_pix;
        variable is_bmp_created : boolean := false;

        variable x : natural := 0;
        variable y : natural := 0;
    begin

        if is_bmp_created = false then
            sink_bmp := new bmp;
            is_bmp_created := true;
        end if;

        if rising_edge( clk_i ) then

            if rst_i = '1' then
                x := 0;
                y := 0;
            else

                if val_i = '1' then
                    sink_pix.r := dat_i(23 downto 16);
                    sink_pix.g := dat_i(15 downto 8);
                    sink_pix.b := dat_i(7 downto 0);
                    bmp_set_pix( sink_bmp, x, y, sink_pix );

                    if eol_i = '1' then
                        if eof_i = '1' then
                            y := 0;
                            bmp_save( sink_bmp, FILENAME );
                        else
                            y := y + 1;
                        end if;
                        x := 0;
                    else
                        x := x + 1;
                    end if;



                end if;
            end if;
        end if;

    end process;


end architecture;
