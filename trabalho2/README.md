# Trabalho Prático 2

*Grupo:* Renpaarden_3

*Turma:* 2

*Realizado por:*
 - Diogo Miguel Chaves dos Santos Antunes Pereira – up201906422
 - Joana Teixeira Mesquita - up201907878

 *Contribuição:* 

 ----
 ## Instalação e Execução:


 ## Descrição do Jogo:

Renpaarden é jogado num tabuleiro de 9 por 9 e cada jogador tem 18 peças colocadas nas últimas duas filas do seu lado do tabuleiro. 

Em cada turno um jogador deve mover uma das suas peças, sendo que estas se movem todas como o cavalo no xadrez (Em L). Se um jogador mover a sua peça para cima de uma peça do adversário ganha um turno extra em que é obrigado a jogar essa peça, continuará a ganhar turnos extra até que a sua peça deixe de estar em cima de uma peça do adversário. 

Ganha o primeiro jogador que conseguir colocar todas as suas peças nas duas filas mais próximas do adversário.

Fontes:
- https://boardgamegeek.com/boardgame/70925/renpaarden
- http://www.di.fc.ul.pt/~jpn/gv/renpaarden.htm


 ## Lógica do Jogo:

 ### play/0

 Este é o predicado que inicia o jogo, e contém não só o tabuleiro (**GameState**) como desenha o logótipo do jogo (**draw_logo**), pergunta ao jogador o modo de jogo que quer usar (**draw_options** e **choose_game_mode(-GameMode)**) e começa o ciclo do jogo em si (**game_cycle(+GameState, +Player, +(X, Y), +RepeatTurn, +GameMode)**)

 ### Representação do estado do jogo
 O jogo é representado pelo tabuleiro (**GameState**), pelo jogador atual (**CurrentPlayer**), por uma variável que indica se o jogador tem direito a um turno extra (**RepeatdTurn**) e pelo modo de jogo escolhido (**GameMode**).

 O tabuleiro é representado por uma lista de listas e cada posição é reqresentada por um tupple sendo as peças do jogador 1 representadas pelo número 1 e as peças do jogador 2 pelo número 2. O primeiro elemento do tuple indica a peça que se encontra no topo, visto que uma posição pode conter mais do que uma peça e o segundo indica se a peça se encontra sozinha na posição. Assim sendo, (0,0) indica uma posição vazia e (1,0) e (2,0) indicam que só se encontram uma peça do jogador 1 ou 2 respetivamente na posição. Por fim, (1,1) ou (2,1) indicam que existem duas peças na posição, estando a peça do jogador 1 ou 2 respetivamente, no topo.

 ### Visualização do Estado do Jogo

 É utilizado o predicado **display_game(+GameState)** que recebe o estado atual do tabuleiro para o imprimir para o ecrã. Como o nosso tabuleiro é representado por tuples, para uma vizualização mais compreensível, o valor da peça que se encontra no topo é convertido num 'x' (peças do jogador 2) ou 'o' (peças do jogador 1) e as posição vazias são substituidas pelo caractere '_'.

 São ainda impridos os indexes das posições em X e Y do tabuleiro, sendo que as posições crescem em X da esquerda para a direita e em Y de cima para baixo.

 Para a escolha da peça a jogar é pedido ao jogador humano que indique a posição em X e Y de uma peça sua e de seguida são calculados os movimentos possíveis da peça, mostrados ao jogador, e este, da lista de posições possiveis, seleciona o index da posição para a qual quer jogar a peça (tendo em atenção que o primeiro elemento da lista tem index 0).

 Para validação dos inputs do utilizador tanto no jogo em sí como no menu inicial é usado *repeat* e *fail* até se obter um input válido.

 No nosso projeto temos disponível apenas um tipo de tabuleiro, 9 por 9.

 ### Execução de jogadas

 Para a execução de jogadas é usado o predicado **move(+GameState, +(X, Y), +(X1, Y1), -NewGameState, +Value, +RepeatTurn, -NewRepeatTurn)** em que:
  - GameState é o tabuleiro do jogo antes da jogada;
  - NewGameState é o tabuleiro do jogo após a jogada;
  - (X,Y) é a posição da peça escolhida pelo jogador (já validada anteriormente);
  - (X1,Y1) é a posição final da peça (já validada anteriormente);
  - RepeatTurn representa se a jogada a ser feita no momento é de um turno extra do jogador;
  - NewRepeatTurn representa se o jogador terá direito a repetir o turno após a jogada;
  - Value representa o valor a colocar na posição nova, ou seja, 1 ou 2 dependendo do jogador a que a peça pertence.

 Dentro deste predicado é em primeiro lugar usado o predicado auxiliar **check_pos/3** no tabuleiro que devolve o valor de um elemento num certo index na lista, para obter o tuple na posição da peça que queremos mover, sendo este colocado em *(OldValue, Repeated)*.

 A partir deste tuple decidimos o que é colocado nesta posição, agora que a peça do jogador foi removida. Se o tuple só tiver uma peça é colocado a zeros, caso contrário é colocada no topo a peça que anteriormente se encontrava em baixo da peça jogada e é colocado a zero o valor que indica que existe mais que uma peça.

 De seguida é feito o mesmo para a nova posição da peça, sendo verificado com **check_pos/3** o tuple nesta posição e escolhido o seu conteudo final consoante o facto de este se encontrar ocupado ou não.

  ### Final do Jogo

  Para finalização do jogo é chamado o predicado **game_over(+GameState, -Winner)** responsável por, após cada jogada, verificar se algum dos jogadores ganhou o jogo, para isto ele apenas compara o estado do tabuleiro do jogo com os dois estados de vitória possiveis e, se algum destes se verificar, coloca o número de jogador na variável winner para ser passado para fora.

  Na função **game_cycle(+GameState, +CurrentPlayer, +(X, Y), +RepeatTurn, +GameMode)** responsável pelo flow do jogo, se o predicado **game_over/2** tiver o valor de *Winner* definido, esta em vez de chamar o turno do próximo jogador, chama os predicados **announce_winner(+Winner)** e **play_again**, anunciando o vencedor do jogo e perguntando ao jogador se este quer voltar a jogar ou se quer terminar o jogo. Caso contrário a função continuará a dar turnos aos jogadores.

  ### Lista de Jogadas Válidas

  A obtenção da lista de Jogadas Válidas é feita no predicado **check_valid_position(+GameState, -(X, Y), -(X1, Y1), +Player, +RepeatTurn)** que primeiro pede ao jogador a posição em X e em Y da peça que quer mover verificando se é uma posição válida e se a peça lhe pertence no predicado **validate_input(+GameState, +(X, Y), +Player))** e de seguida, calcula todas as jogadas válidas a partir dessa posição.

  Para criar a lista de jogadas válidas é utilizado o predicado **valid_moves(+GameState, +X, +Y, +Player, -ListOfMoves, -ArrayLength)**. Este começa por calcular todos os resultados de movimentos em L da peça na posição (X,Y) colocando-os em **PossibleMoves**. Como esta lista pode conter posições em que já existe uma peça do jogador que está a jogar e posições fora do tabuleiro, que são movimentos inválidos, é de seguida chamado o predicado **validate_moves(+GameState, +Player, +PossibleMoves, -ListOfMoves)** que colocará em **ListOfMoves** os elementos da lista **PossibelMoves** que constituem posições válidas, sendo estas avaliadas pelo predicado **validate_move(+GameState, +Player, +(X, Y))** .

  ### Avaliação do Estado do Jogo

  Não foi implementado.
  ### Jogada do Computador

  O computador foi implementado com apenas um nível de dificuldade escolhendo peças e jogadas aleatórias.

  O tipo de jogador depende do modo de jogo escolhido e é indicado no predicado **turn(+GameState, +(X, Y), +Player, +RepeatTurn, +GameMode, +IsBot)** pela variável **IsBot** que, se for 0, indica que o jogador é humano e pede input validando-o, caso contrário vai escolher uma jogada aleatrória da parte do computador antes de chamar o predicado **move/8** e continuar o jogo.

  Para as jogadas aleatórias do computador é utilizado o predicado **choose_move(+GameState, +(X, Y), +(X1, Y1), +Player, +RepeatTurn, +Level)** que começa por, a partir do predicado **get_pieces_in_board(+GameState, +X, +Y, +BoardSize, +Player, -Positions)** colocar em **Positions** a lista de posições das peças que pertencem ao jogador em questão. De seguida, é escolhida uma destas posições aleatóriamente e, após serem calculadas as posições para as quais o computador pode jogar essa peça com **valid_moves/6** é escolhida uma desses para fazer a jogada do computador. A partir dai o predicado retorna ao **turn/6** e a execução do progrma continua normalmente chamando **move/8**.

   ## Conclusões: