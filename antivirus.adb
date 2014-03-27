with p_esiut, p_virus, Ada.Text_Io, Ada.Integer_Text_IO;
use p_esiut, p_virus, p_virus.p_Piece_IO, p_virus.p_Direction_IO, Ada.Text_Io, Ada.Integer_Text_IO;

procedure antivirus is
	f:p_Piece_IO.file_type;
	niveau:integer:=0;
	V:TV_Virus;
	input:character:=' ';
	
	Dir:T_direction;
	Piece:T_piece;
	pieceOK,dirOK:boolean:=false;
begin
	ecrire("Entrez un niveau à jouer (1..20) : "); lire(niveau);
	while niveau<1 OR niveau>20 loop
		ecrire("                J'ai dit (1..20) : "); lire(niveau);
	end loop;
	
	open(f,in_file,"Parties");
	CreeVectVirus(f,niveau,V);
	ecrire_ligne("============== AFFICHAGE VECTEUR : ========================================================");
	AfficheVectVirus(V);
	ecrire_ligne("============== AFFICHAGE TABLEAU : ========================================================");
	AfficheGrille(V);
	
	put(ASCII.ESC & "[2J" & ASCII.ESC & "[1;1f");
		
	ecrire_ligne("============== TEST DU JEU ASCII : ========================================================");
	ecrire_ligne("Touches de 1 à 8 et 0 pour les pièces et Numpad 1,3,7,9 pour la direction.");
	AfficheGrille(V);
	while not gueri(V) loop
		Get_Immediate(input);
		case input is
			when '1' | character'val(70) =>
				Dir:=bg;
				ecrire_ligne("Direction Bas-Gauche sélectionnée.");
				dirOK:=true;
			when '7' | character'val(72)=>
				Dir:=hg;
				ecrire_ligne("Direction Haut-Gauche sélectionnée.");
				dirOK:=true;
			when '3' | character'val(54)=>
				Dir:=bd;
				ecrire_ligne("Direction Bas-Droite sélectionnée.");
				dirOK:=true;
			when '9' | character'val(53)=>
				Dir:=hd;
				ecrire_ligne("Direction Haut-Droite sélectionnée.");
				dirOK:=true;
			when '&' =>
				Piece:=turquoise;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when character'val(169) =>
				Piece:=orange;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when '"' =>
				Piece:=rose;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when ''' =>
				Piece:=marron;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when '(' =>
				Piece:=bleu;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when '-' =>
				Piece:=violet;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when character'val(168) =>
				Piece:=vert;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when '_' =>
				Piece:=jaune;
				ecrire_ligne("Pièce" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when character'val(160) =>
				Piece:=rouge;
				ecrire_ligne("Virus" & image(T_Piece'pos(Piece)) & " (" & T_Piece'image(Piece) & ") sélectionnée.");
				pieceOK:=true;
			when others =>
				null;
		end case;
		
		if pieceOK AND not presente(V,T_piece'pos(Piece)) then
			ecrire_ligne("Cette pièce n'est pas sur le terrain, sélection annulée.");
			pieceOK:=false;
		end if;
		
		if pieceOK AND dirOK AND not possible(V,Piece,Dir) then
			ecrire_ligne("Cette pièce ne peut pas être déplacée ainsi, sélection annulée.");
			pieceOK:=false;
			dirOK:=false;
		end if;
		
		if pieceOK AND dirOK then
			deplacement(V,Piece,Dir);
			
			put(ASCII.ESC & "[2J" & ASCII.ESC & "[1;1f");
			
			ecrire_ligne("============== TEST DU JEU ASCII : ========================================================");
			ecrire_ligne("Touches de 1 à 8 et 0 pour les pièces et Numpad 1,3,7,9 pour la direction.");
			AfficheGrille(V);
			
			pieceOK:=false;
			dirOK:=false;
		end if;
		
	end loop;
	
	if gueri(V) then
		ecrire_ligne("Congratulatioooooon ! Vous avez fini le puzzle, youhou !");
		a_la_ligne;
	end if;
	
end antivirus;
