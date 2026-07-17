Screens:
  TutorialScreen:
    Properties:
      BackgroundImage: ='177590775'
      Fill: =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height, 2200)
      ImagePosition: =ImagePosition.Fill
      LoadingSpinnerColor: =RGBA(0, 120, 212, 1)
      OnVisible: |-
        =If(
            (Value(SharePointForm.Mode) = FormMode.View),
                ClearCollect(
                    CGDTOIntel,
                    'Office365Groups'.ListGroupMembers(
                        Coalesce(
                            LookUp(
                                'Office365Groups'.ListOwnedGroups().value,
                                displayName = "Signals_CGDTOIntel (Grp)"
                            ).id,
                            "2523ce42-4a2f-4527-8e9f-a4f2b6ee7f7a"
                        )
                    ).value
                );
                Set(
                    profiles,
                    Patch(
                        profiles,
                        {
                            isDirComMember:
                            !IsBlank(
                                LookUp(
                                    'Office365Groups'.ListGroupMembers(
                                        Coalesce(
                                            LookUp(
                                                'Office365Groups'.ListOwnedGroups().value,
                                                displayName = "SignalTest_DirCom"
                                            ).id,
                                            "bb617bb0-9ee8-4184-8dec-e52de810eb3f"
                                        )
                                    ).value,
                                    mail = User().Email
                                )
                            )
                        }
                    )
                )
        );
        Set(
            system,
            Patch(
                system,
                {
                    isTutorialRendered: true,
                    toggleAdmin: profiles.isAdmin
                }
            )
        );
      Width: =Max(App.Width, 1500)
    Children:
      - Tutorial_Navigator:
          Control: Gallery@2.15.0
          Variant: TutorialGalleryHorizontal
          Properties:
            AccessibleLabel: ="Layouts_Tutorial_Gallery_Accessible_Text"
            BorderColor: =RGBA(166, 166, 166, 1)
            Items: |-
              =Table(           
               {Step: 0, Text:If(system.isFormDataRendered,messages.tutorialCarouselMsg1b,messages.tutorialCarouselMsg1a), Image: '1047719428'},           
               {Step: 1, Text:messages.tutorialCarouselMsg2, Image: '496381929'},           
               {Step: 2, Text:messages.tutorialCarouselMsg3, Image: '496381929'},           
               {Step: 3, Text:messages.tutorialCarouselMsg4, Image: '643708308_super'}
              )
            Y: =Tutorial_Image.Y + Tutorial_Image.Height
          Children:
            - Circle1:
                Control: Circle@2.3.0
                Properties:
                  BorderColor: =RGBA(0, 0, 0, 0)
                  BorderThickness: =2
                  DisabledFill: =RGBA(0, 120, 212, 1)
                  Fill: =If(Or(ThisItem.Step = 0 && IsBlank(_guideStep), ThisItem.Step = _guideStep), Tutorial_PreviousButton.Color, RGBA(0,0,0,0))
                  FocusedBorderThickness: =4
                  Height: =Circle1.Width
                  HoverFill: =RGBA(0, 120, 212, 1)
                  OnSelect: =Set(_guideStep, ThisItem.Step)
                  PressedFill: =RGBA(0, 120, 212, 1)
                  TabIndex: =0
                  Width: =Parent.TemplateWidth - 5
                  X: =Parent.TemplateWidth/2 - Self.Width/2
                  Y: =Parent.TemplateHeight/2 - Self.Height/2
      - Tutorial_Image:
          Control: Image@2.2.3
          Properties:
            AccessibleLabel: ="Layouts_Tutorial_Image_Accessible_Text"
            BorderColor: =RGBA(0, 0, 0, 0)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            DisabledBorderColor: =RGBA(0, 0, 0, 0)
            DisabledFill: =RGBA(0, 0, 0, 0)
            FocusedBorderThickness: =1
            Height: =450
            HoverBorderColor: =RGBA(0, 0, 0, 0)
            HoverFill: =RGBA(0, 0, 0, 0)
            Image: =If(IsBlank(_guideStep), First(Tutorial_Navigator.AllItems).Image, LookUp(Tutorial_Navigator.AllItems, Step = _guideStep).Image)
            PressedBorderColor: =RGBA(0, 0, 0, 0)
            PressedFill: =RGBA(0, 0, 0, 0)
            Width: =Parent.Width
            Y: =Parent.Height / 6
      - Tutorial_Text:
          Control: Label@2.5.1
          Properties:
            Align: =Align.Center
            BorderColor: =RGBA(0, 0, 0, 1)
            Color: =RGBA(255, 255, 255, 1)
            Fill: =RGBA(102, 152, 191, 0.62)
            Font: =Font.'Segoe UI'
            Height: =150
            LineHeight: =1.3
            PaddingLeft: =20
            PaddingRight: =20
            Size: =24
            Text: =If(IsBlank(_guideStep), First(Tutorial_Navigator.AllItems).Text, LookUp(Tutorial_Navigator.AllItems, Step = _guideStep).Text)
            Width: =500
            X: =Parent.Width / 2 -  Self.Width / 2
            Y: =Tutorial_Image.Y + Tutorial_Image.Height / 2
      - Tutorial_PreviousButton:
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
            Icon: =Icon.ChevronLeft
            OnSelect: =Set(_guideStep, Max(_guideStep-1, First(Tutorial_Navigator.AllItems).Step))
            PressedBorderColor: =RGBA(0, 0, 0, 0)
            PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            PressedFill: =RGBA(0, 0, 0, 0)
            TabIndex: =0
            Tooltip: ="Previous step"
            Visible: =_guideStep > 0
            X: =Tutorial_Text.X - Tutorial_PreviousButton.Width - 100
            Y: =Tutorial_Image.Y + Tutorial_Image.Height / 2 - Self.Height / 2
      - Tutorial_NextButton:
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
            Icon: =Icon.ChevronRight
            OnSelect: =Set(_guideStep, Min(_guideStep+1, Last(Tutorial_Navigator.AllItems).Step))
            PressedBorderColor: =RGBA(0, 0, 0, 0)
            PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            PressedFill: =RGBA(0, 0, 0, 0)
            TabIndex: =0
            Tooltip: ="Next step"
            Visible: =Last(Tutorial_Navigator.AllItems).Step > _guideStep
            X: =Tutorial_Text.X + Tutorial_Text.Width + 100
            Y: =Tutorial_PreviousButton.Y
      - Tutorial_SkipButton:
          Control: Classic/Button@2.2.0
          Properties:
            BorderColor: =RGBA(0, 0, 0, 0)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            Color: =RGBA(0, 42, 74, 1)
            DisabledBorderColor: =RGBA(0, 0, 0, 0)
            Fill: =If(system.isFormDataRendered,RGBA(209, 232, 178, 1), ColorFade(RGBA(0, 120, 212, 1), Tutorial_SkipButton_ColorTimer.Value/5000))
            FocusedBorderThickness: =1
            Font: =Font.'Segoe UI'
            Height: =100
            HoverBorderColor: =RGBA(0, 0, 0, 0)
            HoverColor: =RGBA(255, 255, 255, 1)
            HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
            OnSelect: |-
              =If(
                  !system.isFormDataRendered,
                      Notify(messages.waitOnDataMsg,NotificationType.Warning,3000),
                  Set(
                      system,
                      Patch(
                          system,
                          {
                              isRendered: true,
                              isTutorialSeen: true
                          }
                      )
                  );
                  If(
                      SharePointForm.Mode = FormMode.View,
                          Navigate(OverViewScreen,ScreenTransition.Cover),
                      Navigate(FormScreen,ScreenTransition.Cover)
                  )
              )
            PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
            PressedColor: =RGBA(209, 232, 178, 1)
            PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            Text: =If(system.isFormDataRendered,"Continue ➡️","Loading...")
            Width: =200
            X: =Parent.Width - Self.Width - 50
            Y: =50
      - Tutorial_NavigateTimer:
          Control: Timer@2.1.0
          Properties:
            BorderColor: =RGBA(0, 120, 212, 1)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            Color: =RGBA(255, 255, 255, 1)
            Duration: =100
            Fill: =RGBA(0, 120, 212, 1)
            FocusedBorderThickness: =1
            Font: =Font.'Segoe UI'
            HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -10%)
            HoverColor: =RGBA(255, 255, 255, 1)
            HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
            OnTimerEnd: "=If(\r\n    (Value(SharePointForm.Mode) <> FormMode.View),\r\n        Navigate(RenderingScreen,ScreenTransition.None);\r\n        Set(\r\n            system,\r\n            Patch(\r\n                system,\r\n                {\r\n                    isTutorialRendered: false\r\n                }\r\n            )\r\n        ),\r\n    ClearCollect(colPrintItems,SharePointIntegration.Selected); \r\n    ClearCollect(Topics, SharePointIntegration.Selected.Topic);\r\n    ClearCollect(otherTopics,[]);\r\n    ClearCollect(Status2, SharePointIntegration.Selected.'Status (2)');\r\n\r\n    Set(\r\n        system,\r\n        Patch(\r\n            system,\r\n            {\r\n                isFlowRunning: SharePointIntegration.Selected.FlowRunning\r\n            }\r\n        )\r\n    );\r\n    Set(\r\n        validationRequest,\r\n        Patch(\r\n            validationRequest,\r\n            {\r\n                isValidationRequested: And(system.isFlowRunning,SharePointIntegration.Selected.'Goedkeuringsstatus van inhoud' = \"Pending\"),\r\n                isForDirCom: CountRows(Filter(Status2, Value = \"For DirCom\"))>0\r\n            }\r\n        )\r\n    );\r\n    Set(\r\n        profiles,\r\n        Patch(\r\n            profiles,\r\n            {\r\n                isEditor: CountRows(Filter(SharePointIntegration.Selected.Editors,Email = User().Email))>0,\r\n                isRecipient: CountRows(Filter(SharePointIntegration.Selected.Recipients,Email = User().Email))>0,\r\n                isAuthor: SharePointIntegration.Selected.'Gemaakt door'.Email = User().Email,\r\n                isTeamMember: CountRows(Filter(SharePointIntegration.Selected.Team,Email = User().Email))>0,\r\n                isMember:Or(profiles.isEditor,profiles.isAuthor,profiles.isRecipient,profiles.isTeamMember)\r\n            }\r\n        )\r\n    );\r\n    \r\n    Set(\r\n        priority,\r\n        Patch(\r\n            priority,\r\n            {\r\n                isPrioCalled: Or(CountRows(Filter(Status2, Value = \"Confirmed by DirCom\"))>0,CountRows(Filter(Status2, Value = \"Noticed by DirCom\"))>0)\r\n            }\r\n        )\r\n    );\r\n    If(\r\n        And(profiles.isTeamMember,!profiles.isRecipient),\r\n            ClearCollect(\r\n                Validators,\r\n                    Filter(\r\n                        SharePointIntegration.Selected.Team,\r\n                        Lower(Email) in\r\n                            ForAll('Office365Groups'.ListGroupMembers(\r\n                                Coalesce(\r\n                                    LookUp(\r\n                                        'Office365Groups'.ListOwnedGroups().value,\r\n                                        displayName = \"SignalTest_ValidOne\"\r\n                                    ).id,\r\n                                    \"d59e4619-45a8-4375-a20e-15eeec07004b\"\r\n                                )\r\n                            ).value, \r\n                        Lower(mail)\r\n                    )\r\n                )\r\n            )\r\n    );\r\n    If(\r\n        profiles.isRecipient,\r\n            ClearCollect(\r\n                Validators,\r\n                    Filter(\r\n                        SharePointIntegration.Selected.Recipients,\r\n                        Lower(Email) in\r\n                            ForAll('Office365Groups'.ListGroupMembers(\r\n                                Coalesce(\r\n                                    LookUp(\r\n                                        'Office365Groups'.ListOwnedGroups().value,\r\n                                        displayName = \"SignalTest_ValidTwo\"\r\n                                    ).id,\r\n                                    \"1dd78fb6-16d8-4047-aac4-10a37486da3c\"\r\n                                )\r\n                            ).value, \r\n                        Lower(mail)\r\n                    )\r\n                )\r\n            )\r\n    );\r\n    Set(\r\n        profiles,\r\n        Patch(\r\n            profiles,\r\n            {\r\n                isValidatorScoped: !IsBlank(LookUp(Validators, Email = User().Email))\r\n            }\r\n        )\r\n    );\r\n    Set(\r\n        profiles,\r\n        Patch(\r\n            profiles,\r\n            {\r\n                isValidator: Or(\r\n                    !IsBlank(\r\n                        LookUp(\r\n                            'Office365Groups'.ListGroupMembers(\r\n                                Coalesce(\r\n                                        LookUp(\r\n                                            'Office365Groups'.ListOwnedGroups().value,\r\n                                            displayName = \"SignalTest_ValidOne\"\r\n                                        ).id,\r\n                                        \"d59e4619-45a8-4375-a20e-15eeec07004b\"\r\n                                    )\r\n                            ).value,\r\n                            mail = User().Email\r\n                        )\r\n                    ),\r\n                    !IsBlank(\r\n                        LookUp(\r\n                            'Office365Groups'.ListGroupMembers(\r\n                                Coalesce(\r\n                                        LookUp(\r\n                                            'Office365Groups'.ListOwnedGroups().value,\r\n                                            displayName = \"SignalTest_ValidTwo\"\r\n                                        ).id,\r\n                                        \"1dd78fb6-16d8-4047-aac4-10a37486da3c\"\r\n                                    )\r\n                            ).value,\r\n                            mail = User().Email\r\n                        )\r\n                    )\r\n                )\r\n            }\r\n        )\r\n    );\r\n\r\n    Set(\r\n        system,\r\n        Patch(\r\n            system,\r\n            {\r\n                isFormDataRendered: true\r\n            }\r\n        )\r\n    )\r\n)"
            OnTimerStart: =
            PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            PressedColor: =RGBA(255, 255, 255, 1)
            PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            Size: =10.5
            Start: =system.isTutorialRendered
            Visible: =false
            X: =60
            Y: =60
      - Tutorial_SkipButton_ColorTimer:
          Control: Timer@2.1.0
          Properties:
            AutoStart: =true
            BorderColor: =RGBA(0, 120, 212, 1)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            Color: =RGBA(255, 255, 255, 1)
            Duration: =1500
            Fill: =RGBA(0, 120, 212, 1)
            FocusedBorderThickness: =1
            Font: =Font.'Segoe UI'
            HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -10%)
            HoverColor: =RGBA(255, 255, 255, 1)
            HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
            PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            PressedColor: =RGBA(255, 255, 255, 1)
            PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            Repeat: =true
            Size: =10.5
            Visible: =false
            X: =40
            Y: =40
