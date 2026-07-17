Screens:
  ValidationScreen:
    Properties:
      Fill: =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height, 2200)
      LoadingSpinnerColor: =RGBA(0, 120, 212, 1)
      Width: =Max(App.Width, 1500)
    Children:
      - Validation_Container:
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
            - Validation_Instructions:
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
                  Text: ="U kan het signaal hier beoordelen. Eens gevalideerd is het voor iedereen zichtbaar (all GPI). In geval van een negatief oordeel vragen we een boodschap mee te geven voor de auteur(s)."
                  Width: =1300
                  X: =Parent.Width/2 - Self.Width/2
                  Y: =50
            - ValidationOptions_Container:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =2
                  DropShadow: =DropShadow.Regular
                  Height: =150
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =Parent.Width - Self.X*2
                  X: =400
                  Y: =250
                Children:
                  - ValidationButtons_Container:
                      Control: GroupContainer@1.5.0
                      Variant: AutoLayout
                      Properties:
                        DropShadow: =DropShadow.None
                        Height: =Parent.Height / 2
                        LayoutAlignItems: =LayoutAlignItems.Center
                        LayoutDirection: =LayoutDirection.Horizontal
                        LayoutGap: =10
                        PaddingBottom: =8
                        PaddingLeft: =8
                        PaddingRight: =8
                        PaddingTop: =8
                        RadiusBottomLeft: =0
                        RadiusBottomRight: =0
                        RadiusTopLeft: =0
                        RadiusTopRight: =0
                        Width: =Parent.Width
                        Y: =Parent.Height / 2
                      Children:
                        - ValidationButton_Approve:
                            Control: Classic/Button@2.2.0
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(255, 255, 255, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              Fill: =RGBA(54, 176, 75, 1)
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              FontWeight: =FontWeight.Bold
                              Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                              OnSelect: |-
                                =Refresh(SignaalFt_test);
                                If(
                                    system.isFlowRunning,
                                        Notify(messages.flowIsRunningMsg,NotificationType.Information,5000),
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
                                    Notify(messages.validatedConfirmedMsg,NotificationType.Success,3000);
                                    Navigate(OverViewScreen,ScreenTransition.Cover);
                                    Set(
                                        validation,
                                        Patch(
                                            validation,
                                            {
                                                isValidated: true
                                            }
                                        )
                                    )
                                )
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              Size: =16
                              Text: ="Signaal goedkeuren"
                              Width: =(Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight) / 2
                        - ValidationButton_Reject:
                            Control: Classic/Button@2.2.0
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(255, 255, 255, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              Fill: =RGBA(255, 0, 0, 1)
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              FontWeight: =FontWeight.Bold
                              Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                              OnSelect: |-
                                =Refresh(SignaalFt_test);
                                If(
                                    system.isFlowRunning,
                                        Notify(messages.flowIsRunningMsg,NotificationType.Information,5000),
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
                                    Notify(messages.validatedDeniedMsg,NotificationType.Success,3000);
                                    Navigate(OverViewScreen,ScreenTransition.Cover);
                                    Set(
                                        validation,
                                        Patch(
                                            validation,
                                            {
                                                isValidated: true
                                            }
                                        )
                                    )
                                )
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              Size: =16
                              Text: ="Signaal afkeuren"
                              Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
                  - ValidationOptions_Label:
                      Control: Label@2.5.1
                      Properties:
                        Align: =Align.Center
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
                        Text: ="Beoordeling"
                        Width: =Parent.Width
                        Y: =10
            - Validation_UserComment:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  DropShadow: =DropShadow.Regular
                  Height: =300
                  PaddingBottom: =10
                  PaddingLeft: =10
                  PaddingRight: =10
                  PaddingTop: =10
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =Parent.Width - Self.X*2
                  X: =250
                  Y: =450
                Children:
                  - Validation_UserComment_Label:
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
                        PaddingLeft: =15
                        Size: =16
                        Text: ="Comment"
                        Width: =(Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight)
                  - Validation_UserComment_Input:
                      Control: Classic/TextInput@2.3.2
                      Properties:
                        BorderColor: =RGBA(166, 166, 166, 1)
                        BorderThickness: =1
                        Color: =RGBA(51, 51, 51, 1)
                        Default: =
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Self.Y
                        HintText: ="Geef een boodschap mee aan de auteurs(s)"
                        HoverBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                        HoverColor: =RGBA(51, 51, 51, 1)
                        HoverFill: =RGBA(255, 255, 255, 1)
                        Mode: =TextMode.MultiLine
                        OnChange: |-
                          =Set(
                              validation,
                              Patch(
                                  validation,
                                  {
                                      validatorCommentText: Validation_UserComment_Input.Text
                                  }
                              )
                          )
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
                        Width: =Parent.Width
                        Y: =50
      - ValidationScreen_CancelButton_Container:
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
            - ValidationScreen_CancelButton:
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
                        validation,
                        Patch(
                            validation,
                            {
                                isValidation: false
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
      - AdminSwitch_4:
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
            - AdminSwitch_Toggle_4:
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
            - AdminSwitch_Label_4:
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
