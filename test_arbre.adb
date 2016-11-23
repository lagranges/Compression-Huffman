with Ada.Text_IO; use Ada.Text_IO;
with huffman;

procedure Test_Arbre is
    
    procedure PutCharacter(C:Character) is 
    begin
        Put(C);
        Put("  ");
    end PutCharacter;
    
    function Character_Null return Character is
    begin
        return Character'Val(16#00#);
    end Character_Null;

    package Huffman_Character is new Huffman(Character,Character_Null,PutCharacter);
    use Huffman_Character;
    
    A : Arbre;

    procedure Afficher_Info(A: Arbre) is
    begin
        Put("Tous les feuilles de l'arbre: ");
        Afficher(A);
        New_Line;
    end Afficher_Info;
begin
    A := Arbre_Vide;
    Afficher_Info(A); -- Afficher: 
    A := Creer_Arbre(Creer_Feuille('A'),Creer_Feuille('B')); 
    Afficher_Info(A);--- Afficher: A B
                ---           
    A := Creer_Arbre(Creer_Feuille('C'),A);
    Afficher_Info(A);-- C A B
               
    Liberer_Arbre(A);
    Afficher_Info(A); 
                
end Test_Arbre;


