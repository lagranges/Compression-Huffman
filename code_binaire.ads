-- code.ads
-- représentation d’un code binaire de longueur variable
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package Code_Binaire is
    
    subtype Bit is Integer range 0..1;
    type Code is private;
    
    type Octet is new Integer range 0..255;
    for Octet'Size use 8;

    Erreur_En_Convertant_Code : Exception;

    File_Pleine,Erreur_Code_Vide, Erreur_Code_Court: Exception;
    
    -- Creer un Code vide
    function Creer_Code return Code;
    
    function Creer_Code(C : in Code) return Code;

    -- Libere un code 
    procedure Liberer_Code(C: in out Code);   
   
    -- Retourne le nombre de bit d'un code
    function Longeur_Code(C: in Code) return Integer;
    
    -- Affiche la suite de bit 
    procedure Afficher(C: in Code);    
 
    -- Insere un bit au début d'un code
    procedure Inserer_Tete(C: in out Code; B: in Bit);

    -- Insere un bit au bout d'un code
    procedure Inserer_Queue(C: in out Code; B: in Bit);

    -- Insere un suite de bit D au but de C
    procedure Inserer_Code_Queue(C: in out Code; D: in Code);   

    procedure Inserer_Octet_Queue(C: in out Code; O: in Octet);
    -- Supprimer le premiere bit et retourne en B
    -- Exception: Raise erreur_code_vide une fois C est vide
    procedure Supprimer_Tete(C: in out Code; B: out Bit);

    -- Ecire code en terme de octet , s'arrete un fois longeur de C < 8
    procedure Ecrire_Binaire(C: in out Code; Flux:in out Stream_Access);

    -- Supprimer les n premiere bit et les retourn en Code D
    -- Exception: Raise erreur_code_court
    procedure Supprimer_nTete(C: in out Code; n: in Integer; D: out Code);
    
    -- Compare deux fonction, Retourne true si'ils sont la meme suite de bit 
    function Compare_Code (C: in Code; D: in Code) return Boolean;

private 
    type Cellule;
    type Code is access Cellule;
    
    type Cellule is record
        Val: Bit;
        Suiv: Code;
    end record;
end Code_Binaire;
