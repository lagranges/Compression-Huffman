with Ada.Text_IO;
with file_priorite;
with Ada.Streams.Stream_IO;
with Dico;
use Dico;

-- Ce package permets contruit une arbre Huffman à partir 
-- d'un fichier des caractères ou d'un fichier compressé.

package Huffman is 

    type Arbre is private;

    Erreur_File_Vide: exception;

    type Tableau_Character is array(Character'First..Character'Last) of Integer;
   
    procedure Liberer_Arbre(A : in out Arbre);
    
    -- Return Arbre_Vide
    function Arbre_Vide return Arbre;

    -- Creer une Noeud de Feuille qui contient caractere C
    function Creer_Feuille(E: Character) return Arbre;

    -- contruire une arbre avec fils gauche A et fils droit B
    -- renvoie la racine
    -- cette fonction est utile pour Creer_Arbre(File) à partir d'un File_priorté
    function Creer_Arbre(A, B: Arbre) return Arbre;
    
--    -- contruire une arbre à partir d'une file_priorité
--    -- cette fonction est utile pour Creer_Arbre(String) à partir d'un nom d'un fichier
--    
--    -- contruire une arbre à partir de nom d'un fichier
--    -- Exception: file n'exist pas
      -- Retourne la Tab des caratere avec le Nb de apparition
    procedure Creer_Arbre(A: out Arbre; Nom_Fichier: in String;
                         Tab: out Tableau_Character);

    -- pour tester 
    -- afficher tous les caractere dont les feuilles
    procedure Afficher(A : in Arbre);

    
    -- Contruire un dictionnnaire à partir d'une arbre
    procedure Creer_Dictionnaire_Text (D :out Dictionnaire; Nom_Fichier: in String;                                       Tab: out Tableau_Character); 

    -- Contruire un dictionnaire à partir de la tete d'un fichier
    procedure Creer_Dictionnaire_Binaire(D: out Dictionnaire; 
                    Flux_Tmp : in out Ada.Streams.Stream_IO.Stream_Access) ;
        

private

    -- défini en Huffman.adb
    type Noeud;

    type Arbre is access Noeud;

end Huffman;
