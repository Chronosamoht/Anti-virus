with p_esiut, p_fenbase, Forms;
use p_esiut, p_fenbase, Forms;

package body p_vuegraph is

procedure ActuLvl (F: in out TR_Fenetre; niv: in integer) is
--{Fenêtre de menu créée avec CreerFenMenu}=>{Blocs de chiffres pour le niveau mis à jour}
begin
	for i in 0..1 loop
		for c in 0..2 loop
			for l in 0..4 loop
				if i=0 then
					case integer(niv/10) is
						when 0 =>
							if c=0 OR c=2 OR l=0 OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 1 =>
							if c=1 OR (c=0 AND l=1) OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 2 =>
							if l=0 OR l=2 OR (c=2 AND l=1) OR (c=0 AND l=3) OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when others =>
							CacherElem(F,"8seg"&image(i)&image(c)&image(l));
					end case;
				else
					case niv-integer(niv/10)*10 is
						when 0 =>
							if c=0 OR c=2 OR l=0 OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 1 =>
							if c=1 OR (c=0 AND l=1) OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 2 =>
							if l=0 OR l=2 OR (c=2 AND l=1) OR (c=0 AND l=3) OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 3 =>
							if c=2 OR l=0 OR l=2 OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 4 =>
							if (c=0 AND l<3) OR l=3 OR (c=2 AND l>1) then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 5 =>
							if l=0 OR l=2 OR (c=2 AND l=3) OR (c=0 AND l=1) OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 6 =>
							if c=0 OR l=4 OR l=2 OR l=0 OR (c=2 AND l/=1) then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 7 =>
							--if c=2 OR l=0 OR (c=1 AND l=2) then
							if l=0 OR (c=2 AND l=1) OR (c=1 AND l>=2)  then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 8 =>
							if c=0 OR c=2 OR l=0 OR l=2 OR l=4 then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when 9 =>
							if c=2 OR l=0 OR l=2 OR l=4 OR (c=0 AND l/=3) then
								MontrerElem(F,"8seg"&image(i)&image(c)&image(l));
							else
								CacherElem(F,"8seg"&image(i)&image(c)&image(l));
							end if;
						when others =>
							CacherElem(F,"8seg"&image(i)&image(c)&image(l));
					end case;
				end if;
			end loop;
		end loop;
	end loop;
end ActuLvl;

procedure CreerFenMenu (F: in out TR_Fenetre) is
--{interface graphique initialisée}=>{fenêtre de menu créée}
	
begin
	F:=DebutFenetre("AntiVirus - Menu", 480,680);	
	for i in 0..1 loop
		for c in 0..2 loop
			for l in 0..4 loop
				AjouterBouton(F, "8seg"&image(i)&image(c)&image(l), " ", 128+c*32+128*i, 256+l*32, 32, 32);
				ChangerEtatBouton(F, "8seg"&image(i)&image(c)&image(l), arret);
				ChangerCouleurFond(F, "8seg"&image(i)&image(c)&image(l), FL_black);
			end loop;
		end loop;
	end loop;
	AjouterBouton(F, "do", "<==", 32, 320, 64, 32);
	AjouterBouton(F, "up", "==>", 384, 320, 64, 32);	
	AjouterBouton(F, "go", "  ===>   JOUER   <===  ", 96, 480, 278, 64); 	
	AjouterTexte(F, "titre","ANTIVIRUS", 150, 96, 400, 48);
	ChangerTailleTexte(F, "titre", FL_LARGE_SIZE);
	ChangerCouleurTexte(F, "titre", FL_white);
	ChangerStyleTexte(F, "titre", FL_SHADOW_STYLE);
	
	FinFenetre(F);
end CreerFenMenu;

function Couleur(V : in TV_Virus; l,c : in integer) return T_couleur is
--{V rempli, 1<=l<=7, 0<=c<=6}=>{retourne la couleur de la case V(l,c)}
begin
	case V(l,character'val(character'pos('A')+c)) is
		when rouge =>
			return (FL_red);
		when turquoise =>
			return (FL_darkcyan);
		when orange =>
			return (FL_darkorange);
		when rose =>
			return (FL_orchid);
		when marron =>
			return (FL_darktomato);
		when bleu =>
			return (FL_dogerblue);
		when violet =>
			return (FL_slateblue);
		when vert =>
			return (FL_palegreen);
		when jaune =>
			return (FL_yellow);
		when blanc =>
			return (FL_white);
		when vide =>
			return (FL_col1);
	end case;
