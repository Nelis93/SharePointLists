'BackEndLogFlow'.Run(
            JSON(
                {
                    user: User(),
                    language: Language(),
                    site: "testbeeldsubc",
                    list: "SignaalFt_test",
                    isNewItem: isNewSignal,
                    signals: {
                        signal: {
                            body: 
                                ShowColumns(
                                SharePointForm.LastSubmit,
                                'Id (ID)',
                                Titel,
                                Title_F,
                                Topic,
                                'Status (1)',
                                'Status (2)',
                                Domain,
                                Source,
                                Signal,
                                SignalLocation,
                                Reference,                                
                                Gemaakt,
                                Gewijzigd,
                                'Gemaakt door',
                                'Gewijzigd door',
                                Team,
                                Recipients,
                                Notify,
                                Editors,
                                'Validated (System)',
                                'Confidentiality ',
                                'Koppeling naar item'
                            ),
                            isNewSignal : isNewSignal,
                            isTopicChanged: Coalesce(changes.topicChange,false),
                            isConfidentChanged: Coalesce(changes.confiChange,false),
                            isEditorsChanged: Coalesce(changes.editorsChange,false)
                            
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
                        print: {}
                    },
                    strategicAnalysisProducts: {},
                    barrierModels: {},
                    partners: {}
                },
                JSONFormat.IncludeBinaryData
            )
        );