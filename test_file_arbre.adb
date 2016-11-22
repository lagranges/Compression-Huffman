with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
with file_priorite;
with Huffman;
procedure Test_File is
   
    procedure Put_Character(C: Character) is
    begin
        Put(C);
    end Put_Character;
    package Huffman_Character is new Huffman(Character,Put_Character);

    procedure Put_Integer(I : Integer) is
    begin
        Put(I);
    end Put_Integer;

    procedure Put_Arbre(A: Arbre) is
    begin
        Afficher(A);
    end Put_Arbre;

    package File_priorite_Integer is new File_priorite(Character,Integer,Put_Arbre,Huffman.Put,"<");
    use File_priorite_Integer;
    
    F : File;
    A : Arbre;

begin
    F := Creer_File;

    -- Check Exception: afficher une arbre vide
    begin 
        Afficher(F); -- test Exception File_Vide
    exception 
        when Erreur_File_Vide
          => Put_Line("Arbre Vide");
          return;
    end; 

    -- Check Entrer 
    Entrer(F,Creer_Feuille('a'),15);
    Entrer(F,Creer_Feuille('b'),25);
    Entrer(F,Creer_Feuille('c'),10);
    Entrer(F,Arbre_Vide,15);
    Afficher(F); -- a: 15 ( afficher tous les élement avec ses priorité)
                 -- b: 25
                 -- c: 10
                 -- null: 15 
    -- Check Sortir 
    Sortir(F,A);
    Sortir(F,A);
    Afficher(F); -- a: 15
                 -- b: 25
    Put(A.all.Val); -- c 

end Test_File;