end Couleur;

procedure CreerFenGrille (F: in out TR_Fenetre; niveau, nbcoups, nberreur : in integer) is
	--{interface graphique initialisée}=>{fenêtre de jeu principale créée}
	lire:boolean:=true;
begin
	F:=DebutFenetre("AntiVirus - Jeu", 480,680);
	
	-- CREATION DES PETITES ENTREPIECES :
	for c in 0..6 loop
		for l in 1..7 loop
			if lire then
				lire:=false;
			else
				AjouterBouton(F, character'val(character'pos('A')+c) & image(l)(2)," ", 78+c*48, 30+l*48, 36, 36);
				ChangerEtatBouton(F, character'val(character'pos('A')+c) & image(l)(2), arret);
				lire:=true;
			end if;
		end loop;
	end loop;
	
	-- CREATION DES GROSSES PIECES PRINCIPALES :
	lire:=true;
	for c in 0..6 loop
		for l in 1..7 loop
			if lire then
				AjouterBouton(F, character'val(character'pos('A')+c) & image(l)(2)," ", 64+c*48, 16+l*48, 64, 64);
				ChangerTailleTexte(F, character'val(character'pos('A')+c) & image(l)(2), FL_HUGE_SIZE);
				ChangerCouleurTexte(F, character'val(character'pos('A')+c) & image(l)(2), FL_white);	
				lire:=false;
			else
				lire:=true;
			end if;
		end loop;
	end loop;
	
	-- CREATION DES BOUTONS DE COMMANDE :
	AjouterBouton(F, "hg", "<\", 256, 480, 64, 64);
	AjouterBouton(F, "bg", "</", 256, 576, 64, 64);
	AjouterBouton(F, "hd", "/>", 352, 480, 64, 64);
	AjouterBouton(F, "bd", "\>", 352, 576, 64, 64);
	
	-- CREATION ANARCHIQUE D'UN JOLI BLOC DE TEXTE A TROIS LIGNES, SANS IMMONDE BARRE DE DEFILEMENT :
	AjouterBouton(F, "fondtx", "\>", 64, 464, 160, 64);
	ChangerEtatBouton(F, "fondtx", arret);
	ChangerCouleurFond(F, "fondtx", FL_white);
	AjouterTexteAscenseur(F, "tx1", "", "", 65, 465, 158, 21); -- ENFAIT C'EST DES A(S)CENSEUR CAR ON PEUT PAS MODIFIER LES TEXTE
	ChangerCouleurFond(F,"tx1",FL_white);
	AjouterTexteAscenseur(F, "tx2", "", "", 65, 486, 158, 21); -- A NOUS DONC DE NE PAS DEPASSER 
	ChangerCouleurFond(F,"tx2",FL_white);
	AjouterTexteAscenseur(F, "tx3", "", "", 65, 507, 158, 20);
	ChangerCouleurFond(F,"tx3",FL_white);
	-- CREATION DES BOUTONS D OPTIONS 	
	AjouterBouton(F, "rg", "Regles", 64, 560, 64, 32);
	AjouterBouton(F, "qu", "Quitter", 160, 560, 64, 32);
	AjouterBouton(F, "rp", "Recommencer", 80, 624, 128, 32);
	-- CREATION DES TEXTES D INFORMATIONS SUR LE JEU
	AjouterTexte(F, "cp", "Coup : " & image(nbcoups), 250, 24, 200, 20);
	AjouterTexte(F, "Er", "Erreur : " & image(nberreur), 320, 24, 200, 20);
	AjouterTexte(F, "niv", "Niveau : " & image(niveau), 24, 24, 200, 20);
	FinFenetre(F);
	
end CreerFenGrille;

procedure Actualiser (F: in out TR_Fenetre; V : in TV_Virus; niveau, nbcoups, nberreur : in integer) is
--{Fenêtre déjà créée avec CreerFenGrille}=>{Fenêtre mise à jour avec le nouveau V}
	lire:boolean:=true;
begin

	ChangerTexte(F, "cp", "Coup :" & image(nbcoups));
	changerTexte(F, "niv", "Niveau : " & image(niveau));

	if nberreur>1 then
		ChangerTexte(F, "Er", "Erreurs : " & image(nberreur));	
	else
		ChangerTexte(F, "Er", "Erreur : " & image(nberreur));
	end if;

	for c in 0..6 loop
		for l in 1..7 loop
			if lire then
				-- COLORIAGE DES GROSSES PIECES PRINCIPALES :
				ChangerEtatBouton(F, character'val(character'pos('A')+c) & image(l)(2), marche);
				ChangerTexte(F, character'val(character'pos('A')+c) & image(l)(2), " ");
				ChangerCouleurFond(F, character'val(character'pos('A')+c) & image(l)(2), Couleur(V,l,c));	
				if V(l,character'val(character'pos('A')+c))=blanc OR V(l,character'val(character'pos('A')+c))=vide then
					ChangerEtatBouton(F, character'val(character'pos('A')+c) & image(l)(2), arret);
				end if;	
				lire:=false;
			else
				-- COLORIAGE DES PETITES ENTREPIECES :
				ChangerCouleurFond(F, character'val(character'pos('A')+c) & image(l)(2), FL_col1);
				if 0<c AND c<6 then --LIEN HORIZONTAL
					if V(l,character'val(character'pos('A')+c+1))=V(l,character'val(character'pos('A')+c-1))
					AND V(l,character'val(character'pos('A')+c+1))/=vide
					AND V(l,character'val(character'pos('A')+c+1))/=blanc then
						ChangerCouleurFond(F, character'val(character'pos('A')+c) & image(l)(2), Couleur(V,l,c-1));
					end if;
				end if;
				if 1<l AND l<7 then --LIEN VERTICAL
					if V(l+1,character'val(character'pos('A')+c))=V(l-1,character'val(character'pos('A')+c))
					AND V(l+1,character'val(character'pos('A')+c))/=vide
					AND V(l+1,character'val(character'pos('A')+c))/=blanc then
						ChangerCouleurFond(F, character'val(character'pos('A')+c) & image(l)(2), Couleur(V,l-1,c));
					end if;
				end if;
				lire:=true;
			end if;
		end loop;
	end loop;
