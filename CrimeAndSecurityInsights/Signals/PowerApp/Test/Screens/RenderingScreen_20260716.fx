Screens:
  RenderingScreen:
    Properties:
      BackgroundImage: ='482727025_high'
      Fill: =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height, 2200)
      ImagePosition: =ImagePosition.Fill
      LoadingSpinnerColor: =RGBA(0, 120, 212, 1)
      OnVisible: |-
        =If(
            profiles.isAdmin,
                Notify(messages.waitOnDataMsg,NotificationType.Information,3000)
        );
        Set(
            system,
            Patch(
                system,
                {
                    isRendered: false,
                    toggleAdmin: profiles.isAdmin
                }
            )
        );
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
                                            "d59e4619-45a8-4375-a20e-15eeec07004b"
                                        )
                                    ).value,
                        'Office365Groups'.ListGroupMembers(
                                        Coalesce(
                                            LookUp(
                                                'Office365Groups'.ListOwnedGroups().value,
                                                displayName = "SignalTest_ValidTwo"
                                            ).id,
                                            "1dd78fb6-16d8-4047-aac4-10a37486da3c"
                                        )
                                    ).value
                );
                Clear(NewValidators);
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
                ),

            ClearCollect(colPrintItems,SharePointIntegration.Selected); 
            ClearCollect(Topics, SharePointIntegration.Selected.Topic);
            ClearCollect(otherTopics,[]);
            ClearCollect(Status2, SharePointIntegration.Selected.'Status (2)');

            Set(
                profiles,
                Patch(
                    profiles,
                    {
                        isEditor: CountRows(Filter(SharePointIntegration.Selected.Editors,Email = User().Email))>0,
                        isRecipient: CountRows(Filter(SharePointIntegration.Selected.Recipients,Email = User().Email))>0,
                        isAuthor: SharePointIntegration.Selected.'Gemaakt door'.Email = User().Email,
                        isTeamMember: CountRows(Filter(SharePointIntegration.Selected.Team,Email = User().Email))>0,
                        isMember: Or(profiles.isEditor,profiles.isAuthor,profiles.isRecipient,profiles.isTeamMember),
                        isDirComMember: !IsBlank(
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
            );
            Set(
                validationRequest,
                Patch(
                    validationRequest,
                    {
                        isValidationRequested: And(system.isFlowRunning,SharePointIntegration.Selected.'Goedkeuringsstatus van inhoud' = "Pending"),
                        isConfirmedForDirCom: CountRows(Filter(Status2, Value = "For DirCom"))>0
                    }
                )
            );
            Set(
                priority,
                Patch(
                    priority,
                    {
                        isPrioCalled: Or(CountRows(Filter(Status2, Value = "Confirmed by DirCom"))>0,CountRows(Filter(Status2, Value = "Noticed by DirCom"))>0)
                    }
                )
            );
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
                                            "d59e4619-45a8-4375-a20e-15eeec07004b"
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
                                SharePointIntegration.Selected.Recipients,
                                Lower(Email) in
                                    ForAll('Office365Groups'.ListGroupMembers(
                                        Coalesce(
                                            LookUp(
                                                'Office365Groups'.ListOwnedGroups().value,
                                                displayName = "SignalTest_ValidTwo"
                                            ).id,
                                            "1dd78fb6-16d8-4047-aac4-10a37486da3c"
                                        )
                                    ).value, 
                                Lower(mail)
                            )
                        )
                    )
            );
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
                        isValidatorScoped: !IsBlank(LookUp(Validators, Email = User().Email))
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
            )
        );
      Width: =Max(App.Width, 1500)
    Children:
      - Rendering_Cirlce:
          Control: Circle@2.3.0
          Properties:
            BorderColor: =RGBA(0, 0, 0, 0)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            DisabledFill: =RGBA(0, 120, 212, 1)
            Fill: =ColorFade(RGBA(0, 120, 212, 1), Rendering_Icon_ColorTimer.Value/5000)
            Height: =200
            HoverFill: =ColorFade(RGBA(0, 120, 212, 1), Rendering_Icon_ColorTimer.Value/5000)
            PressedFill: =ColorFade(RGBA(0, 120, 212, 1), Rendering_Icon_ColorTimer.Value/5000)
            Width: =200
            X: =Parent.Width/2 - Self.Width/2
            Y: =400
      - Rendering_Icon:
          Control: Classic/Icon@2.5.0
          Properties:
            BorderColor: =RGBA(0, 0, 0, 0)
            Color: =RGBA(255, 255, 255, 1)
            DisabledBorderColor: =RGBA(0, 0, 0, 0)
            DisabledColor: =RGBA(220, 220, 220, 1)
            Height: =Rendering_Cirlce.Height - Self.PaddingTop - Self.PaddingBottom
            HoverColor: =RGBA(255, 255, 255, 1)
            Icon: =Icon.Sync
            PaddingBottom: =20
            PaddingLeft: =20
            PaddingRight: =20
            PaddingTop: =20
            PressedColor: =RGBA(255, 255, 255, 1)
            PressedFill: =RGBA(0, 0, 0, 0)
            Width: =Rendering_Cirlce.Width - Self.PaddingLeft - Self.PaddingRight
            X: =Parent.Width/2 - Self.Width/2
            Y: =Rendering_Cirlce.Y + Self.PaddingTop
      - Rendering_Message:
          Control: Label@2.5.1
          Properties:
            Align: =Align.Center
            BorderColor: =RGBA(0, 0, 0, 0)
            BorderStyle: =BorderStyle.None
            BorderThickness: =1
            Color: =RGBA(51, 51, 51, 1)
            DisabledBorderColor: =RGBA(0, 0, 0, 0)
            Fill: =RGBA(255, 255, 255, 0.84)
            FocusedBorderThickness: =1
            Font: =Font.'Segoe UI'
            FontWeight: =FontWeight.Bold
            Height: =156
            PaddingLeft: =0
            Size: =24
            Text: =messages.tutorialCarouselMsg1a
            Width: =Parent.Width * 0.70
            X: =Parent.Width/2 - Self.Width/2
            Y: =200
      - Rendering_Icon_ColorTimer:
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
      - Rendering_NavigateTimer:
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
            OnTimerEnd: |-
              =Switch(
                  SharePointForm.Mode, 
                      FormMode.View, 
                          Navigate(OverViewScreen,ScreenTransition.Cover),
                      FormMode.New, 
                          Navigate(FormScreen,ScreenTransition.Cover);
                          Set(
                              system,
                              Patch(
                                  system,
                                  {
                                      isRendered: false
                                  }
                              )
                          ),
                      FormMode.Edit,
                          Navigate(FormScreen,ScreenTransition.Cover)
              )
            PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            PressedColor: =RGBA(255, 255, 255, 1)
            PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
            Size: =10.5
            Start: =system.isRendered
            Visible: =false
            X: =60
            Y: =60
