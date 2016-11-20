with Ada.Text_Io; use Ada.Text_Io;
with file_priorite

generic 
    type Element is private;
    with procedure Put(e: in Element);
    with function ">" (A, B: Element) return Boolean;

package Huffman is 

    type Arbre is private;

    procedure Libere_Arbre(A : in out Arbre);
    
    -- Return Arbre_Vide
    function Arbre_Vide return Arbre;

    
    -- contruire une arbre avec deux fils A, B
    -- renvoie la racine
    -- cette fonction est utile pour Creer_Arbre()
    function Creer_Arbre(A, B: Arbre) return Arbre;
    
    -- contruire une arbre à partir d'une file_priorité
    function Creer_Arbre(F : in File ) return Arbre;

    -- pour tester 
    procedure Afficher(A : in Arbre);
    


private

    -- défini en Huffman.adb
    type Noeud;

    type Arbre is access Noeud;

end Huffman;
