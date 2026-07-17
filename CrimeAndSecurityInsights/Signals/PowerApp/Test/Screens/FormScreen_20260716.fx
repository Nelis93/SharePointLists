Screens:
  FormScreen:
    Properties:
      Fill: =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height, 2200)
      LoadingSpinner: =LoadingSpinner.Data
      LoadingSpinnerColor: =RGBA(0, 120, 212, 1)
      OnVisible: |-
        =Set(
            visibility,
            Patch(
                visibility,
                {
                    VListVis: CountRows(Validators)>0
                }
            )
        );
        Set(
            system,
            Patch(
                system,
                {
                    isRendered: false
                }
            )
        );
        If(Or(profiles.isAdmin,Lower(User().Email) = "isabelle.vanransbeeck@police.belgium.eu"),Notify("@Isabelle - Dit is de laatste versie van de app (03/07/26)!",NotificationType.Information,5000));
        If(Or(profiles.isAdmin,Lower(User().Email) = "isabelle.vanransbeeck@police.belgium.eu"),Notify("isValidator: " & profiles.isValidator,NotificationType.Information,5000));
        If(Or(profiles.isAdmin,Lower(User().Email) = "isabelle.vanransbeeck@police.belgium.eu"),Notify("isValidatorScoped: " & profiles.isValidatorScoped,NotificationType.Information,5000));
        Reset(RequestValidation_Toggle)
      Width: =Max(App.Width, 1500)
    Children:
      - SharePointForm:
          Control: Form@2.4.4
          Variant: Classic
          Layout: Vertical
          Properties:
            BorderColor: =RGBA(166, 166, 166, 1)
            DataSource: =[@SignaalFt_test]
            DefaultMode: =FormMode.View
            Height: =Parent.Height - Self.Y
            Item: =SharePointIntegration.Selected
            NumberOfColumns: =2
            OnSuccess: "='ValidationFlow_Test'.Run(\r\n            JSON(\r\n                {\r\n                    user: User(),\r\n                    language: Language(),\r\n                    signal: {\r\n                        body: \r\n                            ShowColumns(\r\n                            SharePointForm.LastSubmit,\r\n                            'Id (ID)',\r\n                            Titel,\r\n                            Title_F,\r\n                            Gemaakt,\r\n                            Gewijzigd,\r\n                            Topic,\r\n                            'Gemaakt door',\r\n                            'Gewijzigd door',\r\n                            Team,\r\n                            Recipients,\r\n                            Notify,\r\n                            Editors,\r\n                            'Validated (System)',\r\n                            'Status (1)',\r\n                            'Status (2)',\r\n                            'Confidentiality ',\r\n                            'Koppeling naar item'\r\n                        ),\r\n                        isNewSignal : isNewSignal,\r\n                        isTopicChanged: Coalesce(changes.topicChange,false),\r\n                        isConfidentChanged: Coalesce(changes.confiChange,false),\r\n                        isEditorsChanged: Coalesce(changes.editorsChange,false)\r\n                        \r\n                    },\r\n                    signalUpdate: {\r\n                        body: \r\n                            ShowColumns(\r\n                            SharePointForm.LastSubmit,\r\n                            'Id (ID)',\r\n                            Titel,\r\n                            Title_F,\r\n                            Gemaakt,\r\n                            Gewijzigd,\r\n                            Topic,\r\n                            'Gemaakt door',\r\n                            'Gewijzigd door',\r\n                            Team,\r\n                            Recipients,\r\n                            Notify,\r\n                            Editors,\r\n                            'Validated (System)',\r\n                            'Status (1)',\r\n                            'Status (2)',\r\n                            'Confidentiality ',\r\n                            'Koppeling naar item'\r\n                        )\r\n                    },\r\n                    validationRequest: {\r\n                        isValidationRequest: Coalesce(validationRequest.isValidationRequest,false),\r\n                        validators: If(isNewSignal,NewValidators,Validators),\r\n                        validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\r\n                    },\r\n                    validation: {\r\n                        isValidation: Or(validation.isDirectValidation,validation.isValidation),\r\n                        isDirectValidation: Coalesce(validation.isDirectValidation,false),\r\n                        validationComment: If(\r\n                                                validation.isDirectValidation,\r\n                                                    validation.directValidationComment,\r\n                                                Coalesce(validation.validatorCommentText,\"No Comment\")\r\n                        ),\r\n                        isApproved: Or(validation.isDirectValidation,validation.isValidated)\r\n                    },\r\n                    dirCom: {\r\n                        isForDirCom: validationRequest.isForDirCom\r\n                    },\r\n                    priority: {\r\n                        isPrioCall: priority.isPrioCall,\r\n                        isConfirmed: priority.isPrioConfirmed,\r\n                        prioCallComment: priority.prioCallComment\r\n                    },\r\n                    print: {\r\n                        isPrint: false,\r\n                        printLanguage: Coalesce(PrintLanguage,false),\r\n                        body: \r\n                            ShowColumns(\r\n                            colPrintItems,\r\n                            'Id (ID)',\r\n                            Titel,\r\n                            Title_F,\r\n                            Body_N,\r\n                            Body_F\r\n                        )\r\n                    }\r\n                },\r\n                JSONFormat.IncludeBinaryData\r\n            )\r\n        );\r\n'BackEndLogFlow'.Run(\r\n            JSON(\r\n                {\r\n                    user: User(),\r\n                    language: Language(),\r\n                    site: \"testbeeldsubc\",\r\n                    list: \"SignaalFt_test\",\r\n                    isNewItem: isNewSignal,\r\n                    signals: {\r\n                        signal: {\r\n                            body: \r\n                                ShowColumns(\r\n                                SharePointForm.LastSubmit,\r\n                                'Id (ID)',\r\n                                Titel,\r\n                                Title_F,\r\n                                Topic,\r\n                                'Status (1)',\r\n                                'Status (2)',\r\n                                Domain,\r\n                                Source,\r\n                                Signal,\r\n                                SignalLocation,\r\n                                Reference,                                \r\n                                Gemaakt,\r\n                                Gewijzigd,\r\n                                'Gemaakt door',\r\n                                'Gewijzigd door',\r\n                                Team,\r\n                                Recipients,\r\n                                Notify,\r\n                                Editors,\r\n                                'Validated (System)',\r\n                                'Confidentiality ',\r\n                                'Koppeling naar item'\r\n                            ),\r\n                            isNewSignal : isNewSignal,\r\n                            isTopicChanged: Coalesce(changes.topicChange,false),\r\n                            isConfidentChanged: Coalesce(changes.confiChange,false),\r\n                            isEditorsChanged: Coalesce(changes.editorsChange,false)\r\n                            \r\n                        },\r\n                        validationRequest: {\r\n                            isValidationRequest: Coalesce(validationRequest.isValidationRequest,false),\r\n                            validators: If(isNewSignal,NewValidators,Validators),\r\n                            validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\r\n                        },\r\n                        validation: {\r\n                            isValidation: Or(validation.isDirectValidation,validation.isValidation),\r\n                            isDirectValidation: Coalesce(validation.isDirectValidation,false),\r\n                            validationComment: If(\r\n                                                    validation.isDirectValidation,\r\n                                                        validation.directValidationComment,\r\n                                                    Coalesce(validation.validatorCommentText,\"No Comment\")\r\n                            ),\r\n                            isApproved: Or(validation.isDirectValidation,validation.isValidated)\r\n                        },\r\n                        dirCom: {\r\n                            isForDirCom: validationRequest.isForDirCom\r\n                        },\r\n                        priority: {\r\n                            isPrioCall: priority.isPrioCall,\r\n                            isConfirmed: priority.isPrioConfirmed,\r\n                            prioCallComment: priority.prioCallComment\r\n                        },\r\n                        print: {}\r\n                    },\r\n                    strategicAnalysisProducts: {},\r\n                    barrierModels: {},\r\n                    partners: {}\r\n                },\r\n                JSONFormat.IncludeBinaryData\r\n            )\r\n        );\r\nResetForm(Self); \r\nRequestHide();\r\nClear(NewValidators);\r\nClear(Validators);\r\n"
            Width: =Parent.Width - Self.X
            X: =50
            Y: =150
          Children:
            - Titel_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicTextualEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Title"
                  Default: =ThisItem.Titel
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Titel)
                  Height: =100
                  MaxLength: =DataSourceInfo([@SignaalFt_test], DataSourceInfo.MaxLength, Titel)
                  Required: =false
                  Update: =DataCardValue1.Text
                  Width: =Parent.Width
                  X: =0
                  Y: =0
                Children:
                  - DataCardKey1:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Titre néerlandais","Titel")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue1:
                      Control: Classic/TextInput@2.3.2
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        Default: =Parent.Default
                        DelayOutput: =true
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        MaxLength: =Parent.MaxLength
                        PaddingLeft: =5
                        PressedBorderColor: =RGBA(0, 120, 212, 1)
                        PressedColor: =RGBA(51, 51, 51, 1)
                        PressedFill: =RGBA(255, 255, 255, 1)
                        RadiusBottomLeft: =0
                        RadiusBottomRight: =0
                        RadiusTopLeft: =0
                        RadiusTopRight: =0
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =1000
                        X: =32
                        Y: =DataCardKey1.Y + DataCardKey1.Height + 5
                  - ErrorMessage1:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue1.Y + DataCardValue1.Height
            - Title_F_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicTextualEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Title_F"
                  Default: =ThisItem.Title_F
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Title_F)
                  Height: =100
                  MaxLength: =DataSourceInfo([@SignaalFt_test], DataSourceInfo.MaxLength, Title_F)
                  Required: =false
                  Update: =DataCardValue11.Text
                  Width: =Parent.Width
                  X: =0
                  Y: =1
                Children:
                  - DataCardKey11:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Titre","Franse titel")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue11:
                      Control: Classic/TextInput@2.3.2
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        Default: =Parent.Default
                        DelayOutput: =true
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayMode: =Parent.DisplayMode
                        Fill: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        MaxLength: =Parent.MaxLength
                        PaddingLeft: =5
                        PressedBorderColor: =RGBA(0, 120, 212, 1)
                        PressedColor: =RGBA(51, 51, 51, 1)
                        PressedFill: =RGBA(255, 255, 255, 1)
                        RadiusBottomLeft: =0
                        RadiusBottomRight: =0
                        RadiusTopLeft: =0
                        RadiusTopRight: =0
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =1000
                        X: =32
                        Y: =DataCardKey11.Y + DataCardKey11.Height + 5
                  - ErrorMessage11:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue11.Y + DataCardValue11.Height
            - Body_N_DataCard2:
                Control: TypedDataCard@1.0.7
                Variant: ClassicRichTextEditorEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Body_N"
                  Default: =ThisItem.Body_N
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Body_N)
                  Height: =100
                  Required: =false
                  Update: =DataCardValue14.HtmlText
                  Width: =Parent.Width
                  X: =0
                  Y: =2
                Children:
                  - DataCardKey14:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Signal en néerlandais","Signaal")
                        Width: =300
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue14:
                      Control: RichTextEditor@2.7.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =RGBA(166, 166, 166, 1)
                        Default: =Parent.Default
                        DisplayMode: =Parent.DisplayMode
                        Height: =If(visibility.BodyN, 400, 0)
                        Size: =14
                        Visible: =visibility.BodyN
                        Width: =Parent.Width - 200
                        X: =32
                        Y: =DataCardKey14.Y + DataCardKey14.Height + 5
                  - ErrorMessage14:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =If(visibility.BodyN, 50, 0)
                        Italic: =true
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =14
                        Text: =If(Len(ThisItem.Body_N)>0,"",messages.bodyStructureMsg)
                        Visible: =visibility.BodyN
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue14.Y + DataCardValue14.Height
                  - ToggleBodyN:
                      Control: Classic/Icon@2.5.0
                      Properties:
                        BorderColor: =RGBA(51, 51, 153, 1)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(220, 220, 220, 1)
                        DisabledFill: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Height: =30
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverFill: =RGBA(0, 0, 0, 0)
                        Icon: =Icon.ChevronDown
                        OnSelect: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      BodyN: !visibility.BodyN,
                                      BodyF: false
                                  }
                              )
                          );
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        PressedBorderColor: =RGBA(0, 0, 0, 0)
                        PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedFill: =RGBA(0, 0, 0, 0)
                        Rotation: =If(visibility.BodyN, 180, 0)
                        Width: =30
                        X: =400
                        Y: =20
            - Body_F_DataCard2:
                Control: TypedDataCard@1.0.7
                Variant: ClassicRichTextEditorEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Body_F"
                  Default: =ThisItem.Body_F
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Body_F)
                  Height: =100
                  Required: =false
                  Update: =DataCardValue12.HtmlText
                  Width: =Parent.Width
                  X: =1
                  Y: =3
                Children:
                  - DataCardKey12:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Signal","Signaal in het Frans")
                        Width: =300
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue12:
                      Control: RichTextEditor@2.7.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =RGBA(166, 166, 166, 1)
                        Default: =Parent.Default
                        DisplayMode: =Parent.DisplayMode
                        Height: =If(visibility.BodyF, 400, 0)
                        Size: =14
                        Visible: =visibility.BodyF
                        Width: =Parent.Width - 200
                        X: =32
                        Y: =DataCardKey12.Y + DataCardKey12.Height + 5
                  - ErrorMessage12:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =If(visibility.BodyF, 50, 0)
                        Italic: =true
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =14
                        Text: =If(Len(ThisItem.Body_F)>0,"",messages.bodyStructureMsg)
                        Visible: =visibility.BodyF
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue12.Y + DataCardValue12.Height
                  - ToggleBodyF:
                      Control: Classic/Icon@2.5.0
                      Properties:
                        BorderColor: =RGBA(51, 51, 153, 1)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(220, 220, 220, 1)
                        DisabledFill: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Height: =30
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverFill: =RGBA(0, 0, 0, 0)
                        Icon: =Icon.ChevronDown
                        OnSelect: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      BodyF: !visibility.BodyF,
                                      BodyN: false
                                  }
                              )
                          );
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        PressedBorderColor: =RGBA(0, 0, 0, 0)
                        PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedFill: =RGBA(0, 0, 0, 0)
                        Rotation: =If(visibility.BodyF, 180, 0)
                        Width: =30
                        X: =400
                        Y: =20
            - Topic_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxMultiSelectEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Topic"
                  Default: =ThisItem.Topic
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Topic)
                  Height: =100
                  Required: =true
                  Update: =DataCardValue2.SelectedItems
                  Width: =Parent.Width
                  X: =0
                  Y: =4
                Children:
                  - DataCardKey2:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Sujet","Topic")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =35
                  - DataCardValue2:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].Topic)
                        OnChange: =ClearCollect(Topics, DataCardValue2.SelectedItems, otherTopics);
                        OnSelect: |-
                          =Set(
                              changes,
                              Patch(
                                  changes,
                                  {
                                      topicChange: true
                                  }
                              )
                          );
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey2.Y + DataCardKey2.Height + 5
                  - ErrorMessage2:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue2.Y + DataCardValue2.Height
            - Signal_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Signal"
                  Default: =ThisItem.Signal
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Signal)
                  Required: =true
                  Update: =DataCardValue5.Selected
                  Width: =500
                  X: =1
                  Y: =5
                Children:
                  - DataCardKey5:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language()="fr-FR", "Signal", "Signaal")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue5:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].Signal)
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectMultiple: =false
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey5.Y + DataCardKey5.Height + 5
                  - ErrorMessage5:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue5.Y + DataCardValue5.Height
            - Status_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Status_x0020__x0028_1_x0029_"
                  Default: =ThisItem.'Status (1)'
                  DisplayName: =If(Language()="fr-FR", "Statut", "Status")
                  Height: =100
                  Required: =true
                  Update: =DataCardValue3.Selected
                  Width: =500
                  X: =0
                  Y: =6
                Children:
                  - DataCardKey3:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =Parent.DisplayName
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue3:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Filter(Choices([@SignaalFt_test].'Status (1)'),And(Not(Value = "For DirCom"),Not(Value = "Confirmed by DirCom"),Not(Value = "Noticed by DirCom")))
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectMultiple: =false
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey3.Y + DataCardKey3.Height + 5
                  - ErrorMessage3:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue3.Y + DataCardValue3.Height
            - Status (2)_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxMultiSelectEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Status_x0020__x0028_2_x0029_"
                  Default: =ThisItem.'Status (2)'
                  DisplayName: =If(Language()="fr-FR", "Statut (Deuxième ligne)", "Status (Tweede lijn)")
                  Required: =false
                  Update: =DataCardValue13.SelectedItems
                  Visible: =Or(profiles.isRecipient,profiles.isAdmin)
                  Width: =500
                  X: =1
                  Y: =6
                Children:
                  - DataCardKey13:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =Parent.DisplayName
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue13:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Filter(Choices([@SignaalFt_test].'Status (2)'),And(Not(Value = "For DirCom"),Not(Value = "Confirmed by DirCom"),Not(Value = "Noticed by DirCom")))
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey13.Y + DataCardKey13.Height + 5
                  - ErrorMessage13:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue13.Y + DataCardValue13.Height
                  - StarVisible1:
                      Control: Label@2.5.1
                      MetadataKey: FieldRequired
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =DataCardKey13.Height
                        PaddingLeft: =0
                        Size: =10.5
                        Text: ="*"
                        Visible: =And(Parent.Required, Parent.DisplayMode=DisplayMode.Edit)
                        Width: =30
                        Wrap: =false
                        X: =2
                        Y: =DataCardKey13.Y
                  - Status2_InfoIcon:
                      Control: Classic/Icon@2.5.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderThickness: =1
                        Color: =RGBA(255, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(220, 220, 220, 1)
                        DisabledFill: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Height: =33
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverFill: =RGBA(0, 0, 0, 0)
                        Icon: =Icon.Information
                        OnSelect: |-
                          =Set(
                              timers,
                              Patch(
                                  timers,
                                  {
                                      infoStatus2Timer: true
                                  }
                              )
                          );
                        PaddingTop: =5
                        PressedBorderColor: =RGBA(0, 0, 0, 0)
                        PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedFill: =RGBA(0, 0, 0, 0)
                        Width: =44
                        X: =If(Language()="fr-FR",270,250)
                        Y: =15
            - Reference_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Reference"
                  Default: =ThisItem.Reference
                  DisplayName: =If(Language()="fr-FR", "Point de contact pour ce signal", "Contactpunt voor dit signaal")
                  Required: =false
                  Update: =DataCardValue15.Selected
                  Width: =500
                  X: =0
                  Y: =7
                Children:
                  - DataCardKey15:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =Parent.DisplayName
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue15:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["DisplayName","Email","Picture"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].Reference)
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["DisplayName"]
                        SelectMultiple: =false
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey15.Y + DataCardKey15.Height + 5
                  - ErrorMessage15:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue15.Y + DataCardValue15.Height
                  - StarVisible2:
                      Control: Label@2.5.1
                      MetadataKey: FieldRequired
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =DataCardKey15.Height
                        PaddingLeft: =0
                        Size: =10.5
                        Text: ="*"
                        Visible: =And(Parent.Required, Parent.DisplayMode=DisplayMode.Edit)
                        Width: =30
                        Wrap: =false
                        X: =2
                        Y: =DataCardKey15.Y
            - FlowRunning_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicToggleEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="FlowRunning"
                  Default: =ThisItem.FlowRunning
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,'FlowRunning')
                  Height: =0
                  Required: =false
                  Update: =system.isFlowRunning
                  Visible: =false
                  Width: =0
                  X: =1
                  Y: =7
            - Editors_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxMultiSelectEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Editors"
                  Default: =ThisItem.Editors
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Editors)
                  Height: =100
                  Required: =false
                  Update: =DataCardValue6.SelectedItems
                  Width: =500
                  X: =1
                  Y: =7
                Children:
                  - DataCardKey6:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Rédacteurs","Medewerkers")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue6:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["DisplayName","Email","Picture"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].Editors)
                        MultiValueDelimiter: |-
                          =", 
                          "
                        OnSelect: |-
                          =Set(
                              changes,
                              Patch(
                                  changes,
                                  {
                                      editorsChange: true
                                  }
                              )
                          );
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["DisplayName"]
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey6.Y + DataCardKey6.Height + 5
                  - ErrorMessage6:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue6.Y + DataCardValue6.Height
            - Confidentiality _DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Confidentiality"
                  Default: =ThisItem.'Confidentiality '
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,'Confidentiality ')
                  Height: =100
                  Required: =true
                  Update: =DataCardValue9.Selected
                  Width: =500
                  X: =0
                  Y: =8
                Children:
                  - DataCardKey9:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Confidentialité","Vertrouwelijkheid")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue9:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].'Confidentiality ')
                        OnChange: =
                        OnSelect: |-
                          =Set(
                              changes,
                              Patch(
                                  changes,
                                  {
                                      confiChange: true
                                  }
                              )
                          );
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectMultiple: =false
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey9.Y + DataCardKey9.Height + 5
                  - ErrorMessage9:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue9.Y + DataCardValue9.Height
            - SignalLocation_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="SignalLocation"
                  Default: =ThisItem.SignalLocation
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,SignalLocation)
                  Height: =100
                  Required: =false
                  Update: =DataCardValue10.Selected
                  Width: =500
                  X: =1
                  Y: =8
                Children:
                  - DataCardKey10:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Origine du signal","Oorsprong van het signaal")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue10:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].SignalLocation)
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectMultiple: =false
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey10.Y + DataCardKey10.Height + 5
                  - ErrorMessage10:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue10.Y + DataCardValue10.Height
            - Domain_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicComboBoxEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Domain"
                  Default: =ThisItem.Domain
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Domain)
                  Height: =100
                  Required: =false
                  Update: =DataCardValue8.Selected
                  Width: =500
                  X: =0
                  Y: =9
                Children:
                  - DataCardKey8:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Domaine","Domein")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue8:
                      Control: Classic/ComboBox@2.4.0
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        ChevronBackground: =RGBA(255, 255, 255, 1)
                        ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                        ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                        ChevronFill: =RGBA(33, 33, 33, 1)
                        ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                        ChevronHoverFill: =RGBA(33, 33, 33, 1)
                        Color: =RGBA(51, 51, 51, 1)
                        DefaultSelectedItems: =Parent.Default
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayFields: =["Value"]
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        Items: =Choices([@SignaalFt_test].Domain)
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        SearchFields: =["Value"]
                        SelectMultiple: =false
                        SelectionColor: =RGBA(255, 255, 255, 1)
                        SelectionFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey8.Y + DataCardKey8.Height + 5
                  - ErrorMessage8:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue8.Y + DataCardValue8.Height
            - Source_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicTextualEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="Source"
                  Default: =ThisItem.Source
                  DisplayName: =DataSourceInfo([@SignaalFt_test],DataSourceInfo.DisplayName,Source)
                  Height: =100
                  MaxLength: =DataSourceInfo([@SignaalFt_test], DataSourceInfo.MaxLength, Source)
                  Required: =false
                  Update: =DataCardValue4.Text
                  Width: =500
                  X: =1
                  Y: =9
                Children:
                  - DataCardKey4:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =If(Language() = "fr-FR","Source","Bron")
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                        Y: =10
                  - DataCardValue4:
                      Control: Classic/TextInput@2.3.2
                      MetadataKey: FieldValue
                      Properties:
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        Default: =Parent.Default
                        DelayOutput: =true
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        MaxLength: =Parent.MaxLength
                        PaddingLeft: =5
                        PressedBorderColor: =RGBA(0, 120, 212, 1)
                        PressedColor: =RGBA(51, 51, 51, 1)
                        PressedFill: =RGBA(255, 255, 255, 1)
                        RadiusBottomLeft: =0
                        RadiusBottomRight: =0
                        RadiusTopLeft: =0
                        RadiusTopRight: =0
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =300
                        X: =32
                        Y: =DataCardKey4.Y + DataCardKey4.Height + 5
                  - ErrorMessage4:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue4.Y + DataCardValue4.Height
            - Bijlagen_DataCard1:
                Control: TypedDataCard@1.0.7
                Variant: ClassicAttachmentsEdit
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  DataField: ="{Attachments}"
                  Default: =ThisItem.Bijlagen
                  DisplayName: =If(Language()="fr-FR", "Pièces jointes", "Bijlagen")
                  Height: =250
                  Required: =false
                  Update: =DataCardValue7.Attachments
                  Width: =Parent.Width
                  X: =0
                  Y: =10
                Children:
                  - DataCardKey7:
                      Control: Label@2.5.1
                      MetadataKey: FieldName
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =34
                        PaddingLeft: =0
                        Size: =16
                        Text: =Parent.DisplayName
                        Width: =Parent.Width - 60
                        Wrap: =false
                        X: =32
                  - DataCardValue7:
                      Control: Attachments@2.3.0
                      MetadataKey: FieldValue
                      Properties:
                        AddAttachmentText: =If(Language()="fr-FR", "Joindre un fichier (si un lien a été ajouté dans la description, il n'est pas nécessaire de télécharger une pièce jointe)", "Voeg bijlage toe (indien er een link naar deze bijlage in de beschrijving staat is het niet nodig deze hier te uploaden)")
                        BorderColor: =If(IsBlank(Parent.Error), Parent.BorderColor, Color.Red)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisplayMode: =Parent.DisplayMode
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Self.Y
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(212, 212, 212, 1)
                        ItemColor: =RGBA(0, 0, 0, 1)
                        ItemFill: =RGBA(0, 120, 212, 1)
                        ItemHoverColor: =RGBA(51, 51, 51, 1)
                        ItemHoverFill: =RGBA(212, 212, 212, 1)
                        ItemSpacing: =12
                        Items: =Parent.Default
                        NoAttachmentsColor: =RGBA(166, 166, 166, 1)
                        PaddingBottom: =5
                        PaddingLeft: =If(Self.DisplayMode = DisplayMode.Edit, 5, 0)
                        PaddingRight: =5
                        PaddingTop: =5
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =RGBA(0, 120, 212, 1)
                        Size: =14
                        Tooltip: =Parent.DisplayName
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardKey7.Y + DataCardKey7.Height + 5
                  - ErrorMessage7:
                      Control: Label@2.5.1
                      MetadataKey: ErrorMessage
                      Properties:
                        AutoHeight: =true
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(168, 0, 0, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(168, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Semibold
                        Height: =10
                        Live: =Live.Assertive
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        Size: =10.5
                        Text: =Parent.Error
                        Visible: =Parent.DisplayMode=DisplayMode.Edit
                        Width: =Parent.Width - 60
                        X: =32
                        Y: =DataCardValue7.Y + DataCardValue7.Height
      - RequestValidation:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            DropShadow: =DropShadow.None
            Height: =700
            PaddingTop: =200
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Visible: =If(profiles.isAdmin,!system.toggleAdmin,!profiles.isValidator)
            Width: =Parent.Width - Self.X - 200
            X: =75
            Y: =1450
          Children:
            - RequestValidation_Label:
                Control: Label@2.5.1
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =1
                  Color: =RGBA(51, 51, 153, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  FontWeight: =FontWeight.Bold
                  PaddingLeft: =0
                  Size: =16
                  Text: |-
                    =If(Language() = "fr-FR",
                        "Demande de validation",
                        "Aanvraag tot validatie"
                    )
                  X: =10
                  Y: =200
            - RequestValidation_Toggle:
                Control: Classic/Toggle@2.1.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  Color: =RGBA(51, 51, 51, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FalseFill: =RGBA(102, 102, 102, 1)
                  FalseHoverFill: =RGBA(33, 33, 33, 1)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  HoverBorderColor: =RGBA(0, 0, 0, 0)
                  OnCheck: |+
                    =Set(
                        timers,
                        Patch(
                            timers,
                            {
                                valNotifMsgTimer: true
                            }
                        )
                    );
                    Set(resetDropDown,true);
                    If(
                        IsEmpty(Validators),
                            Notify(messages.noValidatorsMsg,NotificationType.Warning,5000);
                            If(
                                (Value(SharePointForm.Mode) = FormMode.New),
                                    ClearCollect(
                                        Validators,
                                            'Office365Groups'.ListGroupMembers(
                                                            Coalesce(
                                                                LookUp(
                                                                    'Office365Groups'.ListOwnedGroups().value,
                                                                    displayName = "SignalTest_ValidOne"
                                                                ).id,
                                                                "500d59e4619-45a8-4375-a20e-15eeec07004b"
                                                            )
                                                        ).value,
                                            'Office365Groups'.ListGroupMembers(
                                                            Coalesce(
                                                                LookUp(
                                                                    'Office365Groups'.ListOwnedGroups().value,
                                                                    displayName = "SignalTest_ValidTwo"
                                                                ).id,
                                                                "5001dd78fb6-16d8-4047-aac4-10a37486da3c"
                                                            )
                                                        ).value
                                    );
                                    Set(
                                        profiles,
                                        Patch(
                                            profiles,
                                            {
                                                isValidator: !IsBlank(LookUp(Validators, Email = User().Email))
                                            }
                                        )
                                    );
                                    Set(
                                        system,
                                        Patch(
                                            system,
                                            {
                                                isRendered: true
                                            }
                                        )
                                    );
                                Notify(messages.noValidatorsMsg &  " And was not new!",NotificationType.Warning,5000);
                                If(
                                    And(profiles.isTeamMember,!profiles.isRecipient),
                                        ClearCollect(
                                            Validators,
                                                Filter(
                                                    SharePointIntegration.Selected.Team,
                                                    Lower(Email) in
                                                        ForAll('Office365Groups'.ListGroupMembers(
                                                            Coalesce(
                                                                LookUp(
                                                                    'Office365Groups'.ListOwnedGroups().value,
                                                                    displayName = "SignalTest_ValidOne"
                                                                ).id,
                                                                "500d59e4619-45a8-4375-a20e-15eeec07004b"
                                                            )
                                                        ).value, 
                                                    Lower(mail)
                                                )
                                            )
                                        )
                                );
                                If(
                                    profiles.isRecipient,
                                        ClearCollect(
                                            Validators,
                                                Filter(
                                                    SharePointIntegration.Selected.Team,
                                                    Lower(Email) in
                                                        ForAll('Office365Groups'.ListGroupMembers(
                                                            Coalesce(
                                                                LookUp(
                                                                    'Office365Groups'.ListOwnedGroups().value,
                                                                    displayName = "SignalTest_ValidTwo"
                                                                ).id,
                                                                "5001dd78fb6-16d8-4047-aac4-10a37486da3c"
                                                            )
                                                        ).value, 
                                                    Lower(mail)
                                                )
                                            )
                                        )
                                )
                            )
                    );
                    Set(
                        validationRequest,
                        Patch(
                            validationRequest,
                            {
                                isValidationRequest: true
                            }
                        )
                    )
                  OnSelect: |-
                    =Set(
                        visibility,
                        Patch(
                            visibility,
                            {
                                BodyN: false,
                                BodyF: false
                            }
                        )
                    );
                  OnUncheck: |+
                    =Set(
                        validationRequest,
                        Patch(
                            validationRequest,
                            {
                                isValidationRequest: false,
                                isValidationRequested: false
                            }
                        )
                    );
                    Set(
                        visibility,
                        Patch(
                            visibility,
                            {
                                valNotifMsgVis:false
                            }
                        )
                    );
                    Set(
                        timers,
                        Patch(
                            timers,
                            {
                                valNotifMsgTimer: false
                            }
                        )
                    );
                    If(profiles.isAdmin,Notify("--- Test --- validationRequested toggle status: " & validationRequest.isValidationRequested,NotificationType.Information, 5000))
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  Reset: =
                  Size: =10.5
                  TrueFill: =RGBA(0, 120, 212, 1)
                  TrueHoverFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  X: =300
                  Y: =210
            - RequestValidation_UserInput:
                Control: GroupContainer@1.5.0
                Variant: AutoLayout
                Properties:
                  DropShadow: =DropShadow.None
                  Height: =Parent.Height - Self.Y - 40
                  LayoutAlignItems: =LayoutAlignItems.Center
                  LayoutDirection: =LayoutDirection.Horizontal
                  LayoutGap: =10
                  LayoutOverflowY: =LayoutOverflow.Scroll
                  PaddingBottom: =8
                  PaddingLeft: =8
                  PaddingRight: =8
                  PaddingTop: =8
                  RadiusBottomLeft: =0
                  RadiusBottomRight: =0
                  RadiusTopLeft: =0
                  RadiusTopRight: =0
                  Visible: =validationRequest.isValidationRequest
                  Width: =Parent.Width - Self.X * 2
                  X: =40
                  Y: =240
                Children:
                  - RequestValidation_VLists:
                      Control: GroupContainer@1.5.0
                      Variant: AutoLayout
                      Properties:
                        AlignInContainer: =AlignInContainer.Start
                        DropShadow: =DropShadow.Regular
                        Height: =Parent.Height - Self.Y*2
                        LayoutDirection: =LayoutDirection.Vertical
                        LayoutMinHeight: =16
                        LayoutMinWidth: =16
                        LayoutOverflowY: =LayoutOverflow.Scroll
                        PaddingBottom: =8
                        PaddingLeft: =8
                        PaddingRight: =8
                        PaddingTop: =8
                        RadiusBottomLeft: =10
                        RadiusBottomRight: =10
                        RadiusTopLeft: =10
                        RadiusTopRight: =10
                        Width: =Parent.Width / 2 - Self.X * 2 - Parent.LayoutGap / 2
                        Y: =10
                      Children:
                        - RequestValidation_Vlist_DropDown:
                            Control: GroupContainer@1.5.0
                            Variant: ManualLayout
                            Properties:
                              AlignInContainer: =AlignInContainer.SetByContainer
                              DropShadow: =DropShadow.None
                              Height: =Parent.Height / 3 - Self.Y * 2
                              LayoutMinHeight: =16
                              LayoutMinWidth: =16
                              RadiusBottomLeft: =0
                              RadiusBottomRight: =0
                              RadiusTopLeft: =0
                              RadiusTopRight: =0
                              Visible: =(Value(SharePointForm.Mode) = FormMode.New)
                              Width: =Parent.Width - Self.X *2
                              Y: =1
                            Children:
                              - RequestValidation_Vlist_DropDown_Label:
                                  Control: Label@2.5.1
                                  Properties:
                                    BorderColor: =RGBA(0, 0, 0, 0)
                                    BorderStyle: =BorderStyle.None
                                    BorderThickness: =1
                                    Color: =RGBA(51, 51, 153, 1)
                                    DisabledBorderColor: =RGBA(0, 0, 0, 0)
                                    FocusedBorderThickness: =1
                                    Font: =Font.'Segoe UI'
                                    FontWeight: =FontWeight.Bold
                                    PaddingLeft: =0
                                    Size: =16
                                    Text: =messages.pickValMsg
                                    Width: =Parent.Width - Self.X * 2
                                    X: =20
                                    Y: =20
                              - RequestValidation_Vlist_DropDown_Picker:
                                  Control: Classic/ComboBox@2.4.0
                                  Properties:
                                    BorderColor: =RGBA(166, 166, 166, 1)
                                    BorderThickness: =1
                                    ChevronBackground: =RGBA(255, 255, 255, 1)
                                    ChevronDisabledBackground: =RGBA(244, 244, 244, 1)
                                    ChevronDisabledFill: =RGBA(166, 166, 166, 1)
                                    ChevronFill: =RGBA(33, 33, 33, 1)
                                    ChevronHoverBackground: =RGBA(212, 212, 212, 1)
                                    ChevronHoverFill: =RGBA(33, 33, 33, 1)
                                    Color: =RGBA(51, 51, 51, 1)
                                    DisabledBorderColor: =RGBA(0, 0, 0, 0)
                                    DisplayFields: =["displayName"]
                                    FocusedBorderThickness: =1
                                    Font: =Font.'Segoe UI'
                                    HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    HoverColor: =RGBA(51, 51, 51, 1)
                                    HoverFill: =RGBA(212, 212, 212, 1)
                                    Items: =Validators
                                    OnChange: |-
                                      =If(profiles.isAdmin,
                                          Notify(
                                              "Email: " & Self.Selected.Email & 
                                              " & mail: " & Self.Selected.mail & 
                                              " & DisplayName: " & Self.Selected.DisplayName &
                                              " & displayName: " & Self.Selected.displayName &
                                              " & Department: " & Self.Selected.Department &
                                              " & Claims: " & Self.Selected.Claims &
                                              " & userPrincipalName: " & Self.Selected.userPrincipalName &
                                              " & Id: " & Self.Selected.id, 
                                                  NotificationType.Information,
                                              20000
                                          )
                                      );
                                      If(
                                          IsBlank( LookUp(NewValidators, userPrincipalName = Self.Selected.userPrincipalName) ),
                                              Collect(NewValidators, Self.Selected),
                                          RemoveIf(NewValidators,userPrincipalName = Self.Selected.userPrincipalName)
                                      );
                                      Set(resetDropDown,false)
                                    OnSelect: =
                                    PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    PressedColor: =RGBA(255, 255, 255, 1)
                                    PressedFill: =RGBA(0, 120, 212, 1)
                                    Reset: =resetDropDown
                                    SearchFields: =["displayName"]
                                    SelectionColor: =RGBA(255, 255, 255, 1)
                                    SelectionFill: =RGBA(0, 120, 212, 1)
                                    Size: =14
                                    Width: =Parent.Width - Self.X * 2
                                    X: =20
                                    Y: =75
                        - RequestValidation_Vlist_Selected:
                            Control: GroupContainer@1.5.0
                            Variant: ManualLayout
                            Properties:
                              AlignInContainer: =AlignInContainer.SetByContainer
                              DropShadow: =DropShadow.None
                              Height: =Parent.Height * 0.75 - Self.Y *2
                              RadiusBottomLeft: =0
                              RadiusBottomRight: =0
                              RadiusTopLeft: =0
                              RadiusTopRight: =0
                              Width: =Parent.Width - Self.X*2
                              X: =25
                              Y: =20
                            Children:
                              - RequestValidation_Vlist_Selected_Label:
                                  Control: Label@2.5.1
                                  Properties:
                                    BorderColor: =RGBA(0, 0, 0, 0)
                                    BorderStyle: =BorderStyle.None
                                    BorderThickness: =1
                                    Color: =RGBA(51, 51, 153, 1)
                                    DisabledBorderColor: =RGBA(0, 0, 0, 0)
                                    FocusedBorderThickness: =1
                                    Font: =Font.'Segoe UI'
                                    FontWeight: =FontWeight.Bold
                                    PaddingLeft: =0
                                    Size: =16
                                    Text: |-
                                      =If(
                                          (Value(SharePointForm.Mode) = FormMode.New), 
                                              If(CountRows(NewValidators)>0,messages.yourValidatorsMsg,messages.noValidatorsSelectedMsg),
                                          If(CountRows(Validators)>0,messages.yourValidatorsMsg,messages.dataReloadMsg)
                                      )
                                    Width: =Parent.Width - Self.X
                                    X: =20
                              - RequestValidation_Vlist_Selected_Gallery:
                                  Control: Gallery@2.15.0
                                  Variant: BrowseLayout_Vertical_OneTextVariant_ver5.0
                                  Properties:
                                    BorderColor: =RGBA(166, 166, 166, 1)
                                    Height: =Parent.Height - Self.Y
                                    Items: =If((Value(SharePointForm.Mode) = FormMode.New),NewValidators,Validators)
                                    Selectable: =false
                                    TemplateFill: =RGBA(237, 237, 237, 1)
                                    TemplatePadding: =10
                                    TemplateSize: =40
                                    Visible: =visibility.VListVis
                                    Width: =Parent.Width - Self.X*2 - 30
                                    X: =20
                                    Y: =50
                                  Children:
                                    - RequestValidation_Vlist_Selected_VName:
                                        Control: Label@2.5.1
                                        Properties:
                                          BorderColor: =RGBA(0, 0, 0, 1)
                                          BorderThickness: =1
                                          Color: =RGBA(71, 69, 64, 1)
                                          DisabledColor: =RGBA(186, 186, 186, 1)
                                          DisplayMode: =DisplayMode.View
                                          FocusedBorderThickness: =1
                                          Font: =Font.'Open Sans'
                                          Height: =Parent.TemplateHeight - Self.Y*2
                                          OnSelect: =Select(Parent)
                                          PaddingBottom: =0
                                          PaddingLeft: =0
                                          PaddingRight: =0
                                          PaddingTop: =0
                                          Size: =14
                                          Text: |-
                                            =If(
                                                (Value(SharePointForm.Mode) = FormMode.New),
                                                    ThisItem.displayName,
                                                ThisItem.DisplayName
                                            )
                                          VerticalAlign: =VerticalAlign.Top
                                          Width: =Parent.TemplateWidth - 86
                                          Wrap: =false
                                          X: =16
                                    - RequestValidation_Vlist_Selected_Remove:
                                        Control: Classic/Icon@2.5.0
                                        Properties:
                                          AccessibleLabel: =Self.Tooltip
                                          BorderColor: =RGBA(0, 0, 0, 0)
                                          BorderThickness: =1
                                          Color: =RGBA(166, 166, 166, 1)
                                          DisabledBorderColor: =RGBA(0, 0, 0, 0)
                                          DisabledColor: =RGBA(220, 220, 220, 1)
                                          DisabledFill: =RGBA(0, 0, 0, 0)
                                          FocusedBorderThickness: =1
                                          Height: =30
                                          HoverBorderColor: =RGBA(0, 0, 0, 0)
                                          HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                          HoverFill: =RGBA(0, 0, 0, 0)
                                          Icon: =Icon.Cancel
                                          OnSelect: |-
                                            =Notify(
                                                "Email: " & ThisItem.Email & 
                                                " & mail: " & ThisItem.mail & 
                                                " & DisplayName: " & ThisItem.DisplayName &
                                                " & displayName: " & ThisItem.displayName &
                                                " & Department: " & ThisItem.Department &
                                                " & Claims: " & ThisItem.Claims &
                                                " & userPrincipalName: " & ThisItem.userPrincipalName &
                                                " & Id: " & ThisItem.id, 
                                                    NotificationType.Information,
                                                20000
                                            );
                                            If(
                                                (Value(SharePointForm.Mode) = FormMode.New),
                                                    If(
                                                        CountRows(NewValidators)=1,
                                                            Set(
                                                                visibility,
                                                                Patch(
                                                                    visibility,
                                                                    {
                                                                        VListVis:false
                                                                    }
                                                                )
                                                            )
                                                    );
                                                    RemoveIf(NewValidators, userPrincipalName = ThisItem.userPrincipalName);
                                                    Set(resetDropDown,true),
                                                If(
                                                    CountRows(Validators)=1,
                                                        Set(
                                                            visibility,
                                                            Patch(
                                                                visibility,
                                                                {
                                                                    VListVis: false
                                                                }
                                                            )
                                                        )
                                                );
                                                RemoveIf(Validators, Claims = ThisItem.Claims);
                                                If(profiles.isAdmin,Notify("After filter" & Concat(Filter(Validators, Claims <> ThisItem.Claims),Email,"; "),NotificationType.Information,10000))
                                            );
                                          PressedBorderColor: =RGBA(0, 0, 0, 0)
                                          PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                          PressedFill: =RGBA(0, 0, 0, 0)
                                          Width: =20
                                          X: =Parent.TemplateWidth - Self.Width - 20
                                    - RequestValidation_Vlist_Selected_Separator:
                                        Control: Rectangle@2.3.0
                                        Properties:
                                          BorderColor: =RGBA(0, 0, 255, 1)
                                          Fill: =RGBA(255, 255, 255, 1)
                                          FocusedBorderThickness: =1
                                          Height: =8
                                          OnSelect: =Select(Parent)
                                          Width: =Parent.TemplateWidth
                                          Y: =Parent.TemplateHeight - Self.Height
                              - RequestValidation_Vlist_Selected_Toggle:
                                  Control: Classic/Icon@2.5.0
                                  Properties:
                                    BorderColor: =RGBA(51, 51, 153, 1)
                                    BorderThickness: =1
                                    Color: =RGBA(51, 51, 153, 1)
                                    DisabledBorderColor: =RGBA(0, 0, 0, 0)
                                    DisabledColor: =RGBA(220, 220, 220, 1)
                                    DisabledFill: =RGBA(0, 0, 0, 0)
                                    FocusedBorderThickness: =1
                                    Height: =30
                                    HoverBorderColor: =RGBA(0, 0, 0, 0)
                                    HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    HoverFill: =RGBA(0, 0, 0, 0)
                                    Icon: =If(visibility.VListVis,Icon.ChevronUp,If(CountRows(Validators)>0,Icon.ChevronDown,If((Value(SharePointForm.Mode) <> FormMode.New),Icon.Sync,Icon.ListScrollEmpty)))
                                    OnSelect: "=If(!visibility.VListVis,\n    If(\n        (Value(SharePointForm.Mode) = FormMode.New),\n            If(\n                CountRows(NewValidators)>0,\n                    Notify(\"oke (New Validators): \" & Concat(NewValidators,Lower(mail),\"; \"),NotificationType.Success,10000)\n            ),\n        If(\n            CountRows(Validators)>0,\n                If(\n                    profiles.isAdmin,\n                        Notify(\"oke\",NotificationType.Success,3000)\n                ),\n            If(\n                And(CountRows(Filter(SharePointIntegration.Selected.Team,Lower(Email) = Lower(User().Email)))>0, CountRows(Filter(SharePointIntegration.Selected.Recipients,Lower(Email) = Lower(User().Email)))=0),\n                    With(\n                        {\n                            teamMemberMails:\n                                AddColumns(\n                                    'Office365Groups'.ListGroupMembers(\n                                        Coalesce(\n                                            LookUp(\n                                                'Office365Groups'.ListOwnedGroups().value,\n                                                displayName = \"SignalTest_ValidOne\"\n                                            ).id,\n                                            \"d59e4619-45a8-4375-a20e-15eeec07004b\"\n                                        )\n                                    ).value,\n                                    mailLower,\n                                    Lower(mail)\n                                )\n                        },\n                        ClearCollect(\n                            Validators,\n                            Filter(\n                                SharePointIntegration.Selected.Team,\n                                Lower(Email) in teamMemberMails.mailLower\n                            )\n                        )\n                    );\n                    Notify(Concat(Validators,Lower(Email),\"; \"),NotificationType.Information,5000)\n            );\n            \n            If(\n                CountRows(Filter(SharePointIntegration.Selected.Recipients,Lower(Email) = Lower(User().Email)))>0,\n                    With(\n                        {\n                            recipientMails:\n                                AddColumns(\n                                    'Office365Groups'.ListGroupMembers(\n                                        Coalesce(\n                                            LookUp(\n                                                'Office365Groups'.ListOwnedGroups().value,\n                                                displayName = \"SignalTest_ValidTwo\"\n                                            ).id,\n                                            \"1dd78fb6-16d8-4047-aac4-10a37486da3c\"\n                                        )\n                                    ).value,\n                                    mailLower,\n                                    Lower(mail)\n                                )\n                        },\n                        ClearCollect(\n                            Validators,\n                            Filter(\n                                SharePointIntegration.Selected.Recipients,\n                                Lower(Email) in recipientMails.mailLower\n                            )\n                        )\n                    );\n                    Notify(Concat(Validators,Lower(Email),\"; \"),NotificationType.Information,5000)\n\n            );\n            Notify(\"not oke\",NotificationType.Error,3000)\n        )\n    )\n);\nSet(\n    visibility,\n    Patch(\n        visibility,\n        {\n            VListVis: !visibility.VListVis\n        }\n    )\n);"
                                    PaddingBottom: =5
                                    PaddingLeft: =5
                                    PaddingRight: =5
                                    PaddingTop: =5
                                    PressedBorderColor: =RGBA(0, 0, 0, 0)
                                    PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    PressedFill: =RGBA(0, 0, 0, 0)
                                    Rotation: =
                                    Visible: =If(And(CountRows(NewValidators)=0,(Value(SharePointForm.Mode) = FormMode.New)),false,true)
                                    Width: =30
                                    X: =Parent.Width - Self.Width - 100
                                    Y: =10
                  - ValidationRequest_UserComment_1:
                      Control: GroupContainer@1.5.0
                      Variant: ManualLayout
                      Properties:
                        DropShadow: =DropShadow.Regular
                        Height: =Parent.Height - Self.Y * 2
                        RadiusBottomLeft: =10
                        RadiusBottomRight: =10
                        RadiusTopLeft: =10
                        RadiusTopRight: =10
                        Width: =Parent.Width / 2 - Self.X * 2 - Parent.LayoutGap / 2
                        X: =25
                        Y: =15
                      Children:
                        - ValidationRequest_UserComment_Input_1:
                            Control: Classic/TextInput@2.3.2
                            Properties:
                              BorderColor: =RGBA(166, 166, 166, 1)
                              BorderThickness: =1
                              Color: =RGBA(51, 51, 51, 1)
                              Default: =
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              Height: =330
                              HintText: ="Geef een boodschap mee aan de validator(en)"
                              HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              HoverColor: =RGBA(51, 51, 51, 1)
                              HoverFill: =RGBA(255, 255, 255, 1)
                              Mode: =TextMode.MultiLine
                              OnChange: |-
                                =Set(
                                    validationRequest,
                                    Patch(
                                        validationRequest,
                                        {
                                            validationRequestComment: ValidationRequest_UserComment_Input_1.Text
                                        }
                                    )
                                );
                              PaddingBottom: =15
                              PaddingLeft: =15
                              PaddingRight: =15
                              PaddingTop: =15
                              PressedBorderColor: =RGBA(0, 120, 212, 1)
                              PressedColor: =RGBA(51, 51, 51, 1)
                              PressedFill: =RGBA(255, 255, 255, 1)
                              RadiusBottomLeft: =0
                              RadiusBottomRight: =0
                              RadiusTopLeft: =0
                              RadiusTopRight: =0
                              Size: =14
                              Width: =Parent.Width - 25
                              X: =Parent.Width/2 - Self.Width/2
                              Y: =Parent.Height - Self.Height - 20
                        - ValidationRequest_UserComment_Label_1:
                            Control: Label@2.5.1
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(51, 51, 153, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              FontWeight: =FontWeight.Bold
                              PaddingLeft: =0
                              Size: =16
                              Text: |-
                                =If(Language()  = "fr-FR",
                                    "Message à l'intention du validateur", 
                                    "Boodschap voor de validator"
                                )
                              Width: =Parent.Width - Self.X
                              X: =20
            - ValNotifMsg:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  BorderColor: =RGBA(168, 0, 0, 1)
                  BorderStyle: =BorderStyle.Dashed
                  BorderThickness: =2
                  DropShadow: =DropShadow.Regular
                  Fill: =RGBA(255, 255, 255, 1)
                  Height: =150
                  RadiusBottomLeft: =0
                  RadiusBottomRight: =0
                  RadiusTopLeft: =0
                  RadiusTopRight: =0
                  Visible: =validationRequest.isValidationRequest
                  X: =Parent.Width - Self.Width - 200
                  Y: =40
                Children:
                  - ValNotifMsg_Text:
                      Control: Label@2.5.1
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Self.Y * 2
                        PaddingLeft: =0
                        Size: =14
                        Text: =messages.validationNotificationMsg
                        Visible: =validationRequest.isValidationRequest
                        Width: =Parent.Width - Self.X * 2
                        X: =20
                        Y: =20
                  - ValNotifMsg_Timer:
                      Control: Timer@2.1.0
                      Properties:
                        BorderColor: =RGBA(0, 120, 212, 1)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =0
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledColor: =RGBA(51, 51, 153, 1)
                        Duration: =5000
                        Fill: =RGBA(255, 255, 255, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =30
                        HoverBorderColor: =RGBA(255, 255, 255, 1)
                        HoverColor: =RGBA(51, 51, 153, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        OnTimerEnd: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      valNotifMsgVis:false
                                  }
                              )
                          );
                          Set(
                              timers,
                              Patch(
                                  timers,
                                  {
                                      valNotifMsgTimer: false
                                  }
                              )
                          );
                        OnTimerStart: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      valNotifMsgVis:true
                                  }
                              )
                          );
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        PressedBorderColor: =RGBA(255, 255, 255, 1)
                        PressedColor: =RGBA(51, 51, 153, 1)
                        PressedFill: =RGBA(255, 255, 255, 1)
                        Size: =16
                        Start: =timers.valNotifMsgTimer
                        TabIndex: =5
                        Text: =RoundUp((Self.Duration - Self.Value) / 1000, 0)
                        Visible: =false
                        X: =Parent.Width - Self.Width
                        Y: =Parent.Height - Self.Height - 20
      - NewSignalInstrutions:
          Control: Label@2.5.1
          Properties:
            BorderColor: =RGBA(0, 0, 0, 0)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            Color: =RGBA(51, 51, 51, 1)
            DisabledBorderColor: =RGBA(0, 0, 0, 0)
            FocusedBorderThickness: =1
            Font: =Font.'Segoe UI'
            FontWeight: =FontWeight.Semibold
            Height: =200
            LineHeight: =1.5
            PaddingLeft: =0
            Size: =16
            Text: =messages.newSignalInstructionsMsg
            Visible: =SharePointForm.Mode = FormMode.New
            Width: =1000
            X: =50
      - DirectValidation:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            DropShadow: =DropShadow.None
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Visible: |-
              =If(
                  profiles.isAdmin,
                      system.toggleAdmin,
                  profiles.isValidator
              )
            Width: =Parent.Width - Self.X - 200
            X: =75
            Y: =1650
          Children:
            - DirectValidation_Toggle:
                Control: Classic/Toggle@2.1.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  Color: =RGBA(51, 51, 51, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FalseFill: =RGBA(102, 102, 102, 1)
                  FalseHoverFill: =RGBA(33, 33, 33, 1)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  HoverBorderColor: =RGBA(0, 0, 0, 0)
                  OnCheck: |-
                    =Set(
                        validation,
                        Patch(
                            validation,
                            {
                                isDirectValidation: true
                            }
                        )
                    );
                    Set(
                        timers,
                        Patch(
                            timers,
                            {
                                dirValNotifMsgTimer: true
                            }
                        )
                    );
                  OnUncheck: |-
                    =Set(
                        validation,
                        Patch(
                            validation,
                            {
                                isDirectValidation: false
                            }
                        )
                    );
                    Set(
                        visibility,
                        Patch(
                            visibility,
                            {
                                dirValNotifMsgVis: false
                            }
                        )
                    );
                    Set(
                        timers,
                        Patch(
                            timers,
                            {
                                dirValNotifMsgTimer: false
                            }
                        )
                    );
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  Size: =14
                  TrueFill: =RGBA(0, 120, 212, 1)
                  TrueHoverFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  X: =300
                  Y: =10
            - DirectValidation_Label:
                Control: Label@2.5.1
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =1
                  Color: =RGBA(51, 51, 153, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  FontWeight: =FontWeight.Bold
                  PaddingLeft: =0
                  Size: =16
                  Text: =If(Language()="fr-FR", "Validation directe", "Direct valideren")
                  X: =10
            - DirValNotifMsg:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  BorderColor: =RGBA(168, 0, 0, 1)
                  BorderStyle: =BorderStyle.Dashed
                  BorderThickness: =2
                  DropShadow: =DropShadow.Regular
                  Fill: =RGBA(255, 255, 255, 1)
                  Height: =150
                  RadiusBottomLeft: =0
                  RadiusBottomRight: =0
                  RadiusTopLeft: =0
                  RadiusTopRight: =0
                  Visible: =visibility.dirValNotifMsgVis
                  X: =Parent.Width - Self.Width - 10
                  Y: =10
                Children:
                  - DirValNotifMsg_Text:
                      Control: Label@2.5.1
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Self.Y * 2
                        PaddingLeft: =0
                        Size: =14
                        Text: =messages.validatorNotificationMsg
                        Width: =Parent.Width - Self.X * 2
                        X: =20
                        Y: =20
                  - DirNotifMsg_Timer:
                      Control: Timer@2.1.0
                      Properties:
                        BorderColor: =RGBA(0, 120, 212, 1)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =0
                        Color: =RGBA(51, 51, 153, 1)
                        DisabledColor: =RGBA(51, 51, 153, 1)
                        Duration: =10000
                        Fill: =RGBA(255, 255, 255, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =30
                        HoverBorderColor: =RGBA(255, 255, 255, 1)
                        HoverColor: =RGBA(51, 51, 153, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        OnTimerEnd: |-
                          =Set(
                              timers,
                              Patch(
                                  timers,
                                  {
                                      dirValNotifMsgTimer: false
                                  }
                              )
                          );
                          Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      dirValNotifMsgVis: false
                                  }
                              )
                          );
                        OnTimerStart: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      dirValNotifMsgVis: true
                                  }
                              )
                          );
                        PaddingBottom: =0
                        PaddingLeft: =0
                        PaddingRight: =0
                        PaddingTop: =0
                        PressedBorderColor: =RGBA(255, 255, 255, 1)
                        PressedColor: =RGBA(51, 51, 153, 1)
                        PressedFill: =RGBA(255, 255, 255, 1)
                        Size: =16
                        Start: =timers.dirValNotifMsgTimer
                        TabIndex: =5
                        Text: =RoundUp((Self.Duration - Self.Value) / 1000, 0)
                        X: =Parent.Width - Self.Width
                        Y: =Parent.Height - Self.Height - 20
      - ViewButton_Container:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            BorderColor: =RGBA(51, 51, 153, 1)
            BorderThickness: =2
            DropShadow: =DropShadow.Regular
            Height: =50
            PaddingBottom: =5
            PaddingLeft: =5
            PaddingRight: =5
            PaddingTop: =5
            RadiusBottomLeft: =10
            RadiusBottomRight: =10
            RadiusTopLeft: =10
            RadiusTopRight: =10
            Visible: =Not(SharePointForm.Mode = FormMode.New)
            Width: =50
            X: =FormScreen.Width - 200
            Y: =75
          Children:
            - ViewButton:
                Control: Classic/Icon@2.5.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderThickness: =1
                  Color: =RGBA(51, 51, 153, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  DisabledColor: =RGBA(220, 220, 220, 1)
                  DisabledFill: =RGBA(0, 0, 0, 0)
                  Fill: =RGBA(255, 255, 255, 1)
                  FocusedBorderThickness: =1
                  Height: =Parent.Height
                  HoverBorderColor: =RGBA(0, 0, 0, 0)
                  HoverColor: =RGBA(255, 255, 255, 1)
                  HoverFill: =RGBA(51, 51, 153, 1)
                  Icon: =Icon.View
                  OnSelect: |-
                    =Navigate(OverViewScreen,ScreenTransition.Cover);
                    Set(
                        system,
                        Patch(
                            system,
                            {
                                isNotDirectModification: false,
                                attentionToggle: !system.attentionToggle
                            }
                        )
                    );
                  PaddingBottom: =10
                  PaddingLeft: =10
                  PaddingRight: =10
                  PaddingTop: =10
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  PressedFill: =RGBA(0, 0, 0, 0)
                  Tooltip: =
                  Width: =50
      - AdminSwitch:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            DropShadow: =DropShadow.None
            Height: =100
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Visible: =User().Email = "Nelis.Eerdekens@police.belgium.eu"
            Width: =200
            X: =40
            Y: =40
          Children:
            - AdminSwitch_Toggle:
                Control: Classic/Toggle@2.1.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  Color: =RGBA(51, 51, 51, 1)
                  Default: =system.toggleAdmin
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FalseFill: =RGBA(102, 102, 102, 1)
                  FalseHoverFill: =RGBA(33, 33, 33, 1)
                  FalseText: ="No Admin"
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  HoverBorderColor: =RGBA(0, 0, 0, 0)
                  OnChange: =
                  OnCheck: |-
                    =Set(
                        system,
                        Patch(
                            system,
                            {
                                toggleAdmin: true
                            }
                        )
                    )
                  OnUncheck: |-
                    =Set(
                        system,
                        Patch(
                            system,
                            {
                                toggleAdmin: false
                            }
                        )
                    )
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  Size: =16
                  TrueFill: =RGBA(0, 120, 212, 1)
                  TrueHoverFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  TrueText: ="Admin"
                  X: =Parent.Width - Self.Width - 30
                  Y: =Parent.Height / 2
            - AdminSwitch_Label:
                Control: Label@2.5.1
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =1
                  Color: =RGBA(168, 0, 0, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  FontWeight: =FontWeight.Bold
                  PaddingLeft: =0
                  Size: =16
                  Text: ="Admin"
                  Width: =Parent.Width - Self.X * 2 - 40
                  X: =40
                  Y: =40
      - Status2_InfoMsg:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            BorderColor: =RGBA(168, 0, 0, 1)
            BorderStyle: =BorderStyle.Dashed
            BorderThickness: =2
            DropShadow: =DropShadow.Regular
            Fill: =RGBA(255, 255, 255, 1)
            Height: =230
            PaddingBottom: =5
            PaddingLeft: =5
            PaddingRight: =5
            PaddingTop: =5
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Visible: =visibility.infoStatus2Vis
            Width: =438
            X: =DataCardKey7.X + 800
            Y: =DataCardKey7.Y + 500 + If(visibility.BodyN, 400, 0) + If(visibility.BodyF, 400, 0)
          Children:
            - Status2_InfoMsg_Text:
                Control: Label@2.5.1
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =1
                  Color: =RGBA(51, 51, 51, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  Height: =Parent.Height - Self.Y * 2
                  PaddingLeft: =0
                  Size: =14
                  Text: =messages.status2InfoMsg
                  Width: =Parent.Width - Self.X * 2
                  X: =20
                  Y: =20
            - Status2_InfoMsg_Timer:
                Control: Timer@2.1.0
                Properties:
                  BorderColor: =RGBA(0, 120, 212, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =0
                  Color: =RGBA(51, 51, 153, 1)
                  DisabledColor: =RGBA(51, 51, 153, 1)
                  Duration: =10000
                  Fill: =RGBA(255, 255, 255, 1)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  FontWeight: =FontWeight.Bold
                  Height: =30
                  HoverBorderColor: =RGBA(255, 255, 255, 1)
                  HoverColor: =RGBA(51, 51, 153, 1)
                  HoverFill: =RGBA(255, 255, 255, 1)
                  OnTimerEnd: |-
                    =Set(
                        visibility,
                        Patch(
                            visibility,
                            {
                                infoStatus2Vis:false
                            }
                        )
                    );
                    Set(
                        timers,
                        Patch(
                            timers,
                            {
                                infoStatus2Timer: false
                            }
                        )
                    );
                    Reset(Status2_InfoMsg_Timer)
                  OnTimerStart: |-
                    =Set(
                        visibility,
                        Patch(
                            visibility,
                            {
                                infoStatus2Vis:true
                            }
                        )
                    );
                  PaddingBottom: =0
                  PaddingLeft: =0
                  PaddingRight: =0
                  PaddingTop: =0
                  PressedBorderColor: =RGBA(255, 255, 255, 1)
                  PressedColor: =RGBA(51, 51, 153, 1)
                  PressedFill: =RGBA(255, 255, 255, 1)
                  Size: =16
                  Start: =timers.infoStatus2Timer
                  TabIndex: =5
                  Text: =RoundUp((Self.Duration - Self.Value) / 1000, 0)
                  X: =Parent.Width - Self.Width
                  Y: =Parent.Height - Self.Height - 20
