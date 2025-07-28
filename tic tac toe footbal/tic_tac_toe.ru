# tic_tac_toe_futebol.rb

class JogoDoGaloFutebol
  CLUBES_LINHAS = ["Real Madrid", "Manchester United", "AC Milan"]
  CLUBES_COLUNAS = ["Chelsea", "Juventus", "Bayern Munich"]

  JOGADORES = {
   players = {
  [players = {
  ["Real Madrid", "Chelsea"] => [
    "Mateo Kovačić",
    "Eden Hazard",
    "Claude Makélélé",
    "Nicolas Anelka",
    "Ricardo Carvalho",
    "Michael Essien",
    "Lassana Diarra"
  ],

  ["Real Madrid", "Juventus"] => [
    "Cristiano Ronaldo",
    "Álvaro Morata",
    "Zinedine Zidane",
    "Sami Khedira",
    "Fabio Cannavaro",
    "Emerson",
    "Luis del Sol",
    "Danilo"
  ],

  ["Real Madrid", "Bayern Munich"] => [
    "Xabi Alonso",
    "Toni Kroos",
    "James Rodríguez",
    "Arjen Robben",
    "Hamit Altıntop"
  ],

  ["Manchester United", "Chelsea"] => [
    "Juan Mata",
    "Romelu Lukaku",
    "Radamel Falcao",
    "Nemanja Matić",
    "Mark Bosnich",
    "Mark Hughes",
    "Paul Parker",
    "Juan Sebastián Verón",
    "Jadon Sancho"
  ],

  ["Manchester United", "Juventus"] => [
    "Paul Pogba",
    "Carlos Tevez",
    "Cristiano Ronaldo",
    "Zlatan Ibrahimović",
    "Patrice Evra",
    "Edwin van der Sar"
  ],

  ["Manchester United", "Bayern Munich"] => [
    "Bastian Schweinsteiger",
    "Owen Hargreaves",
    "Mark Hughes",
    "Marcel Sabitzer"
  ],

  ["AC Milan", "Chelsea"] => [
    "Andriy Shevchenko",
    "Fernando Torres",
    "Michael Essien",
    "Alexandre Pato",
    "Marcel Desailly",
    "Ruud Gullit",
    "George Weah",
    "Winston Bogarde",
    "Christian Panucci",
    "Carlo Cudicini",
    "Sam Dalla Bona",
    "Hernán Crespo",
    "Thiago Silva",
    "Olivier Giroud",
    "Fikayo Tomori",
    "Rúben Loftus‑Cheek"
  ],

  ["AC Milan", "Juventus"] => [
    "Leonardo Bonucci",
    "Andrea Pirlo",
    "Filippo Inzaghi",
    "Zlatan Ibrahimović"
  ],

  ["AC Milan", "Bayern Munich"] => [
    "Mario Mandžukić",
    "Zvonimir Boban",
    "Christian Ziege",
    "Massimo Oddo"
  ]
}

players.each do |clubs, names|
  puts "\n#{clubs[0]} & #{clubs[1]}:"
  names.each { |player| puts "  - #{player}" }
end

  ]
}
  }

  def initialize
    @tabuleiro = Array.new(3) { Array.new(3, "-") }
    @jogador_atual = "X"
  end

  def jogar
    puts "🎮 Bem-vindo ao Tic Tac Toe dos Jogadores de Futebol!"
    loop do
      mostrar_tabuleiro
      linha, coluna = escolher_posicao
      clubes = [CLUBES_LINHAS[linha], CLUBES_COLUNAS[coluna]]
      jogador_esperado = JOGADORES[clubes]

      puts " Quem jogou em #{clubes[0]} e #{clubes[1]}?"
      print "> "
      resposta = gets.chomp.strip

      if resposta.downcase == jogador_esperado.downcase
        puts " Correto! Ponto para #{@jogador_atual}!"
        @tabuleiro[linha][coluna] = @jogador_atual
        if venceu?
          mostrar_tabuleiro
          puts " Jogador #{@jogador_atual} venceu!"
          break
        end
        trocar_jogador
      else
        puts " Errado! A resposta era: #{jogador_esperado}"
        trocar_jogador
      end
    end
  end

  def mostrar_tabuleiro
    puts "\n   | Chelsea | Juventus | Bayern"
    @tabuleiro.each_with_index do |linha, i|
      print "#{CLUBES_LINHAS[i][0..2]} | "
      puts linha.join("   | ")
    end
    puts
  end

  def escolher_posicao
    loop do
      puts " Escolhe uma posição (linha e coluna de 1 a 3):"
      print "Linha (1-3): "
      l = gets.to_i - 1
      print "Coluna (1-3): "
      c = gets.to_i - 1
      if l.between?(0, 2) && c.between?(0, 2) && @tabuleiro[l][c] == "-"
        return [l, c]
      else
        puts " Posição inválida ou já preenchida."
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
end

JogoDoGaloFutebol.new.jogar
  