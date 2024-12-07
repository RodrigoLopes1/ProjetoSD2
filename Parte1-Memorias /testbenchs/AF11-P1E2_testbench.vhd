library IEEE;
use IEEE.numeric_bit.all;
use IEEE.std_logic_1164.all;
use std.textio.all;

entity tb_rom_arquivo is
end tb_rom_arquivo;

architecture behavior of tb_rom_arquivo is
    -- Sinal para a instância do ROM
    signal addr : bit_vector(4 downto 0);
    signal data : bit_vector(7 downto 0);
    
    -- Tipo para armazenar os dados do arquivo .dat
    type memory_t is array (0 to 31) of bit_vector(7 downto 0);
    signal memory : memory_t;

    -- Componente rom_arquivo
    component rom_arquivo is
        port (
            addr : in bit_vector(4 downto 0);
            data : out bit_vector(7 downto 0)
        );
    end component;
    
begin
    -- Instancia o ROM
    uut: rom_arquivo
        port map (
            addr => addr,
            data => data
        );

    -- Processo de inicialização e comparação
    process
        -- Variáveis para manipulação do arquivo
        file data_file : text open read_mode is "conteudo_rom_af11_p1e2_carga.dat";
        variable linha : line;
        variable expected_data : bit_vector(7 downto 0);
        variable i : integer := 0;
    begin
        for i in 0 to 31 loop
            readline(data_file, linha);
            read(linha, expected_data);

            -- Definir o endereço de teste
            addr <= bit_vector(to_unsigned(i, 5));

            -- Aguardar um ciclo de clock
            wait for 10 ns;

            -- Comparar a saída com o esperado
            if data = expected_data then
                report "Test passed for address " & integer'image(i) severity note;
            else
                report "Test failed for address " & integer'image(i) severity error;
            end if;
        end loop;

        -- Encerrar o teste
        wait;
    end process;

end behavior;