end Actualiser;

procedure SelectionnerPiece (F : in out TR_Fenetre; V: in TV_Virus; P: in T_Piece) is
--{Fenêtre déjà créée avec CreerFenGrille}=>{Fenêtre mise à jour avec la pièce en subrillance}
	l:T_lig:=1;
	c:T_col:='A';
begin
	while not (l=7 AND c='G') loop
		if V(l,c)=P then
			ChangerTexte(F, c & image(l)(2), "O");
		end if;	
		if c='G' then
			c:='A';
			l:=l+1;
		else
			c:=Character'succ(c);
		end if;
	end loop;
	if V(l,c)=P AND l=7 AND c='G'then 
		ChangerTexte(F, c & image(l)(2), "O");
	end if;
end SelectionnerPiece;

procedure CreerFenScore (F: in out TR_Fenetre) is
	--{interface graphique initialisée}=>{fenêtre de score créée}
begin
	F:=DebutFenetre("AntiVirus - Score", 480,680);
	
	AjouterTexte(F, "titre","Vous avez reussi le niveau X !", 68, 40, 400, 48);
	ChangerTailleTexte(F, "titre", FL_LARGE_SIZE);
	ChangerCouleurTexte(F, "titre", FL_white);
	ChangerStyleTexte(F, "titre", FL_SHADOW_STYLE);
	
	AjouterBouton(F, "qu", "Quitter", 312, 560, 80, 32);

	AjouterBouton(F, "me", "Menu", 105, 560, 80, 32);
	AjouterBouton(F, "nx", "Niveau Suivant", 120, 630, 256, 32);
	AjouterTexteAscenseur(F, "scores","", "", 64, 160, 352, 32);
	ChangerCouleurTexte(F, "scores", FL_white);
	ChangerCouleurFond(F, "scores", FL_inactive);
	
	for i in 0..9 loop
		AjouterTexteAscenseur(F, "nom" & image(i)(2),"", "", 64, 192+32*i, 234, 32);
		ChangerCouleurFond(F, "nom" & image(i)(2), FL_col1);
		AjouterBouton(F,"score" & image(i)(2), "", 298, 192+32*i, 117, 32);
		ChangerEtatBouton(F,"score" & image(i)(2), arret);
	end loop;
	FinFenetre(F);
	
