MODULE Module1
    !***********************************************************
    !
    !   Projeto de Fundamentos de Rob�tica : Campo minado
    !
    !   Prof. Dr. Sandro Lu�s Vatanabe
    !
    !***********************************************************
    !
    !   Alunos : Alex Key Araki                           RA: 11019914
    !            Luana Larissa Mendon�a Teixeira          RA: 11201811394
    !
    !***********************************************************
    !
    ! Modo de jogar: ( Vers�o final)
    !   1- Escolha o tamanho do tabuleiro.
    !   2- Escolha uma linha ( As coordenadas dos eixos se iniciam do canto direito inferior).
    !   3- Escolha uma coluna.
    !
    !***********************************************************
        
    CONST robtarget p10:=[[855.65,-39.74,681.32],[0.156987,0.0229146,0.987328,-0.00364346],[-1,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];

    
    VAR num Tamanhomatriz;
    VAR speeddata Velocidade := v50;
    VAR num Tamanhoquadrado := 30;
    VAR num Matriz9{9,9};
    VAR num Matriz5{5,5};
    VAR num Ponto;
    VAR num Valorinicial;
    VAR num Eixox;
    VAR num Eixoy;
    VAR num Continuidade;
    VAR num Minimizador :=0;
    VAR num Coordenadax ;
    VAR num Coordenaday ; 
    
    !   Para desenvolver o c�digo foi dividio em v�rios blocos afim de manter a organiza��o do mesmo,
    !   sendo divido em DesenhaTabuleiro, DesenhaBomba, DesenhaSafe, DesenhaDica, AplicarBomba, VerificarBomba e o main.
    
    PROC DesenhaTabuleiro()
          
    
        VAR num Quadrado :=30;
        VAR num Tamanhotabuleiro ;
        
    !   Para desenhar o tabuleiro foi estimado que cada quadrado teria medida 30, com a possibilidade de dois tabuleiros
    !   5x5 e 9x9, foi criado duas condi�oes, multiplicando o tamanho da matriz pelo valor do quadrado.
    !   O c�digo abaixo desenha o tabuleiro pode ser desenhado em qualquer tamanho apenas mudando a vari�vel Tamanhomatriz.
    
        IF Valorinicial = 1 THEN 
            Tamanhomatriz := 5;
        ELSE 
            Tamanhomatriz := 9;
        ENDIF
        
        Tamanhotabuleiro := Tamanhomatriz*Tamanhoquadrado;
        
    !    C�digo para desenhar o contorno do tabuleiro.
        MoveJ p10, v50, fine, tool0;
        MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
        MoveL Offs(p10,0,0,0), Velocidade, fine, tool0;
        MoveL Offs(p10,0,Tamanhotabuleiro,0), Velocidade, fine, tool0;
        MoveL Offs(p10,Tamanhotabuleiro,Tamanhotabuleiro,0), Velocidade, fine, tool0;
        MoveL Offs(p10,Tamanhotabuleiro,0,0), Velocidade, fine, tool0;
        MoveL Offs(p10,0,0,0), Velocidade, fine, tool0;
        MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
        
    !   C�digo para desenhar as linhas do tabuleiro.
        
        FOR i FROM 1 TO (Tamanhomatriz-1) DO 
            
        MoveL Offs(p10,Quadrado,0,20), Velocidade, fine, tool0;
        MoveL Offs(p10,Quadrado,0,0), Velocidade, fine, tool0;
        MoveL Offs(p10,Quadrado,Tamanhotabuleiro,0), Velocidade, fine, tool0;
        MoveL Offs(p10,Quadrado,Tamanhotabuleiro,20), Velocidade, fine, tool0;
        Quadrado := Quadrado + 30;
        ENDFOR
            
        Quadrado := 30;
        
    !   C�digo para desenhar as colunas do tabuleiro, em seguida voltando ao ponto inicial (0,0).
        
        FOR i FROM 1 TO (Tamanhomatriz-1) DO 
            
        MoveL Offs(p10,0,Quadrado,20), Velocidade, fine, tool0;
        MoveL Offs(p10,0,Quadrado,0), Velocidade, fine, tool0;
        MoveL Offs(p10,Tamanhotabuleiro,Quadrado,0), Velocidade, fine, tool0;
        MoveL Offs(p10,Tamanhotabuleiro,Quadrado,20), Velocidade, fine, tool0;
        Quadrado := Quadrado + 30;
        ENDFOR
            
        
            
            
        MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
        
    ENDPROC
    
    PROC DesenhaSafe()
        
    !   Os c�digos para desenhar o 'safe' s�o iguais, por�m adaptado para cada tabuleiro.
    !   Como o ponto de refer�ncia � o total oposto em X e Y do ponto (0,0) da m�quina,
    !   parte-se ent�o como ponto inicial os pontos (150,150) para a tabela 5x5, uma vez que 
    !   5x30 = 150.
    !   O mesmo vale para o ponto inicial da tabela 9x9 que � (270,270).
    !   Outro detalhe � que para desenhar na posi��o correta, foram trocados as coordenadas x e y para calculos,
    !   uma vez que o eixo X e Y da m�quina s�o diferentes das definidas para o projeto.
        
    ! Valor inicial = 1 refere-se para tabuleiro 5x5.
        IF Valorinicial = 1 THEN
            Coordenadax := 150 - ( Eixox*30);
            Coordenaday := 150 - ( Eixoy*30);
            MoveL Offs(p10,Coordenaday+15,Coordenadax+5,20), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+15,Coordenadax+5,0), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+25,Coordenadax+10,0), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+5,Coordenadax+25,0), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+5,Coordenadax+25,20), Velocidade, fine, tool0; 
            MoveL Offs(p10,0,0,20), Velocidade, fine, tool0; 
        ENDIF
        
    ! Valor inicial = 2 refere-se para tabuleiro 9x9.
        IF Valorinicial = 2 THEN
            
            Coordenadax := 270 - ( Eixox*30);
            Coordenaday := 270 - ( Eixoy*30);
            MoveL Offs(p10,Coordenaday+15,Coordenadax+5,20), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+15,Coordenadax+5,0), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+25,Coordenadax+10,0), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+5,Coordenadax+25,0), Velocidade, fine, tool0;
            MoveL Offs(p10,Coordenaday+5,Coordenadax+25,20), Velocidade, fine, tool0; 
            MoveL Offs(p10,0,0,20), Velocidade, fine, tool0; 
            
        ENDIF
        
    ENDPROC
    
    PROC DesenhaBomba()
        
    !   Funciona exatamente da mesma forma que o Desenhasafe. 
    !   Por�m desenha uma bombinha. 
    !   Desenha bomba no 5x5.
        IF Valorinicial = 1 THEN
            Coordenadax := 150 - ( Eixox*30);
            Coordenaday := 150 - ( Eixoy*30);
            MoveL Offs(p10,25+Coordenaday,15+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,25+Coordenaday,15+Coordenadax,0), Velocidade, fine, tool0;
            MoveC Offs(p10,17.5+Coordenaday,22.5+Coordenadax,0), Offs(p10,10+Coordenaday,15+Coordenadax,0), Velocidade, z1, tool0;
            MoveC Offs(p10,17.5+Coordenaday,7.5+Coordenadax,0),Offs(p10,25+Coordenaday,15+Coordenadax,0), Velocidade, z1, tool0;
            MoveL Offs(p10,25+Coordenaday,15+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,12+Coordenaday,15+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,12+Coordenaday,15+Coordenadax,0), Velocidade, fine, tool0;
            MoveL Offs(p10,5+Coordenaday,22.5+Coordenadax,0), Velocidade, fine, tool0;
            MoveL Offs(p10,5+Coordenaday,22.5+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,0,0,20), Velocidade, fine, tool0; 
        ENDIF
    !   Desenha bomba no 9x9
        IF Valorinicial = 2 THEN
            
            Coordenadax := 270- ( Eixox*30);
            Coordenaday := 270 - ( Eixoy*30);
            MoveL Offs(p10,25+Coordenaday,15+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,25+Coordenaday,15+Coordenadax,0), Velocidade, fine, tool0;
            MoveC Offs(p10,17.5+Coordenaday,22.5+Coordenadax,0), Offs(p10,10+Coordenaday,15+Coordenadax,0), Velocidade, z1, tool0;
            MoveC Offs(p10,17.5+Coordenaday,7.5+Coordenadax,0),Offs(p10,25+Coordenaday,15+Coordenadax,0), Velocidade, z1, tool0;
            MoveL Offs(p10,25+Coordenaday,15+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,12+Coordenaday,15+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,12+Coordenaday,15+Coordenadax,0), Velocidade, fine, tool0;
            MoveL Offs(p10,5+Coordenaday,22.5+Coordenadax,0), Velocidade, fine, tool0;
            MoveL Offs(p10,5+Coordenaday,22.5+Coordenadax,20), Velocidade, fine, tool0;
            MoveL Offs(p10,0,0,20), Velocidade, fine, tool0; 
        ENDIF
        
    ENDPROC
    
    PROC DesenhaDica()
    !   Para tabuleiro 5x5
        IF Valorinicial = 1 THEN 
    !   Desenha o valor 1 quando h� uma bomba perto.
            IF Matriz5{Eixoy,Eixox} = 1 THEN
                
                Coordenadax := 150 - ( Eixox*30);
                Coordenaday := 150 - ( Eixoy*30);
                MoveL Offs(p10,Coordenaday+10,Coordenadax+8,20), Velocidade, fine, tool0;
                MoveL Offs(p10,Coordenaday+5,Coordenadax+15,0), Velocidade, fine, tool0;
                MoveL Offs(p10,Coordenaday+25,Coordenadax+15,0), Velocidade, fine, tool0;
                MoveL Offs(p10,Coordenaday+25,Coordenadax+15,20), Velocidade, fine, tool0; 
                MoveL Offs(p10,0,0,20), Velocidade, fine, tool0; 
                
            ENDIF
    !   Desenha o valor 2 quando h� duas bombas pr�ximas.
            IF Matriz5{Eixoy,Eixox} = 2 THEN
                
                Coordenadax := 150 - ( Eixox*30);
                Coordenaday := 150 - ( Eixoy*30);
                MoveL Offs(p10,10+Coordenaday,5+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,10+Coordenaday,5+Coordenadax,0), Velocidade, fine, tool0;
                MoveC Offs(p10,5+Coordenaday,15+Coordenadax,0), Offs(p10,10+Coordenaday,25+Coordenadax,0), Velocidade, z1, tool0;
                MoveL Offs(p10,25+Coordenaday,5+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,25+Coordenaday,25+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,25+Coordenaday,25+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
                
                
            ENDIF
    !   Desenha o valor 3 quando h� tr�s bombas pr�ximas.
            IF Matriz5{Eixoy,Eixox} = 3 THEN
                
                Coordenadax := 150 - ( Eixox*30);
                Coordenaday := 150 - ( Eixoy*30);
                MoveL Offs(p10,5+Coordenaday,10+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,5+Coordenaday,10+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,5+Coordenaday,20+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,10+Coordenaday,15+Coordenadax,0), Velocidade, fine, tool0;
                MoveC Offs(p10,20+Coordenaday,22.5+Coordenadax,0), Offs(p10,25+Coordenaday,15+Coordenadax,0), Velocidade, z1, tool0;
                MoveC Offs(p10,20+Coordenaday,7.5+Coordenadax,0),  Offs(p10,20+Coordenaday,7.5+Coordenadax,20), Velocidade, z1, tool0;
                MoveL Offs(p10,20+Coordenaday,7.5+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
                
            ENDIF
        ENDIF
    ! Para tabuleiro 9x9
        IF Valorinicial = 2 THEN
            IF Matriz9{Eixoy,Eixox} = 1 THEN
     !   Desenha o valor 1 quando h� uma bomba pr�xima.   
                Coordenadax := 270 - ( Eixox*30);
                Coordenaday := 270 - ( Eixoy*30);
                MoveL Offs(p10,Coordenaday+10,Coordenadax+8,20), Velocidade, fine, tool0;
                MoveL Offs(p10,Coordenaday+5,Coordenadax+15,0), Velocidade, fine, tool0;
                MoveL Offs(p10,Coordenaday+25,Coordenadax+15,0), Velocidade, fine, tool0;
                MoveL Offs(p10,Coordenaday+25,Coordenadax+15,20), Velocidade, fine, tool0; 
                MoveL Offs(p10,0,0,20), Velocidade, fine, tool0; 
                
            ENDIF
      !   Desenha o valor 2 quando h� duas bombas pr�ximas.
            IF Matriz9{Eixoy,Eixox} = 2 THEN
                
                Coordenadax := 270 - ( Eixox*30);
                Coordenaday := 270 - ( Eixoy*30);
                MoveL Offs(p10,10+Coordenaday,5+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,10+Coordenaday,5+Coordenadax,0), Velocidade, fine, tool0;
                MoveC Offs(p10,5+Coordenaday,15+Coordenadax,0), Offs(p10,10+Coordenaday,25+Coordenadax,0), Velocidade, z1, tool0;
                MoveL Offs(p10,25+Coordenaday,5+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,25+Coordenaday,25+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,25+Coordenaday,25+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
                
                
            ENDIF
        !   Desenha o valor 3 quando h� tr�s bombas pr�ximas.     
            IF Matriz9{Eixoy,Eixox} = 3 THEN
                
                Coordenadax := 270 - ( Eixox*30);
                Coordenaday := 270 - ( Eixoy*30);
                MoveL Offs(p10,5+Coordenaday,10+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,5+Coordenaday,10+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,5+Coordenaday,20+Coordenadax,0), Velocidade, fine, tool0;
                MoveL Offs(p10,10+Coordenaday,15+Coordenadax,0), Velocidade, fine, tool0;
                MoveC Offs(p10,20+Coordenaday,22.5+Coordenadax,0), Offs(p10,25+Coordenaday,15+Coordenadax,0), Velocidade, z1, tool0;
                MoveC Offs(p10,20+Coordenaday,7.5+Coordenadax,0),  Offs(p10,20+Coordenaday,7.5+Coordenadax,20), Velocidade, z1, tool0;
                MoveL Offs(p10,20+Coordenaday,7.5+Coordenadax,20), Velocidade, fine, tool0;
                MoveL Offs(p10,0,0,20), Velocidade, fine, tool0;
                
            ENDIF
        ENDIF
    ENDPROC
    
    PROC AplicarBomba()
        !   Nesta vers�o to projeto houve uma mudan�a  aonde foi descartado a aleatoriedade para dar maior semelhan�a ao jogo
        !   original. 
        !   Legenda dos valores, 0= sem bombas perto, 1= uma bomba perto, 2= duas bombas perto, 3= tr�s bombas perto, 9= bomba.
        !   Matriz para o tabuleiro 5x5
      
            
            Matriz5 := [[ 9 , 2 , 1 , 1 , 1 ],
                        [ 9 , 2 , 2 , 9 , 1 ],
                        [ 1 , 2 , 2 , 3 , 2 ],
                        [ 0 , 1 , 9 , 2 , 9 ],
                        [ 0 , 1 , 1 , 2 , 1 ]];
        
                       
        !   Matriz para tabuleiro 9x9
        
             Matriz9 :=[[ 1 , 1 , 0 , 0 , 0 , 1 , 1 , 2 , 9],
                        [ 9 , 2 , 1 , 0 , 0 , 1 , 9 , 2 , 1],
                        [ 3 , 9 , 1 , 0 , 0 , 1 , 1 , 1 , 0],
                        [ 9 , 2 , 1 , 0 , 0 , 0 , 0 , 0 , 0],
                        [ 1 , 1 , 0 , 0 , 0 , 1 , 1 , 1 , 0],
                        [ 2 , 2 , 1 , 0 , 0 , 1 , 9 , 1 , 0],
                        [ 9 , 9 , 1 , 0 , 0 , 1 , 1 , 1 , 0],
                        [ 9 , 3 , 1 , 0 , 0 , 0 , 0 , 1 , 1],
                        [ 0 , 1 , 0 , 0 , 0 , 0 , 0 , 1 , 9]];
                
ENDPROC

    PROC VerificarBomba()
        ! Tavuleiro 5x5
        !   Confere qual o valor na posi��o escolhida na matriz. caso for 0 desenhar� safe e aumentara a pontua��o, caso for os valores das
        !   dicas, desenhar� a dica equivalente e caso for 9 e aumentar� a pontua��o, desenhar� a bomba e tirar� o jogo do la�o, finalizando-o
        if Valorinicial = 1 THEN    
            IF Matriz5{Eixoy,Eixox} = 0 THEN
                DesenhaSafe;
                Ponto := Ponto +1;
            ENDIF
            IF Matriz5{Eixoy,Eixox} >= 1 AND Matriz5{Eixoy,Eixox} <=6 THEN
                DesenhaDica;
                Ponto := Ponto +1;
            ENDIF
            IF Matriz5{Eixoy,Eixox} = 9 THEN
                DesenhaBomba;
                Continuidade := 1;
            ENDIF
       ENDIF
        !   Tabuleiro 9x9
        !   Funciona exatamente da mesma forma.
       if Valorinicial = 2 THEN    
            IF Matriz9{Eixoy,Eixox} = 0 THEN
                DesenhaSafe;
                Ponto := Ponto +1;
            ENDIF
            IF Matriz9{Eixoy,Eixox} >= 1 AND Matriz9{Eixoy,Eixox} <=6 THEN
                DesenhaDica;
                Ponto := Ponto +1;
            ENDIF
            IF Matriz9{Eixoy,Eixox} = 9 THEN
                DesenhaBomba;
                Continuidade := 1;
            ENDIF
       ENDIF
    ENDPROC 
    
    PROC main()
         
    !   No main � definido o valor inicial, ou seja, se ser� utilizado os codigos para 5x5 ou para 9x9.
    !   Logo em seguida sorteando as bombas e desenhando o tabuleiro.
        VAR num Modo;
        
        
         TPReadFK Modo, "Selecione um modo", "Desenhar tabuleiro", "Jogar direto", stEmpty, stEmpty , stEmpty; 
         
     AplicarBomba;
     IF Modo = 2 THEN
         
         TPReadFK Valorinicial, "em qual tabuleiro?", "5x5", "9x9", stEmpty, stEmpty , stEmpty; 
     ENDIF
     
         
         
    IF Modo = 1 THEN
        TPReadFK Valorinicial, "Qual o tamanho ?", "5x5", "9x9", stEmpty, stEmpty , stEmpty;       
       
        DesenhaTabuleiro;
    ENDIF
    
    !   A parte do jogador consiste em escolher valores nas coordenadas X e Y, que ser�o atribuidos a uma posi��o no vetor
    !   e verificando se h� bomba ou n�o na posi��o.
    !   Caso o jogador perca, o robo levantar� para permitir a limpeza do quadro.
    !   Enquanto n�o houver bombas a continuidade ser� = 0, caso perca, continuidade = 1 quebrando o ciclo.
    
        WHILE Continuidade = 0 DO 
            
    !   Os la�os abaixo foram feitos para evitar que o jogador coloque coordenadas fora das posi��es no jogo.
    
            TPReadNum Eixoy,"Escolha uma linha.";
            TPReadNum Eixox,"Escolha uma coluna.";
            
                IF Valorinicial = 1 THEN            
                    WHILE Eixoy >= 6 OR Eixoy <= 0  DO
                        TPReadNum Eixoy,"Escolha uma linha entre 1 e 5.";
                    ENDWHILE
                    WHILE Eixox >= 6 OR Eixox <= 0 DO
                        TPReadNum Eixox,"Escolha uma coluna entre 1 e 5.";
                    ENDWHILE
                    VerificarBomba;
                ENDIF
                
                IF Valorinicial = 2 THEN
                    WHILE Eixoy >= 10 OR Eixoy <= 0 DO
                        TPReadNum Eixoy,"Escolha uma linha entre 1 e 9.";
                    ENDWHILE
                    WHILE Eixox >= 10 OR Eixox <= 0 DO
                        TPReadNum Eixox,"Escolha uma coluna entre 1 e 9.";
                    ENDWHILE  
                    VerificarBomba;
                    
                ENDIF
        !   no caso do tabuleiro 5x5, caso conseguir pisar em todas as casas sem bomba o jogador recebe a mensagem
        !   de congratula�oes por vencer o jogoe o jogo finaliza.
            IF Valorinicial = 1 THEN
                IF Ponto = 19 THEN
                    Continuidade := 2;
                    TPWrite "Parab�ns, voce venceu o jogo!!";
                    MoveL Offs(p10,0,0,100), Velocidade, fine, tool0;
                ENDIF
           ENDIF
        !   no caso do tabuleiro 9x9, caso conseguir pisar em todas as casas sem bomba o jogador recebe a mensagem
        !   de congratula�oes por vencer o jogo e o jogo finaliza.
            IF Valorinicial = 2 THEN
                IF Ponto = 71 THEN
                    Continuidade := 2;
                    TPWrite "Parab�ns, voce venceu o jogo!!";
                    MoveL Offs(p10,0,0,100), Velocidade, fine, tool0;
                ENDIF
            ENDIF
                
        ENDWHILE
        
        
        
        ! Aqui o jogar perdeu, logo continuidade = 1 e a m�quina levanta para permitir apagar o jogo anterior.
        
        IF Continuidade = 1 THEN
             MoveL Offs(p10,0,0,100), Velocidade, fine, tool0;
             TPWrite "Voce perdeu :(";
        ENDIF
        
        
        
        
    ENDPROC
ENDMODULE