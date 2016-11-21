with Ada.Text_IO; use Ada.Text_IO;
with huffman;

procedure Test_Arbre is
    
    procedure PutCharacter(C:Character) is 
    begin
        Put(C);
    end PutCharacter;

    package Huffman_Character is new Huffman(Character,PutCharacter);
    use Huffman_Character;
    
    A : Arbre;
begin
    A := Arbre_Vide;
    Afficher(A); -- Afficher: Arbre Vide
    A := Creer_Arbre(Creer_Feuille('A'),Creer_Feuille('C')); 
    Afficher(A);--- Afficher: A : 0
                ---           B : 1
    A := Creer_Arbre(Creer_Feuille('C'),A);
    Afficher(A);-- C : 0
                -- A : 10
                -- B : 11
end Test_Arbre;


