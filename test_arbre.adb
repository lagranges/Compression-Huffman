with Ada.Text_IO; use Ada.Text_IO;
with huffman,dico;
use huffman,dico;

procedure Test_Arbre is

    procedure Afficher_Info(A: Arbre) is
    begin
        Put("Tous les feuilles de l'arbre: ");
        Afficher(A);
        New_Line;
    end Afficher_Info;

    A : Arbre;
    D : Dictionnaire;


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
    
    A := Creer_Arbre("a.txt");   
    Afficher(;

    D := Creer_Dictionnaire_Text("a.txt");
    Afficher(D); 
end Test_Arbre;


