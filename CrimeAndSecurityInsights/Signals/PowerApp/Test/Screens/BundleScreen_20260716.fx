Screens:
  BundleScreen:
    Properties:
      Fill: =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height, 2200)
      LoadingSpinnerColor: =RGBA(0, 120, 212, 1)
      Width: =Max(App.Width, 1500)
    Children:
      - PrintGallery_Container:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            DropShadow: =DropShadow.None
            Fill: =RGBA(255, 255, 255, 1)
            Height: =Parent.Height - Self.Y
            PaddingBottom: =10
            PaddingLeft: =10
            PaddingRight: =10
            PaddingTop: =130
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Width: =Parent.Width - Self.X
          Children:
            - PrintGallery_List:
                Control: Gallery@2.15.0
                Variant: BrowseLayout_Vertical_OneTextVariant_ver5.0
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  Fill: =RGBA(255, 255, 255, 1)
                  Height: =780
                  Items: |
                    =With(
                        {
                            baseData:
                                If(
                                    IsBlank(PrintGallery_SearchBar.Text),
                                    Sort(
                                        SignaalFt_test,
                                        'Id (ID)',
                                        SortOrder.Ascending
                                    ),
                                    Sort(
                                        Search(
                                            SignaalFt_test,
                                            PrintGallery_SearchBar.Text,
                                            Titel,
                                            Body_N,
                                            Title_F,
                                            Body_F
                                        ),
                                        'Id (ID)',
                                        SortOrder.Ascending
                                    )
                                )
                        },
                        Filter(
                            baseData,
                            'Goedkeuringsstatus van inhoud' = "Approved",
                            'Confidentiality '.Value <> "Sensitive"
                        )
                    )
                  OnSelect: |-
                    =If(
                        IsBlank( LookUp(colPrintItems, 'Id (ID)' = ThisItem.'Id (ID)') ),
                        Collect(colPrintItems, ThisItem),
                        RemoveIf(colPrintItems, 'Id (ID)' = ThisItem.'Id (ID)')
                    );
                  TemplateFill: =If( !IsBlank( LookUp(colPrintItems, 'Id (ID)' = ThisItem.'Id (ID)') ), RGBA(0,120,215,0.12), RGBA(237, 237, 237, 1) )
                  TemplatePadding: =15
                  TemplateSize: =50
                  Visible: =visibility.PrintSelectedVis
                  Width: =Parent.Width - Self.X*2
                  X: =350
                  Y: =305 + Parent.PaddingTop
                Children:
                  - PrintGallery_ItemTitle:
                      Control: Classic/Button@2.2.0
                      Properties:
                        Align: =Align.Left
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(71, 69, 64, 1)
                        DisabledBorderColor: =RGBA(56, 56, 56, 1)
                        DisabledColor: =RGBA(186, 186, 186, 1)
                        DisabledFill: =RGBA(0, 0, 0, 0)
                        Fill: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Open Sans'
                        FontWeight: =FontWeight.Normal
                        Height: =Parent.TemplateHeight
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =RGBA(255, 255, 255, 1)
                        HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                        OnSelect: =Select(Parent)
                        PaddingBottom: =10
                        PaddingLeft: =10
                        PaddingRight: =10
                        PaddingTop: =10
                        PressedBorderColor: =Self.BorderColor
                        PressedFill: =Self.Fill
                        RadiusBottomLeft: =5
                        RadiusBottomRight: =5
                        RadiusTopLeft: =5
                        RadiusTopRight: =5
                        Size: =14
                        Text: =If(And(Language()  = "fr-FR", Len(ThisItem.Title_F) > 0), Left(ThisItem.Title_F, 70), Left(ThisItem.Titel, 70))
                        Width: =Parent.TemplateWidth - Self.X
                        X: =50
                  - PrintGallery_ItemID:
                      Control: Label@2.5.1
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.TemplateHeight
                        Size: =14
                        Text: =ThisItem.'Id (ID)'
                        Width: =50
            - PrintGallery_Selected:
                Control: Gallery@2.15.0
                Variant: BrowseLayout_Vertical_OneTextVariant_ver5.0
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  Fill: =RGBA(255, 255, 255, 1)
                  Height: =780
                  Items: =colPrintItems
                  TemplateFill: = RGBA(237, 237, 237, 1)
                  TemplatePadding: =15
                  TemplateSize: =50
                  Visible: =!IsEmpty(colPrintItems)
                  Width: =Parent.Width - Self.X*2
                  X: =350
                  Y: =If(visibility.PrintSelectedVis, 800) + 425 + Parent.PaddingTop
                Children:
                  - PrintGallery_Selected_Title:
                      Control: Label@2.5.1
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 1)
                        BorderThickness: =1
                        Color: =RGBA(71, 69, 64, 1)
                        DisabledColor: =RGBA(186, 186, 186, 1)
                        DisplayMode: =DisplayMode.View
                        FocusedBorderThickness: =1
                        Font: =Font.'Open Sans'
                        Height: =Parent.TemplateHeight
                        HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                        OnSelect: =Select(Parent)
                        PaddingBottom: =10
                        PaddingLeft: =10
                        PaddingRight: =10
                        PaddingTop: =10
                        Size: =14
                        Text: =If(And(Language()  = "fr-FR", Len(ThisItem.Title_F) > 0), ThisItem.Title_F, ThisItem.Titel)
                        Width: =Parent.TemplateWidth - Self.X
                        Wrap: =false
                        X: =50
                  - PrintGallery_Selected_ID:
                      Control: Label@2.5.1
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.TemplateHeight
                        Size: =14
                        Text: =ThisItem.'Id (ID)'
                        Width: =50
            - PrintGallery_PrintButton:
                Control: Classic/Icon@2.5.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderThickness: =1
                  Color: =RGBA(0, 120, 212, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  DisabledColor: =RGBA(220, 220, 220, 1)
                  DisabledFill: =RGBA(0, 0, 0, 0)
                  FocusedBorderThickness: =1
                  HoverBorderColor: =RGBA(0, 0, 0, 0)
                  HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  HoverFill: =RGBA(0, 0, 0, 0)
                  Icon: =Icon.DocumentPDF
                  OnSelect: "='PrintFlow_Test'.Run(\n            JSON(\n                {\n                    user: User(),\n                    language: Language(),\n                    signal: {\n                        body: \n                            ShowColumns(\n                            SharePointIntegration.Selected,\n                            'Id (ID)',\n                            Titel,\n                            Gemaakt,\n                            Gewijzigd,\n                            Topic,\n                            'Gemaakt door',\n                            'Gewijzigd door',\n                            Team,\n                            Recipients,\n                            Notify,\n                            Editors,\n                            Title_F,\n                            'Validated (System)',\n                            'Status (2)',\n                            'Confidentiality ',\n                            'Koppeling naar item'\n                        ),\n                        isNewSignal : false,\n                        isTopicChanged: Coalesce(changes.topicChange,false),\n                        isConfidentChanged: Coalesce(changes.confiChange,false),\n                        isEditorsChanged: Coalesce(changes.editorsChange,false)\n                        \n                    },\n                    signalUpdate: {\n                        body: \n                            ShowColumns(\n                            SharePointForm.Updates,\n                            Titel,\n                            Title_F,\n                            Topic,\n                            Editors,\n                            'Status (2)',\n                            'Confidentiality '\n                        )\n                    },\n                    validationRequest: {\n                        isValidationRequest: false,\n                        validators: Coalesce(Validators,[]),\n                        validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\n                    },\n                    validation: {\n                        isValidation: false,\n                        isDirectValidation: false,\n                        validationComment: \"No Comment\",\n                        isApproved: false\n                    },\n                    dirCom: {\n                        isForDirCom: false\n                    },\n                    priority: {\n                        isPrioCall: false,\n                        isConfirmed: false,\n                        prioCallComment: \"No Comment\"\n                    },\n                    print: {\n                        isPrint: true,\n                        printLanguage: Coalesce(PrintLanguage,false),\n                        body: \n                            ShowColumns(\n                            colPrintItems,\n                            'Id (ID)',\n                            Titel,\n                            Title_F,\n                            Body_N,\n                            Body_F\n                        )\n                    }\n                },\n                JSONFormat.IncludeBinaryData\n            )\n        );\n'BackEndLogFlow'.Run(\n            JSON(\n                {\n                    user: User(),\n                    language: Language(),\n                    site: \"testbeeldsubc\",\n                    list: \"SignaalFt_test\",\n                    isNewItem: false,\n                    signals: {\n                        signal: {\n                            body: \n                                ShowColumns(\n                                SharePointIntegration.Selected,\n                                'Id (ID)',\n                                Titel,\n                                Title_F,\n                                Topic,\n                                'Status (1)',\n                                'Status (2)',\n                                Domain,\n                                Source,\n                                Signal,\n                                SignalLocation,\n                                Reference,                                \n                                Gemaakt,\n                                Gewijzigd,\n                                'Gemaakt door',\n                                'Gewijzigd door',\n                                Team,\n                                Recipients,\n                                Notify,\n                                Editors,\n                                'Validated (System)',\n                                'Confidentiality ',\n                                'Koppeling naar item'\n                            ),\n                            isNewSignal : false,\n                            isTopicChanged: Coalesce(changes.topicChange,false),\n                            isConfidentChanged: Coalesce(changes.confiChange,false),\n                            isEditorsChanged: Coalesce(changes.editorsChange,false)\n                            \n                        },\n                        validationRequest: {\n                            isValidationRequest: Coalesce(validationRequest.isValidationRequest,false),\n                            validators: Validators,\n                            validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\n                        },\n                        validation: {\n                            isValidation: Coalesce(validation.isDirectValidation,false),\n                            isDirectValidation: Coalesce(validation.isDirectValidation,false),\n                            validationComment: If(validation.isDirectValidation,validation.directValidationComment,\"No Comment\"),\n                            isApproved: Coalesce(validation.isDirectValidation,false)\n                        },\n                        dirCom: {},\n                        priority: {},\n                        print: {\n                            isPrint: true,\n                            printLanguage: Coalesce(PrintLanguage,false),\n                            body: \n                                ShowColumns(\n                                colPrintItems,\n                                'Id (ID)',\n                                Titel,\n                                Title_F,\n                                Body_N,\n                                Body_F\n                            )\n                        }\n                    },\n                    strategicAnalysisProducts: {},\n                    barrierModels: {},\n                    partners: {}\n                },\n                JSONFormat.IncludeBinaryData\n            )\n        );\nClear(colPrintItems);\nSet(\n    visibility,\n    Patch(\n        visibility,\n        {\n            PrintSelectedVis:true\n        }\n    )\n);\nNotify(messages.fileSentMsg, NotificationType.Success);\nNavigate(OverViewScreen,ScreenTransition.Cover);\n"
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  PressedFill: =RGBA(0, 0, 0, 0)
                  Visible: =!IsEmpty(colPrintItems)
                  X: =Parent.Width/2 - Self.Width/2
                  Y: =Parent.PaddingTop + If(visibility.PrintSelectedVis, 1048, 250) + 50
            - PrintGallery_Instructions:
                Control: Label@2.5.1
                Properties:
                  Align: =Align.Center
                  BorderColor: =RGBA(149, 149, 149, 1)
                  BorderThickness: =2
                  Color: =RGBA(51, 51, 51, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  Fill: = RGBA(237, 237, 237, 1)
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  Height: =80
                  Size: =14
                  Text: =If(Language() = "fr-FR","Vous trouverez ci-dessous les éléments validés et non sensibles de la liste. Vous pouvez les sélectionner en cliquant dessus (cliquez à nouveau pour les désélectionner). Cliquez sur « Ready » pour afficher la liste des signaux sélectionnés, définissez la langue, puis cliquez sur l'icône PDF pour recevoir un e-mail contenant les signaux.","Onderstaand staan de gevalideerde, non-sensitive lijstitems. Je kan ze selecteren door erop te klikken (opnieuw klikken is deselecteren). Klik op 'Ready' om de lijst met geselecteerde signalen te bekijken, stel de taal in en druk vervolgens op het PDF-icoon om een e-mail te ontvangen met de signalen.")
                  Width: =1300
                  X: =Parent.Width/2 - Self.Width/2
                  Y: =50
            - PrintGallery_LangToggle:
                Control: Classic/Toggle@2.1.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderStyle: =BorderStyle.None
                  Color: =RGBA(51, 51, 51, 1)
                  DisabledBorderColor: =RGBA(0, 0, 0, 0)
                  FalseFill: =RGBA(102, 102, 102, 1)
                  FalseHoverFill: =RGBA(33, 33, 33, 1)
                  FalseText: ="FR"
                  FocusedBorderThickness: =1
                  Font: =Font.'Segoe UI'
                  FontWeight: =FontWeight.Bold
                  Height: =30
                  HoverBorderColor: =RGBA(0, 0, 0, 0)
                  OnChange: =Set(PrintLanguage, !PrintLanguage)
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  Size: =14
                  TrueFill: =RGBA(0, 120, 212, 1)
                  TrueHoverFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  TrueText: ="NL"
                  Visible: =!IsEmpty(colPrintItems)
                  Width: =108
                  X: =970
                  Y: =Parent.PaddingTop + If(visibility.PrintSelectedVis, 1067, 270) +50
            - PrintGallery_Search:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  BorderColor: =RGBA(166, 166, 166, 1)
                  BorderThickness: =1
                  DropShadow: =DropShadow.None
                  Height: =55
                  PaddingBottom: =5
                  PaddingLeft: =5
                  PaddingRight: =5
                  PaddingTop: =5
                  RadiusBottomLeft: =5
                  RadiusBottomRight: =5
                  RadiusTopLeft: =5
                  RadiusTopRight: =5
                  Width: =600
                  X: =Parent.Width/2 - Self.Width/2
                  Y: =Parent.PaddingTop + 50
                Children:
                  - PrintGallery_SearchBar:
                      Control: Classic/TextInput@2.3.2
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(166, 166, 166, 1)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        Default: =
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingTop - Parent.PaddingBottom
                        HintText: =If(Language()  = "fr-FR", "Cherchez le signale...", "Zoek het signaal...")
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        PaddingBottom: =10
                        PaddingLeft: =5
                        PaddingTop: =10
                        PressedBorderColor: =RGBA(0, 120, 212, 1)
                        PressedColor: =RGBA(51, 51, 51, 1)
                        PressedFill: =RGBA(255, 255, 255, 1)
                        RadiusBottomLeft: =0
                        RadiusBottomRight: =0
                        RadiusTopLeft: =0
                        RadiusTopRight: =0
                        Size: =14
                        Width: =Parent.Width - 100
                        X: =Parent.Width/2 - Self.Width/2
                        Y: =Parent.Height / 2 - Self.Height / 2
                  - PrintGallery_Search_CancelIcon:
                      Control: Classic/Icon@2.5.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderThickness: =1
                        Color: =RGBA(0, 120, 212, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(220, 220, 220, 1)
                        DisabledFill: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Height: =35
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverFill: =RGBA(0, 0, 0, 0)
                        Icon: =Icon.Cancel
                        OnSelect: =Reset(PrintGallery_SearchBar)
                        PressedBorderColor: =RGBA(0, 0, 0, 0)
                        PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedFill: =RGBA(0, 0, 0, 0)
                        Width: =35
                        X: =Parent.Width - Self.Width - Parent.PaddingRight
                        Y: =Parent.Height / 2 - Self.Height / 2
                  - PrintGallery_Search_SearchIcon:
                      Control: Classic/Icon@2.5.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderThickness: =1
                        Color: =RGBA(166, 166, 166, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        DisabledColor: =RGBA(220, 220, 220, 1)
                        DisabledFill: =RGBA(0, 0, 0, 0)
                        DisplayMode: =DisplayMode.Disabled
                        FocusedBorderThickness: =1
                        Height: =35
                        HoverBorderColor: =
                        HoverColor: =
                        HoverFill: =
                        Icon: =Icon.Search
                        PressedBorderColor: =RGBA(0, 0, 0, 0)
                        PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedFill: =RGBA(0, 0, 0, 0)
                        Width: =35
                        X: =Parent.PaddingLeft
                        Y: =Parent.Height / 2 - Self.Height / 2
            - PrintGallery_Counter_All:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  Height: =55
                  PaddingBottom: =5
                  PaddingLeft: =10
                  PaddingRight: =10
                  PaddingTop: =5
                  RadiusBottomLeft: =5
                  RadiusBottomRight: =5
                  RadiusTopLeft: =5
                  RadiusTopRight: =5
                  Width: =300
                  X: =Parent.Width/2 - Self.Width/2
                  Y: =Parent.PaddingTop + 125
                Children:
                  - PrintGallery_Counter_All_Count:
                      Control: Label@2.5.1
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(39, 113, 194, 1)
                        BorderThickness: =2
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =RGBA(102, 174, 229, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        PaddingLeft: =0
                        Size: =16
                        Text: =PrintGallery_List.AllItemsCount
                        Width: =50
                        X: =Parent.Width - Self.Width - Parent.PaddingRight
                        Y: =Parent.Height / 2 - Self.Height / 2
                  - PrintGallery_Counter_All_Label:
                      Control: Label@2.5.1
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        PaddingLeft: =10
                        PaddingRight: =10
                        Size: =14
                        Text: =If(Language()  = "fr-FR", "Signaux montrés:", "Getoonde signalen:")
                        Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight - 50
                        X: =Parent.PaddingLeft
                        Y: =Parent.Height / 2 - Self.Height / 2
            - PrintGallery_Counter_Selected:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  Height: =55
                  PaddingBottom: =5
                  PaddingLeft: =10
                  PaddingRight: =10
                  PaddingTop: =5
                  RadiusBottomLeft: =5
                  RadiusBottomRight: =5
                  RadiusTopLeft: =5
                  RadiusTopRight: =5
                  Width: =450
                  X: =Parent.Width/2 - Self.Width/2 + 75
                  Y: =Parent.PaddingTop + 200
                Children:
                  - PrintGallery_Counter_Selected_Count:
                      Control: Label@2.5.1
                      Properties:
                        Align: =Align.Center
                        BorderColor: =RGBA(39, 113, 194, 1)
                        BorderThickness: =2
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =RGBA(102, 174, 229, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        PaddingLeft: =0
                        Size: =16
                        Text: =CountRows(colPrintItems)
                        Width: =50
                        X: =Parent.Width - Self.Width - Parent.PaddingRight - 150
                        Y: =Parent.Height / 2 - Self.Height / 2
                  - PrintGallery_Counter_Selected_Label:
                      Control: Label@2.5.1
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        PaddingLeft: =10
                        PaddingRight: =10
                        Size: =14
                        Text: =If(Language()  = "fr-FR", "Signaux sélectionés:", "Geselecteerde signalen:")
                        Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight - 150
                        X: =Parent.PaddingLeft
                        Y: =Parent.Height / 2 - Self.Height / 2
                  - PrintGallery_Counter_Selected_Clear:
                      Control: Classic/Button@2.2.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =RGBA(184, 0, 0, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        HoverBorderColor: =RGBA(118, 0, 0, 1)
                        HoverColor: =RGBA(255, 255, 255, 1)
                        HoverFill: =ColorFade(RGBA(118, 0, 0, 1), -10%)
                        OnSelect: |-
                          =Clear(colPrintItems);
                          Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      PrintSelectedVis:true
                                  }
                              )
                          );
                        PressedBorderColor: =RGBA(118, 0, 0, 1)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =ColorFade(RGBA(118, 0, 0, 1), -30%)
                        RadiusBottomLeft: =5
                        RadiusBottomRight: =5
                        RadiusTopLeft: =5
                        RadiusTopRight: =5
                        Size: =14
                        Text: ="Clear"
                        Width: =65
                        X: =Parent.Width - Self.Width - Parent.PaddingRight
                        Y: =Parent.Height / 2 - Self.Height / 2
                  - PrintGallery_Counter_Selected_Ready:
                      Control: Classic/Button@2.2.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =If(visibility.PrintSelectedVis, RGBA(54, 176, 75, 1), RGBA(0, 120, 212, 1))
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        HoverBorderColor: =RGBA(118, 0, 0, 1)
                        HoverColor: =RGBA(255, 255, 255, 1)
                        HoverFill: =If(visibility.PrintSelectedVis, ColorFade(RGBA(54, 176, 75, 1),-10%), ColorFade(RGBA(0, 120, 212, 1),-10%))
                        OnSelect: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      PrintSelectedVis:!visibility.PrintSelectedVis
                                  }
                              )
                          );
                        PressedBorderColor: =RGBA(118, 0, 0, 1)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =If(visibility.PrintSelectedVis, ColorFade(RGBA(0, 120, 212, 1),-30%), ColorFade(RGBA(54, 176, 75, 1),-30%))
                        RadiusBottomLeft: =5
                        RadiusBottomRight: =5
                        RadiusTopLeft: =5
                        RadiusTopRight: =5
                        Size: =14
                        Text: =If(visibility.PrintSelectedVis,"Ready","Back")
                        Width: =65
                        X: =Parent.Width - Self.Width - Parent.PaddingRight - 75
                        Y: =Parent.Height / 2 - Self.Height / 2
      - CancelButton_Container:
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
            Width: =50
            X: =1200
            Y: =245
          Children:
            - CancelButton:
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
                  Icon: =Icon.Cancel
                  OnSelect: =Navigate(OverViewScreen,ScreenTransition.Cover);
                  PaddingBottom: =10
                  PaddingLeft: =10
                  PaddingRight: =10
                  PaddingTop: =10
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  PressedFill: =RGBA(0, 0, 0, 0)
                  Tooltip: =
                  Width: =50
      - AdminSwitch_2:
          Control: GroupContainer@1.5.0
          Variant: ManualLayout
          Properties:
            DropShadow: =DropShadow.Regular
            Fill: =RGBA(255, 255, 255, 1)
            Height: =50
            RadiusBottomLeft: =10
            RadiusBottomRight: =10
            RadiusTopLeft: =10
            RadiusTopRight: =10
            Visible: =User().Email = "Nelis.Eerdekens@police.belgium.eu"
            Width: =200
            X: =60
            Y: =60
          Children:
            - AdminSwitch_Toggle_2:
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
                  Y: =Parent.Height / 2 - 10
            - AdminSwitch_Label_2:
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
                  Y: =5
