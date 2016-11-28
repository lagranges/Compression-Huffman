-- file_priorite.ads
-- File_priorite: une liste chainée trié (l'élement le plus prioriaire au début)
-- Policy de Sorti d'un élement: sotir l'élement le plus prorité = le premiere l'element
-- Exception sur Entrer/Sortir

generic 
     
    type Donnee is private; -- Donnée sauvée en file. Dan ce TP, Donnee = Arbre
    type Priorite is private; -- La priorité corressepondant; La donnée la
                                -- plus prioritaire est celui dont la priorite
                                -- est minimale.
    with procedure Afficher(D : in Donnee);
    with procedure Afficher(P:  in Priorite);
    -- Signature d'Operateur
    -- fonciton moin prioritaire
    with function "<" (P1 : in Priorite; P2 : in Priorite) return Boolean;
    with function "+" (P1 : in Priorite; P2 : in Priorite) return Priorite;
package File_priorite is
    
    -- Exception levée par ce package
    Erreur_File_Vide: Exception;

    type File is private;
    
    -- Retourne une file null;
    function Creer_File return File;
    
    -- Retourne la taille de file
    function Longeur_File(F: File) return Integer;

    -- Liberer la file
    procedure Liberer_File(F: in out File);
    
    -- true si File est videe
    function Est_Vide (F: in File) return Boolean;
    
    -- Ajouter un élement
    procedure Entrer (F: in out File ; D: in Donnee ; P: in Priorite);
    
    -- Retirer l'élement le moins priorité, C'est celui dont la priorité est
    -- maximale. Sa donnée est sauvée en D.
    -- Exception : Raise Erreur_File_Vide si la file est videe
    procedure Sortir (F: in out File ; D: out Donnee; P: out Priorite);
    
    -- Exception : Raise Erreur_File_Vide si F est Vide 
    procedure Afficher (F: in File );


private 
    type Cellule;
    type File is access Cellule;
    
    type Cellule is record
        Val: Donnee;
        P: Priorite;
        Suiv: File;
    end record;
end File_priorite;
