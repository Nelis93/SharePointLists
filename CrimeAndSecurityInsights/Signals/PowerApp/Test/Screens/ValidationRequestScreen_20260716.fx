Screens:
  ValidationRequestScreen:
    Properties:
      Fill: =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height, 2200)
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
      Width: =Max(App.Width, 1500)
    Children:
      - ValidationRequest_Container:
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
            - ValidationRequest_Instructions:
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
                  Text: =If(Language() = "fr-FR","Vous trouverez ci-dessous les éléments validés et non sensibles de la liste. Vous pouvez les sélectionner en cliquant dessus (cliquez à nouveau pour les désélectionner). Cliquez sur « Ready » pour afficher la liste des signaux sélectionnés, définissez la langue, puis cliquez sur l'icône PDF pour recevoir un e-mail contenant les signaux.","Via een druk op de knop kan u de validatie van het signaal aanvragen. Bekijk jouw validatoren (en verwijder indien nodig) en geef een boodschap mee in het tekstveld.")
                  Width: =1300
                  X: =Parent.Width/2 - Self.Width/2
                  Y: =50
            - ValidationRequest_UserComment:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  DropShadow: =DropShadow.Regular
                  Height: =300
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =Parent.Width - Self.X*2
                  X: =250
                  Y: =600
                Children:
                  - ValidationRequest_UserComment_Input:
                      Control: Classic/TextInput@2.3.2
                      Properties:
                        BorderColor: =RGBA(166, 166, 166, 1)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        Default: =
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =230
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
                        Width: =950
                        X: =Parent.Width/2 - Self.Width/2
                        Y: =Parent.Height/2 - Self.Height/2 + 10
                  - ValidationRequest_UserComment_Label:
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
                        Text: ="Comment"
                        Width: =Parent.Width - Self.X * 2
                        X: =20
            - ValidationRequest_ValidatorList:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  DropShadow: =DropShadow.Regular
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =Parent.Width * .65 - Self.X*2
                  X: =250
                  Y: =250
                Children:
                  - ValidationRequest_VList_Label:
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
                        Text: =If(CountRows(Validators)>0,messages.yourValidatorsMsg,messages.dataReloadMsg)
                        Width: =Parent.Width - Self.X*2
                        X: =20
                  - ValidationRequest_VList_Selected:
                      Control: Gallery@2.15.0
                      Variant: BrowseLayout_Vertical_OneTextVariant_ver5.0
                      Properties:
                        BorderColor: =RGBA(166, 166, 166, 1)
                        Height: =Parent.Height - Self.Y - 20
                        Items: =Validators
                        TemplateFill: =RGBA(237, 237, 237, 1)
                        TemplatePadding: =10
                        TemplateSize: =40
                        Visible: =visibility.VListVis
                        Width: =Parent.Width * .85 - Self.X * 2
                        X: =20
                        Y: =50
                      Children:
                        - SelectedValidatorName:
                            Control: Label@2.5.1
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 1)
                              BorderThickness: =1
                              Color: =RGBA(71, 69, 64, 1)
                              DisabledColor: =RGBA(186, 186, 186, 1)
                              DisplayMode: =DisplayMode.View
                              FocusedBorderThickness: =1
                              Font: =Font.'Open Sans'
                              Height: =32
                              OnSelect: =Select(Parent)
                              PaddingBottom: =0
                              PaddingLeft: =0
                              PaddingRight: =0
                              PaddingTop: =0
                              Size: =14
                              Text: =ThisItem.DisplayName
                              VerticalAlign: =VerticalAlign.Top
                              Width: =Parent.TemplateWidth - 86
                              Wrap: =false
                              X: =16
                              Y: =5
                        - CancelSelectedValidator:
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
                                Notify("After filter" & Concat(Filter(Validators, Claims <> ThisItem.Claims),Email,"; "),NotificationType.Information,10000)
                              PressedBorderColor: =RGBA(0, 0, 0, 0)
                              PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              PressedFill: =RGBA(0, 0, 0, 0)
                              Width: =20
                              X: =Parent.TemplateWidth - Self.Width - 20
                        - Separator1_2:
                            Control: Rectangle@2.3.0
                            Properties:
                              BorderColor: =RGBA(0, 0, 255, 1)
                              Fill: =RGBA(255, 255, 255, 1)
                              FocusedBorderThickness: =1
                              Height: =8
                              OnSelect: =Select(Parent)
                              Width: =Parent.TemplateWidth
                              Y: =Parent.TemplateHeight - Self.Height
                  - ToggleValidatorList:
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
                        Icon: =If(visibility.VListVis,Icon.ChevronUp,If(CountRows(Validators)>0,Icon.ChevronDown,Icon.Sync))
                        OnSelect: |-
                          =Set(
                              visibility,
                              Patch(
                                  visibility,
                                  {
                                      VListVis: !visibility.VListVis
                                  }
                              )
                          );
                          If(
                              CountRows(Validators)>0,
                                  If(
                                      profiles.isAdmin,
                                          Notify("oke",NotificationType.Success,3000)
                                  ),
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
                                                  SharePointIntegration.Selected.Team,
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
                              If(
                                  profiles.isAdmin,
                                      Notify("not oke",NotificationType.Error,3000)
                              )
                          )
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        PressedBorderColor: =RGBA(0, 0, 0, 0)
                        PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        PressedFill: =RGBA(0, 0, 0, 0)
                        Rotation: =
                        Width: =30
                        X: =250
                        Y: =10
            - ValidationRequestButton_Container:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =2
                  DropShadow: =DropShadow.Regular
                  Height: =50
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Visible: =!IsEmpty(Validators)
                  Width: =200
                  X: =800
                  Y: =250
                Children:
                  - ValidationRequestButton:
                      Control: Classic/Button@2.2.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =RGBA(0, 120, 212, 1)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        FontWeight: =FontWeight.Bold
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =RGBA(255, 255, 255, 1)
                        HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                        OnSelect: |
                          =If(User().Email = "Marjolein.Delplace@police.belgium.eu",Notify("--- Test --- Validatoren: " & First(Validators).DisplayName, NotificationType.Information, 4000));
                          If(
                              CountRows(Validators)>0,
                                  Set(
                                      system,
                                      Patch(
                                          system,
                                          {
                                              isFlowRunning: true
                                          }
                                      )
                                  );
                                  EditForm(SharePointForm);
                                  SubmitForm(SharePointForm);
                                  Set(
                                      validationRequest,
                                      Patch(
                                          validationRequest,
                                          {
                                              isValidationRequested: true
                                          }
                                      )
                                  );
                                  Notify(messages.valRequestSentMsg,NotificationType.Success,3000),
                              Notify(messages.noValidatorsMsg, NotificationType.Error,5000)
                          );
                          Navigate(OverViewScreen,ScreenTransition.Cover)
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        Size: =16
                        Text: ="Send Request"
                        Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
      - ValidationRequestScreen_CancelButton_Container:
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
            - ValidationRequestScreen_CancelButton:
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
                  OnSelect: |-
                    =Navigate(OverViewScreen,ScreenTransition.Cover);
                    Set(
                        validationRequest,
                        Patch(
                            validationRequest,
                            {
                                isValidationRequest: false
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
      - AdminSwitch_3:
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
            - AdminSwitch_Toggle_3:
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
            - AdminSwitch_Label_3:
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
