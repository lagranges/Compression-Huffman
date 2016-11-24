with Ada.Text_IO, Ada.Integer_Text_IO, Code_Binaire, Dico;
use  Ada.Text_IO, Ada.Integer_Text_IO, Code_Binaire, Dico;

procedure Test_Dico is
    D, D1: Dictionnaire;
    Char: Character;
    C,C1: Code;
    B: Bit;
begin
    D := Creer_Dictionnaire;
    Put("D : ");
    Afficher(D);

    C := Creer_Code;
    Inserer_Queue(C,1);
    Inserer_Queue(C,0);
    Inserer_Queue(C,0);
    Inserer_Queue(C,1);
    Inserer_Queue(C,0);

    Ajouter(D,'a',C);
    Put("D : ");
    Afficher(D);
    
    Char := 'b';
    begin
        C := Traduire(D,Char);
    exception
            when Erreur_Sans_Existe =>
                Put("Ne trouve pas le caractere c dans le Dictionnaire");
                New_Line;
    end;

    C := Creer_Code;
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);
    Inserer_Tete(C,0);

    C1 := Creer_Code;
    
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Inserer_Tete(C1,0);
    Supprimer_Tete(C1,B);
    Inserer_Tete(C1,0);
    Inserer_Queue(C1,0);

    Ajouter(D,Char,C);
    Put("D : ");
    Afficher(D);

    Char := Traduire(D,C);
    Put("Traduire 000000 :");
    Put(Char);
    New_Line;

    Char := Traduire(D,C1);
    Put("Traduire 000000 :");
    Put(Char);
    New_Line;

    C := Traduire(D,'a');
    Put("Traduire 'a':");
    Afficher(C); 
    
    D := Ajouter(D, 1);
    Afficher(D);
    
    D := Ajouter(D,0);
    Afficher(D);
    New_Line;
    Put(Character'Val(16#00#));
    Put(Character'Val(16#00#));
    Put(Character'Val(16#00#));
    Put("_");
    New_Line;

    D1 := Creer_Dictionnaire;
    Ajouter(D1,'x',C1);
    Ajouter(D1,'y',C);
    Ajouter(D1,'z',C);
    Afficher(D1);

    D1 := Ajouter(D,D1);
    Afficher(D1);

    Afficher(C);
    Supprimer_nTete(C,5,C1);
    Afficher(C);
    Afficher(C1);
    Inserer_Code_Queue(C1,C);
    Afficher(C1);

end Test_Dico;


