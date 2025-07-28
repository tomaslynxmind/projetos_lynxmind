class JogoDoGaloLigaPortuguesa
  CLUBES_LINHAS = ["Benfica", "Porto", "Sporting"]
  CLUBES_COLUNAS = ["Braga", "Vitória SC", "Marítimo"]

  JOGADORES = {
    ["Benfica", "Braga"] => ["Pizzi", "André Almeida", "Hassan", "João Teixeira"],
    ["Benfica", "Vitória SC"] => ["Jota", "Rafa Silva", "Florentino Luís"],
    ["Benfica", "Marítimo"] => ["Nuno Gomes", "Luisão"],
    ["Porto", "Braga"] => ["Moussa Marega", "João Moutinho", "Alan", "Otávio"],
    ["Porto", "Vitória SC"] => ["André André", "Ricardo Pereira", "Aboubakar"],
    ["Porto", "Marítimo"] => ["Pepe", "Vítor Baía", "Diogo Valente"],
    ["Sporting", "Braga"] => ["Paulinho", "Ricardo Esgaio", "Wilson Eduardo"],
    ["Sporting", "Vitória SC"] => ["Rochinha", "Miguel Luís", "Pedro Mendes"],
    ["Sporting", "Marítimo"] => ["Rui Patrício", "André Carrillo"]
  }

  def initialize
    @tabuleiro = Array.new(3) { Array.new(3, "-") }
    @jogador_atual = "X"
    @erros = []
  end

  def jogar
    puts " Bem-vindo ao Jogo do Galo da Liga Portuguesa!"
    loop do
      mostrar_tabuleiro
      linha, coluna = escolher_posicao
      clubes = [CLUBES_LINHAS[linha], CLUBES_COLUNAS[coluna]]

      # Busca os jogadores, testando as duas ordens possíveis (ex: ["Benfica","Braga"] ou ["Braga","Benfica"])
      jogadores_possiveis = JOGADORES[clubes] || JOGADORES[clubes.reverse]

      if jogadores_possiveis.nil?
        puts " Não há jogadores que jogaram em #{clubes[0]} e #{clubes[1]}. Escolhe outra posição."
        next
      end

      puts "Quem jogou em #{clubes[0]} e #{clubes[1]}?"
      print "> "
      resposta = gets.chomp.strip

      if jogadores_possiveis.any? { |j| j.downcase == resposta.downcase }
        puts " Correto! Ponto para #{@jogador_atual}!"
        @tabuleiro[linha][coluna] = @jogador_atual
        if venceu?
          mostrar_tabuleiro
          puts "🏆 Jogador #{@jogador_atual} venceu!"
          mostrar_erros
          break
        end
        trocar_jogador
      else
        puts " Errado!"
        @erros << { clubes: clubes, resposta: resposta, certos: jogadores_possiveis }
        trocar_jogador
      end
    end
  end

  def mostrar_tabuleiro
    puts "\n         | Braga | Vitória SC | Marítimo"
    @tabuleiro.each_with_index do |linha, i|
      print "#{CLUBES_LINHAS[i].ljust(9)} | "
      puts linha.join("   | ")
    end
    puts
  end

  def escolher_posicao
    loop do
      puts "Escolhe uma posição (linha e coluna de 1 a 3):"
      print "Linha (1-3): "
      l = gets.to_i - 1
      print "Coluna (1-3): "
      c = gets.to_i - 1
      if l.between?(0, 2) && c.between?(0, 2) && @tabuleiro[l][c] == "-"
        return [l, c]
      else
        puts "  Posição inválida ou já preenchida."
      end
    end
  end

  def trocar_jogador
    @jogador_atual = @jogador_atual == "X" ? "O" : "X"
  end

  def venceu?
    linhas = @tabuleiro
    colunas = @tabuleiro.transpose
    diagonais = [
      [@tabuleiro[0][0], @tabuleiro[1][1], @tabuleiro[2][2]],
      [@tabuleiro[0][2], @tabuleiro[1][1], @tabuleiro[2][0]]
    ]
    (linhas + colunas + diagonais).any? do |linha|
      linha.all? { |celula| celula == @jogador_atual }
    end
  end

  def mostrar_erros
    if @erros.empty?
      puts "\n Parabéns! Nenhum erro durante o jogo!"
    else
      puts "\n Respostas erradas durante o jogo:"
      @erros.each_with_index do |erro, i|
        clubes = erro[:clubes]
        puts "#{i + 1}. Resposta dada: '#{erro[:resposta]}' para clubes: #{clubes[0]} e #{clubes[1]}"
        puts "   Respostas corretas possíveis: #{erro[:certos].join(", ")}"
      end
    end
  end
end

JogoDoGaloLigaPortuguesa.new.jogar
