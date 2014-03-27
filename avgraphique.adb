with p_esiut, p_virus, p_vuegraph, p_fenbase, Ada.Calendar;
use p_esiut, p_virus, p_vuegraph, p_virus.p_Piece_IO, p_virus.p_Score_IO, p_fenbase, Ada.Calendar;

procedure avgraphique is
	file:p_Piece_IO.file_type;
	files:p_Score_IO.file_type;
	niveau:integer:=1;
	F, Fscore, Fmenu, Fregle:TR_Fenetre;
	V:TV_Virus;
	nberreurs : integer:=0;
	nbcoups : integer:=0;
	Scores:TV_Score;
	Score,clicks:integer:=0;
	s:string(1..2):="  ";
	nomdujoueur:string(1..15):="               ";
	Tdebut, Tfin: Time;
	Dir:T_direction;
	Piece:T_piece;
	pieceOK,dirOK:boolean:=false;
	temp:TR_Score;

begin		
	open(file,in_file,"Parties");
	InitialiserFenetres;
	CreerFenMenu(Fmenu);
	CreerFenScore(Fscore);
	CreerFenGrille(F, niveau, nbcoups, nberreurs);
	
	while s/="qu" loop
	
		ouverture:
		declare
		begin
			open(files,in_file,"Scores");
			for i in 1..200 loop     -- Test de lecture des 200 Scores.
				p_Score_IO.read(files,temp);
			end loop;
		exception
		when p_Score_IO.NAME_ERROR | p_Score_IO.END_ERROR | p_Score_IO.DATA_ERROR =>
			close(files);
			create(files,out_file,"Scores");
			for i in 1..200 loop
				write(files,((OTHERS=>'.'),0,integer((i-1)/10)+1));
			end loop;
		end ouverture;
		
		if s="nx" then
			niveau:=niveau+1;
		elsif s="rp" then
			nberreurs := 0;
			nbcoups := 0;
			s:="  ";
		else
			MontrerFenetre(Fmenu);
			while s/="go" loop
				ActuLvl(Fmenu, niveau);
				s:=AttendreBouton(Fmenu);
				if s="up" AND niveau<20 then niveau:=niveau+1; end if;
				if s="do" AND niveau>1 then niveau:=niveau-1; end if;
			end loop;
			CacherFenetre(Fmenu);
		end if;
		
		CreeVectVirus(file,niveau,V);	
		Actualiser(F,V, niveau, nbcoups, nberreurs);
		MontrerFenetre(F);
		Tdebut:=Clock;
	
		while not gueri(V) and s/="qu" and s/="rp" loop
			s:=AttendreBouton(F);
		
			if s="hg" OR s="bg" OR s="hd" OR s="bd"  then
				Dir:=T_direction'value(s);
				dirOK:=pieceOK; 
			elsif s="rg" then
				CreerFenRegle(FRegle);
				MontrerFenetre(FRegle);
				while s/="OK" loop
					MontrerFenetre(FRegle);
					s:=AttendreBouton(FRegle);
				end loop;
				CacherFenetre(FRegle);
			elsif s="qu" OR s="rp" then
				null;
			else
				Piece:=V(integer'value((1 => s(2))),s(1));
				actualiser(F,V, niveau, nbcoups, nberreurs);
				SelectionnerPiece(F,V,Piece);
				pieceOK:=true;
			end if;

			if pieceOK AND dirOK AND not possible(V,Piece,Dir) then
				nberreurs := nberreurs +1;
				ChangerContenu(F,"tx1","Cette piece ne peut");
				ChangerContenu(F,"tx2","pas etre deplace ainsi.");
				ChangerContenu(F,"tx3"," ");
				dirOK:=false;
				actualiser(F,V, niveau, nbcoups, nberreurs);
				SelectionnerPiece(F,V,Piece);
			end if;
		
			if pieceOK AND dirOK then
				nbcoups:= nbcoups+1;
				deplacement(V,Piece,Dir);
				actualiser(F,V, niveau, nbcoups, nberreurs);
				SelectionnerPiece(F,V,Piece);
				ChangerContenu(F,"tx1"," ");
				ChangerContenu(F,"tx2"," ");
				ChangerContenu(F,"tx3"," ");
				dirOK:=false;
			end if;	

			clicks:=clicks+1;
		end loop;
	
		if gueri(V) then

			Tfin:=clock;
			Score:=(256-clicks)*4+360-integer(Tfin-Tdebut);
			if Score<1 then Score:=1; end if;
			CacherFenetre(F);

			ChangerTexte(Fscore, "titre","Vous avez reussi le niveau" & image(niveau) & " !");
			if niveau=20 then changerEtatBouton(Fscore, "nx", Arret); else changerEtatBouton(Fscore, "nx", Marche); end if;
			
			CreeVectScore(files,niveau,Scores);
		
			if score>Scores(10).Score then
				nomdujoueur:=entrernom;		
				Scores(10).score:=score;
				Scores(10).nom:=nomdujoueur;
				TriScore(Scores);
				SaveScore(Scores, files, niveau);
			end if;
			
			MontrerFenetre(Fscore);

			ChangerContenu(Fscore,"scores", "            NOM                                              SCORE");
			
			for i in 0..9 loop
				ChangerContenu(Fscore,"nom" & image(i)(2), "   " & Scores(i+1).Nom);
				ChangerTexte(Fscore,"score" & image(i)(2) , image(Scores(i+1).Score));
			end loop;
		
			s:=AttendreBouton(Fscore);	
			nbcoups := 0; nberreurs :=0;
		end if;

		close(files);

	end loop;
	close(file);
end avgraphique;