end CreerFenScore;

function EntrerNom return string is
	-- {interface graphique initialisé}=>{Affiche une fenêtre qui demande le pseudo du joueur}
	F:TR_Fenetre;
	NomDuJoueur : string(1..15);
	NomVIDE : CONSTANT string(1..15) := (others=>' '); 
	input : string(1..2) := "  ";
	valide, troplong, tropcourt, ok : boolean := false;
begin
	F:=DebutFenetre("AntiVirus - Score", 320, 176);
	AjouterChamp (F, "CP", "Entrez votre pseudo :", "anonymous", 165, 50, 115, 30);
	AjouterBouton(F, "BV", "Valider", 120, 100, 70, 30);
	AjouterTexte(F, "TL", "Veuillez prendre un pseudo plus court !", 30,150, 250, 30);
	AjouterTexte(F, "TC", "Pas de nom, pas de Chocobon !", 50,150, 250, 30);
	CacherElem(F, "TL");
	CacherElem(F, "TC");
	FinFenetre(F);
	MontrerFenetre(F);
	
	while not ok loop
		input := AttendreBouton(F);
		MontrerFenetre(F);
		if ConsulterContenu(F, "CP")'length > (NomDuJoueur'length - 1) then
			if tropcourt then
				CacherElem(F, "TC");
				tropcourt := not tropcourt;
			end if;
			MontrerElem(F, "TL");
			troplong := true;
		elsif ConsulterContenu(F, "CP")="" then
			if troplong then
				CacherElem(F, "TL");
				troplong := not troplong;
			end if;
			MontrerElem(F, "TC");
			tropcourt := true;
		elsif ConsulterContenu(F, "CP")'length < NomDuJoueur'length then
			NomDuJoueur := (ConsulterContenu(F, "CP") &  NomVIDE(1..(15 - (ConsulterContenu(F, "CP")'length))));
			ok := true;
			if NomDuJoueur=NomVIDE then
				ok := not ok;
			end if;
		end if;
	end loop;	

	CacherFenetre(F);
	return NomDuJoueur;

end EntrerNom;

procedure CreerFenRegle (F : in out TR_Fenetre) is
--{interface graphique initialisée}=>{Fenêtre expliquant les règles créée}
begin
								
	F := DebutFenetre("AntiVirus - Regles", 240, 340);
	AjouterTexte(F, "CR1", "Objectif :", 16, 16, 120, 15);
	AjouterTexte(F, "CR2", "Vous devez placer la piece rouge", 16, 56, 220, 25);
	AjouterTexte(F, "CR3", "appelee  virus  dans le coin  en ", 16, 80, 220, 25);
	AjouterTexte(F, "CR4", "haut  a  gauche .  Pour  cela ", 16, 104, 220, 25);
	AjouterTexte(F, "CR5", "selectionnez les pieces  coloree ", 16, 128, 220, 25);
	AjouterTexte(F, "CR6", "et deplacez les avec les boutons", 16, 152, 220, 25);
	AjouterTexte(F, "CR7", "prevu a cet effet.", 16, 176, 220, 23);
	AjouterTexte(F, "CR8", "Maintenant l'AntiVirus c'est toi !", 16, 250, 220, 23);
	AjouterBouton(F, "OK", "OK", 90, 300, 64, 32);
	FinFenetre(F);
	
end CreerFenRegle;

end p_vuegraph;
