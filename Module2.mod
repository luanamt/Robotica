MODULE Module1
	CONST robtarget p10:=[[952.21,28.30,589.58],[0.124273,-0.0147413,0.992137,0.00184647],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	CONST robtarget p20:=[[952.21,28.30,589.58],[0.124273,-0.0147413,0.992137,0.00184647],[0,0,0,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: luana
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        MoveL p10, v100, fine, tool0;
      !  VAR num desenho;
       ! TP!ReadFK desenho, "Selecione o desenho" , "Quadrado", "Circulo", "Triangulo", stEmpty, stEmpty;
        !IF! desenho = 1 THEN 
            MoveL Offs(p10,0,0,0), v100, fine, tool0;
            MoveL Offs(p10,0,100,0), v100, fine, tool0;
            MoveL Offs(p10,100,100,0), v100, fine, tool0;
            MoveL Offs(p10,100,0,0), v100, fine, tool0;
            MoveL Offs(p10,0,0,0), v100, fine, tool0;
            
            
            !jfjjf
            
       ! ELSEIF desenho = 2 THEN 
           ! MoveC Offs(p10,50,50,0), Offs(p10,0,100,0), v100, z10, tool0;
            !MoveC Offs(p10,50,50,0), Offs(p10,0,100,0), v100, z10, tool0;
            
            !asfasf
       ! ELSE
            !sdfsdf
       ! ENDIF
        !MoveL Offs(p10,0,10,0), v1000, fine, tool0;
    ENDPROC
ENDMODULE