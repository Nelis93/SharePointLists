Set(
    profiles,
    {
        isAdmin: User().Email = "Nelis.Eerdekens@police.belgium.eu"
    }
);
Set(
    timers,
    {
        valNotifMsgTimer: false
    }
);
Set(
    system,
    {
        isNotDirectModification: false,
        isRendered: false,
        isTutorialSeen: false
    }
);
Set(
    changes,
    {
        confiChange: false,
        topicChange: false
    }
);
Set(PrintLanguage, false); 
Set(
    visibility,
    {
        BodyF: false,
        BodyN: false,
        PrintScaleVis:false,
        PrintLangVis:false,
        PrintSelectedVis:true
    }
);
Set(
    validationRequest,
    {
        isValidationRequested: false,
        validationRequestCommentForDirCom: If(Language()  = "fr-FR",
            "Ce signal peut être important pour DirCom. Votre évaluation est demandée.", 
            "Dit signaal kan van belang zijn voor DirCom. Uw beoordeling wordt gevraagd.")
    }
);
Set(
    validation,
    {
        directValidationComment: If(Language()  = "fr-FR",
            "Le signal a été validé directement par son auteur.", 
            "Het signaal werd rechtstreeks gevalideerd door de opsteller.")
    }
);
Set(
    messages,
    {
        nonAuthMsg: If(Language()  = "fr-FR", 
            "Vous n'êtes pas autorisé à modifier le signal. (Si vous n'êtes pas d'accord, contactez dri.intelligence@police.belgium.eu)", 
            "U bent niet gemachtigd het signaal te bewerken. (Indien u niet akkoord bent, contacteer ons via dri.intelligence@police.belgium.eu)"
        ),
        waitOnUpdatesMsg: If(Language()  = "fr-FR", 
            "Veuillez patienter pour les mises à jour (actualisez la page après ca. 5 mins)", 
            "Gelieve te wachten op de updates (vernieuw de pagina na 5 minuten)"
        ),
        waitOnDataMsg: If(Language()  = "fr-FR", 
            "Veuillez patienter. Vos données personnelles sont en cours de chargement...", 
            "Even geduld nog a.u.b. Uw persoonlijke gegevens worden geladen..."
        ),
        fileReadyMsg: If(Language()  = "fr-FR", 
            "Les données sont prêts à grouper!", 
            "De gegevens zijn klaar voor bundeling!"
        ),
        fileSentMsg: If(Language()  = "fr-FR",
            "Les signaux vous sont envoyés par e-mail", 
            "De signalen worden per e-mail naar u toegezonden"
        ),
        requestSentMsg: If(Language()  = "fr-FR",
            "La demande de validation est envoyée", 
            "Het verzoek om validatie is verzonden"
        ),
        tutorialLoadDataMsg: If(Language()  = "fr-FR",
            "Vos données personnelles sont en cours de chargement...", 
            "Uw persoonlijke gegevens worden geladen..."
        ),
        isAlreadyForDirComMsg: If(Language()  = "fr-FR",
            "Le signal a déjà été signalé comme « For DirCom ».", 
            "Het signaal werd al reeds aangeduid als 'For DirCom'."
        ),
        isNotYetForDirComMsg: If(Language()  = "fr-FR",
            "Le signal n'a pas encore été signalé comme « For DirCom ».", 
            "Dit signaal werd nog niet aangeduid als 'For DirCom'."
        ),
        isAlreadySeenByDirComMsg: If(Language()  = "fr-FR",
            "Le signal a déjà été évalué par DirCom.", 
            "Dit signaal werd reeds geëvalueerd door DirCom."
        ),
        sentForReviewMsg: If(Language()  = "fr-FR",
            "Votre signal a été envoyé pour examen.", 
            "Uw signaal werd verzonden voor review!"
        ),
        isPrioDirComMsg: If(Language()  = "fr-FR",
            "Ce signal était auparavant considéré comme prioritaire par DirCom.", 
            "Dit signaal werd voorheen als prioritair aangeduid door DirCom."
        ),
        isNotPrioDirComMsg: If(Language()  = "fr-FR",
            "Ce signal était auparavant considéré comme non-prioritaire par DirCom.", 
            "Dit signaal werd voorheen als non-prioritair aangeduid door DirCom."
        ),
        confirmPrioDirComMsg: If(Language()  = "fr-FR",
            "Le signal a été classé comme prioritaire.", 
            "Het signaal werd geclasseerd als priotiair."
        ),
        confirmNonPrioDirComMsg: If(Language()  = "fr-FR",
            "Le signal a été classé comme non-prioritaire.", 
            "Het signaal werd geclasseerd als non-priotiair."
        ),
        valRequestSentMsg: If(Language()  = "fr-FR",
            "Le signal a été envoyé pour validation !", 
            "Het signaal werd verzonden ter validatie!"
        ),
        noValidatorsMsg: If(Language()  = "fr-FR",
            "Remplissez au moins un validateur.", 
            "Vul ten minste één validator aan."
        ),
        validatedConfirmedMsg: If(Language()  = "fr-FR",
            "Le signal a été approuvé !", 
            "Het signaal werd goedgekeurd!"
        ),
        validatedDeniedMsg: If(Language()  = "fr-FR",
            "Le signal a été refusé.", 
            "Het signaal werd afgewezen."
        ),
        valRequestCheckMsg: If(Language()  = "fr-FR",
            "Le signal a déjà été envoyé pour validation.", 
            "Het signaal werd al reeds verzonden ter validatie."
        ),
        bodyStructureMsg: If(Language()  = "fr-FR",
            "Structurez votre texte comme suit (formatage possible - texte initial en noir, mises à jour en bleu) : Signal - Preuves/exemples - Analyse/hypothèses - Suivi/approche", 
            "Structureer uw tekst als volgt (opmaak mogelijk - initiële tekst in het zwart, updates in het blauw): Signaal - Evidence/voorbeelden - Analyse/hypotheses - Opvolging/aanpak"
        ),
        status2InfoMsg: If(Language()  = "fr-FR",
            "Ce champ n'est visible que pour les collaborateurs de deuxième ligne. Si vous modifiez un signal existant, l'attribution de ce statut à l'auteur indique que le signal a été repris. Si vous créez un nouveau signal, vous pouvez ajouter ce statut après avoir enregistré la première version, et uniquement si vous faites partie de la cellule d'expertise.", 
            "Dit veld is enkel zichtbaar voor medewerkers op de tweede lijn. Indien u een bestaand signaal bewerkt geeft het toekennen van de status aan de auteur aan dat het signaal werd overgenomen. Indien u een nieuw signaal aanmaakt kan u deze status aanvullen nadat u de eerste versie heeft opgeslagen en enkel als u deeluitmaakt van de expertisecel."
        ),
        tutorialCarouselMsg1a: If(Language()  = "fr-FR",
            "Veuillez patienter pendant que nous chargeons vos données personnelles 🙏",
            "Even geduld a.u.b. terwijl we uw gepersonaliseerde weergave laden 🙏"
        ),
        tutorialCarouselMsg1b: If(Language()  = "fr-FR",
            "Votre fiche a été chargée ! Cliquez sur « Continue » en haut de la page pour continuer ↗️",
            "Uw fiche werd geladen! Klik op 'Continue' bovenaan om verder te gaan ↗️"
        ),
        tutorialCarouselMsg2: If(Language()  = "fr-FR",
            "Les signaux sont créés par des collaborateurs de GPI issus de toute la Belgique !", 
            "Signalen worden opgesteld door medewerkers van GPI van over heel België!"
        ),
        tutorialCarouselMsg3: If(Language()  = "fr-FR",
            "Ensemble, nous construisons une plateforme qui répond à vos besoins.", 
            "We bouwen samen aan een platform dat tegemoet komt aan uw noden."
        ),
        tutorialCarouselMsg4: If(Language()  = "fr-FR",
            "Grâce à vos commentaires et à votre collaboration, nous pouvons optimiser la plateforme.", 
            "Door uw feedback en medewerking kunnen we het platform optimaliseren."
        ),
        newSignalInstructionsMsg: If(Language() = "fr-FR",
            "Copiez le titre en français et coller le dans le champ « Titre néerlandais » et laissez « Signal en néerlandais » vide, sauf si vous disposez d'une traduction. Des signaux ne peuvent pas contenir des infos personnelles!",
            "Laat de Franse titel en het signaal in het Frans leeg, tenzij u over een vertaling beschikt. Signalen mogen geen persoonsgegevens bevatten!"
        ),
        validationNotificationMsg: If(Language() = "fr-FR",
            "La demande de validation est envoyée lorsque vous enregistrez le signal, en haut à gauche. Veillez à laisser le bouton à côté de « Demande de validation » activé.",
            "De aanvraag tot validatie wordt doorgestuurd wanneer u het signaal opslaat, bovenaan links. Laat de toggle naast 'Aanvraag tot validatie' aan staan"
        ),
        pickValMsg: If(Language() = "fr-FR",
            "Choisissez votre validateurs: ",
            "Kies uw validatoren: "
        ),
        yourValidatorsMsg: If(Language()  = "fr-FR",
            "Tes validateurs: ", 
            "Uw validator(en): "
        ),
        noValidatorsSelectedMsg: If(Language()  = "fr-FR",
            "Aucun validateur sélectionné.", 
            "Geen validatoren geselecteerd."
        ),
        dataReloadMsg: If(Language()  = "fr-FR",
            "Actualiser les données →", 
            "Opnieuw laden →"
        ),
        validatorNotificationMsg: If(Language()  = "fr-FR",
            "La demande de validation est envoyée lorsque vous enregistrez le signal, en haut à gauche. Veillez à laisser le bouton à côté de « Demande de validation » activé.", 
            "De aanvraag tot validatie wordt doorgestuurd wanneer u het signaal opslaat, bovenaan links. Laat de toggle naast 'Aanvraag tot validatie' aan staan"
        ),
        flowIsRunningMsg: If(Language()  = "fr-FR", 
            "Le data-flux est en cours. Veuillez réessayer plus tard ...", 
            "De datastroom loopt op dit moment. Probeer het later opnieuw..."
        )
    }
);