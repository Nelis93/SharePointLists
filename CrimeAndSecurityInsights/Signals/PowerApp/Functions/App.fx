###### onStart ######
Set(visitorForm, true); 
Set(userForm, false); 
Set(otherTopics,[]); 
Set(BodyF, false); 
Set(BodyN, false); 
Set(infoStatus2, false); 
Set(PrintLanguage, false); 
Set(PrintScaleVis,false);
Set(PrintLangVis,false); 
Set(PrintSelectedVis,true); 
Set(nonAuthMsg, If(Language()  = "fr-FR", 
    "Vous n'êtes pas autorisé à modifier le signal. (Si vous n'êtes pas d'accord, contactez dri.intelligence@police.belgium.eu)", 
    "U bent niet gemachtigd het signaal te bewerken. (Indien u niet akkoord bent, contacteer ons via dri.intelligence@police.belgium.eu)"
));
Set(waitOnUpdatesMsg, If(Language()  = "fr-FR", 
    "Veuillez patienter pour les mises à jour", 
    "Gelieve te wachten op de updates "
));
Set(waitOnDataMsg, If(Language()  = "fr-FR", 
    "Les données ne sont pas encore surchargées. Veuilliez cliquer de nouveau s.v.p.", 
    "De gegevens werden nog niet geladen. Pobeer nogmaals a.u.b."
));
Set(fileReadyMsg, If(Language()  = "fr-FR", 
    "Les données sont prêts à grouper!", 
    "De gegevens zijn klaar voor bundeling!"
));
Set(fileSentMsg, If(Language()  = "fr-FR",
    "Les signaux vous sont envoyés par e-mail", 
    "De signalen worden per e-mail naar u toegezonden"
))