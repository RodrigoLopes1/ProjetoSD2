--Essa parte não ta feita, e infelizmente é a parte mais importante-- 

--5 Implemente os componentes em VHDL correspondentes à
--Memória de Instruções e à Memória de Dados do PoliLEGv8. A
--Memória de Instruções deve ter 256 endereços com palavras de 32
--bits, ao passo que a Memória de Dados deve ter 256 endereços com
--palavras de 64 bits. Cada componente deve respeitar as entidades a seguir.

entity memoriaInstrucoes is
    generic (
        datFileName : string := "conteudo_memInstr_af11_p1e5_carga.dat"
    );
    port (
        addr : in bit_vector(7 downto 0);
        data : out bit_vector(31 downto 0)
    );
end entity memoriaInstrucoes;

entity memoriaDados is
    generic (
        datFileName : string := "conteudo_memDados_af11_p1e5_carga.dat"
    );
    port (
        clk : in bit;
        wr : in bit;
        addr : in bit_vector(7 downto 0);
        data_i : in bit_vector(63 downto 0);
        data_o : out bit_vector(63 downto 0)
    );
end entity memoriaDados;

  
