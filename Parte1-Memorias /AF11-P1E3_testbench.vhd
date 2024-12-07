library IEEE;
use IEEE.numeric_bit.all;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity tb_rom_arquivo_generica is
end tb_rom_arquivo_generica;

architecture test of tb_rom_arquivo_generica is

    -- Parameters to match the entity generics
    constant addressSize : natural := 5;
    constant wordSize : natural := 8;
    constant datFileName : string := "conteudo_rom_af11_p1e2_carga.dat";

    -- Signals to connect to the DUT
    signal addr : bit_vector(addressSize - 1 downto 0) := (others => '0');
    signal data : bit_vector(wordSize - 1 downto 0);

begin

    -- Instantiate the ROM
    DUT: entity work.rom_arquivo_generica
        generic map (
            addressSize => addressSize,
            wordSize => wordSize,
            datFileName => datFileName
        )
        port map (
            addr => addr,
            data => data
        );

    -- Test process
    test_process: process
        variable expected_data : bit_vector(wordSize - 1 downto 0);
        variable line_num : integer := 0;
        file test_file : text open read_mode is datFileName;
        variable test_line : line;
    begin
        report "Starting ROM testbench...";

        -- Loop through all addresses
        for i in 0 to 2**addressSize - 1 loop
            addr <= bit_vector(to_unsigned(i, addressSize));

            -- Read expected data from file
            readline(test_file, test_line);
            read(test_line, expected_data);
            
            -- Wait for data to stabilize
            wait for 20 ns;

            -- Check if the data matches the expected value
            if data /= expected_data then
                report "Mismatch at address" severity error;
            end if;
        end loop;

        -- Finish simulation
        report "Testbench completed successfully.";
        wait;
    end process;

end test;
