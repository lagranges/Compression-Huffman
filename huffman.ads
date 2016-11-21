with Ada.Text_IO; use Ada.Text_IO;
with file_priorite; use file_priorite;
with Ada.Streams.Stream_IO; use Ada.Streams.Streams_IO;

-- Ce package permets contruit une arbre Huffman à partir 
-- d'un fichier des caractères ou d'un fichier compressé.
generic 
    type Element is private;
    with procedure Put(e: in Element);

package Huffman is 

    type Arbre is private;


    procedure Libere_Arbre(A : in out Arbre);
    
    -- Return Arbre_Vide
    function Arbre_Vide return Arbre;

    -- Creer une Noeud de Feuille qui contient caractere C
    function Creer_Feuille(C: Character) return Arbre;

    -- contruire une arbre avec fils gauche A et fils droit B
    -- renvoie la racine
    -- cette fonction est utile pour Creer_Arbre(File) à partir d'un File_priorté
    function Creer_Arbre(A, B: Arbre) return Arbre;
    
    -- contruire une arbre à partir d'une file_priorité
    -- cette fonction est utile pour Creer_Arbre(String) à partir d'un nom d'un fichier
    function Creer_Arbre(F : in File ) return Arbre;
    
    -- contruire une arbre à partir de nom d'un fichier
    -- Exception: file n'exist pas
    function Creer_Arbre(Nom_Fichier : in String) return Arbre;

    function Creer_Arbre() return Arbre;
    -- pour tester 
    -- afficher comment ? lire en Test_Arbre
    procedure Afficher(A : in Arbre);
    


private

    -- défini en Huffman.adb
    type Noeud;

    type Arbre is access Noeud;

end Huffman;
