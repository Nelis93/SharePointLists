'ValidationFlow_Test'.Run(
            JSON(
                {
                    user: User(),
                    language: Language(),
                    signal: {
                        body: 
                            ShowColumns(
                            SharePointForm.LastSubmit,
                            'Id (ID)',
                            Titel,
                            Title_F,
                            Gemaakt,
                            Gewijzigd,
                            Topic,
                            'Gemaakt door',
                            'Gewijzigd door',
                            Team,
                            Recipients,
                            Notify,
                            Editors,
                            'Validated (System)',
                            'Status (1)',
                            'Status (2)',
                            'Confidentiality ',
                            'Koppeling naar item'
                        ),
                        isNewSignal : isNewSignal,
                        isTopicChanged: Coalesce(changes.topicChange,false),
                        isConfidentChanged: Coalesce(changes.confiChange,false),
                        isEditorsChanged: Coalesce(changes.editorsChange,false)
                        
                    },
                    signalUpdate: {
                        body: 
                            ShowColumns(
                            SharePointForm.LastSubmit,
                            'Id (ID)',
                            Titel,
                            Title_F,
                            Gemaakt,
                            Gewijzigd,
                            Topic,
                            'Gemaakt door',
                            'Gewijzigd door',
                            Team,
                            Recipients,
                            Notify,
                            Editors,
                            'Validated (System)',
                            'Status (1)',
                            'Status (2)',
                            'Confidentiality ',
                            'Koppeling naar item'
                        )
                    },
                    validationRequest: {
                        isValidationRequest: Coalesce(validationRequest.isValidationRequest,false),
                        validators: If(isNewSignal,NewValidators,Validators),
                        validationRequestComment: Coalesce(validationRequest.validationRequestComment,"No Comment")
                    },
                    validation: {
                        isValidation: Or(validation.isDirectValidation,validation.isValidation),
                        isDirectValidation: Coalesce(validation.isDirectValidation,false),
                        validationComment: If(
                                                validation.isDirectValidation,
                                                    validation.directValidationComment,
                                                Coalesce(validation.validatorCommentText,"No Comment")
                        ),
                        isApproved: Or(validation.isDirectValidation,validation.isValidated)
                    },
                    dirCom: {
                        isForDirCom: validationRequest.isForDirCom
                    },
                    priority: {
                        isPrioCall: priority.isPrioCall,
                        isConfirmed: priority.isPrioConfirmed,
                        prioCallComment: priority.prioCallComment
                    },
                    print: {
                        isPrint: false,
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