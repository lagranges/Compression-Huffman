with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
with file_priorite;

procedure Test_File is
   
    procedure Put_Character(C: Character) is
    begin
        Put(C);
    end Put_Character;

    procedure Put_Integer(I : Integer) is
    begin
        Put(I,0);
    end Put_Integer;


    package File_priorite_Integer is new File_priorite(Character,Integer,Put_Character,Put_Integer,"<");
    use File_priorite_Integer;
    
    F : File;
    A : Character;
begin
    F := Creer_File;

    -- Check Exception: afficher une arbre vide
        Afficher(F); -- test Exception File_Vide

    -- Check Entrer 
    Entrer(F,'a',15);
    Entrer(F,'b',25);
    Entrer(F,'c',10);
    Entrer(F,'d',15);
    Afficher(F); -- a: 15 ( afficher tous les élement avec ses priorité)
                 -- b: 25
                 -- c: 10
                 -- null: 15 
    -- Check Sortir 
    Sortir(F,A);
    Sortir(F,A);
    Afficher(F); -- a: 15
                 -- b: 25
    Put(A); -- c 

    begin
        
       Sortir(F,A);
       Sortir(F,A);
       Sortir(F,A);
       Sortir(F,A);
    exception 
        when Erreur_File_Vide
          => Put_Line("File vide");
          return;
    end;

    Afficher(F); 
end Test_File;
