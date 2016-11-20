with Ada.Text_IO, Ada.Unchecked_Deallocation;
use Ada.Text_IO;

package body Huffman is
    
    type Noeud is record
        Val: Element; -- égale null si ce n'est pas une feuille
        Fd, Fg: Arbre;  -- Fils gauche, Fils droit
    end record;

    
    procedure Libere_Noeud is new Ada.Uncheck_Deallocation(Noeud,Arbre);


end Huffman;
