-- code.ads
-- représentation d’un code binaire de longueur variable

package Code is
    
    subtype Bit is Integer range 0..1;
    type Code is private;

    Erreur_Code_Vide, Erreur_Code_Court: Exception;
    
    -- Creer un Code vide
    function Creer_Code return Code;

    -- Libere un code 
    procedure Liberer_Code(C: in out Code);   
   
    -- Retourne le nombre de bit d'un code
    function Longeur_Code(C: in Code) return Integer;
    
    -- Affiche la suite de bit 
    procedure Afficher(C: in Code);    
 
    -- Insere un bit au début d'un code
    procedure Inserer_Tete(C: in out Code, B: in Bit);

    -- Insere un bit au bout d'un code
    procedure Inserer_Queue(C: in out Code, B: in Bit);

    -- Insere un suite de bit D au but de C
    procedure Inserer_Code_Queue(C: in out Code, D: in Code);   

    -- Supprimer le premiere bit et retourne en B
    -- Exception: Raise erreur_code_vide une fois C est vide
    procedure Supprimer_Tete(C: in out Code, B: out Bit);

    -- Supprimer les n premiere bit et les retourn en Code D
    -- Exception: Raise erreur_code_court
    procedure Supprimer_nTete(C: in out Code, n: in Integer, D: out Code);
 

private 
    type Cellule;
    type Code_Binaire is access Cellule;
    
    type Cellule is record
        Val: Bit;
        Suiv: Code;
    end record;
end Code;
