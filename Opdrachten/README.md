# De Opdrachten

Op deze pagina vinden jullie alle opdrachten en instructies voor het project.
Het handigste is als je dit naar je computer downloadt, want als je dan het R-project `Opdrachten.Rproj` opent op je eigen computer, maakt dat het allemaal wat makkelijker.

## Inhoud

Als het goed is, spreekt het allemaal redelijk voor zich, maar alsnog hierbij een klein overzichtje van wat jullie deze dagen gaan doen. Het nummer voor de bestanden wijst ook naar de dag waarop jullie waarschijnlijk de meeste tijd aan dit onderdeel van het project besteden.

* Dag 1 en 2 - QC en voorbereiding
  * data en software klaarmaken
  * kwaliteitscontrole van de data
  * goede voorbereiding is het halve werk
  * interesante SNPs opzoeken
* Dag 3 - Analyse
  * de analyse wordt gerund
  * bedenk wat je kunt verwachten
* Dag 4 - Verwerking en interpretatie
  * interpreteren resultaten
  * begrijpen mechanismes
  * literatuur vergelijken met eigen resultaten


## Dag 1 en 2 - QC en voorbereiding

Voor we echt gaan beginnen moeten we een paar dingen controleren. Allereerst gaan jullie, naast R, met nog een type software werken, zogenaamd plink. Zorg ervoor dat deze [gedownload](http://zzz.bwh.harvard.edu/plink/download.shtml) is op de computer waarop je gaat werken. Het is handig om het bestandje `plink.exe`, dat nu gedownload is, in de map `Software` te zetten als je alles van deze website gedownload hebt.

 De data stuur ik jullie via beveiligde mail, omdat dit zeer privacy-gevoelig is.

Als je op een Windows computer werkt, is het handig om ook nog een terminal te downloaden. Ik raad [MobaXterm](https://mobaxterm.mobatek.net/download-home-edition.html) aan. Open na het downloaden de terminal en typ het volgende, maar vervang met het juiste pad:
```bash
# Voeg plink toe aan je pad
echo "export PATH=pad/naar/U-Talent_GWAS-main/Software:$PATH" >> .bashrc

# Zorg ervoor dat het voortaan makkelijk is om plink te runnen
source .bashrc

# Test
plink
```

Als het goed is zie je nu zoiets als het volgende:
```
@----------------------------------------------------------@
|        PLINK!       |     v1.07      |   10/Aug/2009     |
|----------------------------------------------------------|
|  (C) 2009 Shaun Purcell, GNU General Public License, v2  |
|----------------------------------------------------------|
|  For documentation, citation & bug-report instructions:  |
|        http://pngu.mgh.harvard.edu/purcell/plink/        |
@----------------------------------------------------------@

Web-based version check ( --noweb to skip )
Connecting to web...
```

Als alles klopt, kunnen jullie nu aan de slag met het bestand `1.QC.md`.
