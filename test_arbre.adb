with Ada.Text_IO; use Ada.Text_IO;
with huffman,dico;
use huffman,dico;

procedure Test_Arbre is
    
    A : Arbre;
    D : Dictionnaire;

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
    
    A := Creer_Arbre("Test_Exemple_IO.txt");   
    Afficher(A);

    D := Creer_Dictionnaire_Text("Test_Exemple_IO.txt");
    Afficher(D); 
end Test_Arbre;


