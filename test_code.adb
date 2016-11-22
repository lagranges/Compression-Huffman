with Ada.Text_IO; use Ada.Text_IO;
With Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
With Code_Binaire; use Code_Binaire;

procedure test_code is
    C : Code;
    D : Code;
    B: Bit;
    procedure Afficher_Info(E: Code) is 
    begin
        Afficher(E);
        Put("De longueur: ");
        Put(Longeur_Code(E));
        New_Line;
        Put_Line("======================================================================================================================");
        New_Line;
        New_Line;
    end Afficher_Info;
begin

    C := Creer_Code;
    Put("C: ");
    Afficher_Info(C);

    Inserer_Queue(C,1);
    Inserer_Queue(C,0);
    Inserer_Queue(C,1);
    Inserer_Queue(C,1);
    Inserer_Queue(C,0);
    Put("Apres avoir ajouté 01101 C: ");
    Afficher_Info(C);

    D := Creer_Code;
    Put("D: ");
    Afficher_Info(D);
    
    Inserer_Tete(D,0);
    Inserer_Tete(D,0);
    Inserer_Tete(D,0);
    Inserer_Tete(D,0);
    Inserer_Tete(D,0);
    Inserer_Tete(D,1);
    Put("D apres avoir ajouté 100000: ");
    Afficher_Info(D);

    Inserer_Code_Queue(C,D);
    Put_Line("C Apres avoir inserer D: ");
    Afficher_Info(C);

    Supprimer_Tete(C,B);
    Put(B);
    New_Line;
    Put("C apres avoir supprimé une tete: ");
    Afficher_Info(C);

    Supprimer_Tete(C,B);
    Put(B);
    New_Line;
    Put("C apres avoir supprimé une tete: ");
    Afficher_Info(C);

    Supprimer_nTete(C,3,D);       
    Put("C  apres avoir supprimé 3 tete: ");
    Afficher_Info(C);
    Put("D est 3 tete de A: ");
    Afficher_Info(D);
    
    begin 
        Supprimer_nTete(C,30,D);
    exception
        when Erreur_Code_Court
            => Put_Line("La longeur du code n'est pas suffit");
    end;

    D := Creer_Code; 
    begin
        Supprimer_Tete(D,B); 
    exception
        when Erreur_Code_Vide
            => Put_Line("Le code est vide");
    end;

end test_code;
