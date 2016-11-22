-- un dictionnaire des caractères, permettant de stocker 
-- les codes binaires associés à chaque caractère

with Code_Binaire; use Code_Binaire;

package Dico is

    type Dictionnaire is private;

    Erreur_Sans_Existe : Exception;

    function Creer_Dictionnaire return Dictionnaire;

    procedure Liberer_Dictionnaire(D: in out Dictionnaire);

    procedure Ajouter(D:in out Dictionnaire; Char:in Character; C:in Code);

    function Traduire(D: in Dictionnaire; Char: in Character) return Code;

    function Traduire(D: in Dictionnaire; C: in Code) return Character;
    
    procedure Afficher(D: in Dictionnaire);

private
    type Cellule;    

    type Dictionnaire is access Cellule;
    
    type Cellule is record 
        Char: Character;
        C : Code;
        Suiv : Dictionnaire;
    end record;
end Dico;
