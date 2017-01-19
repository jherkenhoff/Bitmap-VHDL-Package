library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bmp_source_sink_TB is
end entity;

architecture behavioural of bmp_source_sink_TB is

    constant SOURCE_FILENAME : string := "source.bmp";
    constant SINK_FILENAME : string := "sink.bmp";

    signal clk  : std_logic := '0';
    signal rst  : std_logic := '0';
    signal val  : std_logic := '0';
    signal rdy  : std_logic := '0';
    signal dat  : std_logic_vector(23 downto 0) := (others => '0');
    signal eol  : std_logic := '0';
    signal eof  : std_logic := '0';

begin

    clk <= not clk after 20 ns;

    bmp_source_1 : entity work.bmp_source
        generic map (
            FILENAME => SOURCE_FILENAME,
            ITERATIONS => 1,
            BACKPRESSURE_EN => false
        )
        port map (
            clk_i   => clk,
            rst_i   => rst,

            val_o   => val,
            dat_o   => dat,
            rdy_i   => rdy,
            eol_o   => eol,
            eof_o   => eof
        );

    bmp_sink_1 : entity work.bmp_sink
        generic map (
            FILENAME => SINK_FILENAME
        )
        port map (
            clk_i   => clk,
            rst_i   => rst,

            val_i   => val,
            dat_i   => dat,
            rdy_o   => rdy,
            eol_i   => eol,
            eof_i   => eof,

            halt_i  => '0'
        );


end architecture;
