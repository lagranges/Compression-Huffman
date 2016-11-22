-- file_priorite
-- package body

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation; 
package body file_priorite is 
    
    procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, File);
    
    function Creer_File return File is
    begin
        return null;
    end Creer_File;


    procedure Liberer_File(F: in out File) is
        Tmp : File;
    begin
        while F /= null loop
           Tmp := F;
           F := F.Suiv;
           Liberer(Tmp); 
        end loop;
    end Liberer_File;


    function Est_Vide (F: in File) return Boolean is 
    begin
        return F = null;
    end Est_Vide;

    procedure Entrer (F: in out File; D: in Donnee; P: in Priorite) is
        Tmp: File;
    begin
        if F = null then 
            F := new Cellule'(D,P,null);
        else if P < F.P then
                F := new Cellule'(D,P,F);
        else
                Tmp := F.Suiv;
                Entrer(Tmp, D, P);
                F.Suiv := Tmp;
        end if; 
        end if;
    end Entrer;

    procedure Sortir (F: in out File; D: out Donnee) is
        Tmp : File := F;
    begin
        if F = null then
            raise Erreur_File_Vide; 
        else
            F := F.Suiv;
            Liberer(Tmp);
        end if;
    end Sortir;


    procedure Afficher(F : in File) is
        Tmp : File := F;
    begin
        if F = null then Put("File Vide");
        else    Put("F");
        end if;
        while Tmp /= null loop
            Put("->");
            Afficher(Tmp.Val);
            Afficher(Tmp.P);
            Tmp := Tmp.Suiv;
        end loop;
        New_Line;
    end Afficher;


end file_priorite;
