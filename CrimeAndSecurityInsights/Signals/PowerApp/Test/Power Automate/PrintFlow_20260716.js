'PrintFlow_Test'.Run(
            JSON(
                {
                    user: User(),
                    language: Language(),
                    signal: {
                        body: 
                            ShowColumns(
                            SharePointIntegration.Selected,
                            'Id (ID)',
                            Titel,
                            Gemaakt,
                            Gewijzigd,
                            Topic,
                            'Gemaakt door',
                            'Gewijzigd door',
                            Team,
                            Recipients,
                            Notify,
                            Editors,
                            Title_F,
                            'Validated (System)',
                            'Status (2)',
                            'Confidentiality ',
                            'Koppeling naar item'
                        ),
                        isNewSignal : false,
                        isTopicChanged: Coalesce(changes.topicChange,false),
                        isConfidentChanged: Coalesce(changes.confiChange,false),
                        isEditorsChanged: Coalesce(changes.editorsChange,false)
                        
                    },
                    signalUpdate: {
                        body: 
                            ShowColumns(
                            SharePointForm.Updates,
                            Titel,
                            Title_F,
                            Topic,
                            Editors,
                            'Status (2)',
                            'Confidentiality '
                        )
                    },
                    validationRequest: {
                        isValidationRequest: false,
                        validators: Coalesce(Validators,[]),
                        validationRequestComment: Coalesce(validationRequest.validationRequestComment,"No Comment")
                    },
                    validation: {
                        isValidation: false,
                        isDirectValidation: false,
                        validationComment: "No Comment",
                        isApproved: false
                    },
                    dirCom: {
                        isForDirCom: false
                    },
                    priority: {
                        isPrioCall: false,
                        isConfirmed: false,
                        prioCallComment: "No Comment"
                    },
                    print: {
                        isPrint: true,
                        printLanguage: Coalesce(PrintLanguage,false),
                        body: 
                            ShowColumns(
                            colPrintItems,
                            'Id (ID)',
                            Titel,
                            Title_F,
                            Body_N,
                            Body_F
                        )
                    }
                },
                JSONFormat.IncludeBinaryData
            )
        );