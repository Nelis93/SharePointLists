Screens:
  OverViewScreen:
    Properties:
      Fill: |+
        =RGBA(255, 255, 255, 1)
      Height: =Max(App.Height,2200)
      LoadingSpinner: =LoadingSpinner.Data
      LoadingSpinnerColor: =RGBA(0, 120, 212, 1)
      OnVisible: |-
        =Set(
            system,
            Patch(
                system,
                {
                    isNotDirectModification: true
                }
            )
        );
        If(Or(profiles.isAdmin,Lower(User().Email) = "isabelle.vanransbeeck@police.belgium.eu"),Notify("Dit is de laatste versie van de app (06/07/26)!",NotificationType.Information,5000));
        If(Or(profiles.isAdmin,Lower(User().Email) = "isabelle.vanransbeeck@police.belgium.eu"),Notify("isValidator: " & profiles.isValidator,NotificationType.Information,5000));
        If(Or(profiles.isAdmin,Lower(User().Email) = "isabelle.vanransbeeck@police.belgium.eu"),Notify("isValidatorScoped: " & profiles.isValidatorScoped,NotificationType.Information,5000));
        If(
            profiles.isAdmin,
                Notify("--- Test --- validationRequested status: " & validationRequest.isValidationRequested,NotificationType.Information, 5000);
                Notify("--- Test --- Flow is already running: " & system.isFlowRunning & " FlowRunning Value: " & SharePointIntegration.Selected.FlowRunning,NotificationType.Information,5000)
        )
      Width: =Max(App.Width, 1500)
    Children:
      - HTML_Container:
          Control: GroupContainer@1.5.0
          Variant: AutoLayout
          Properties:
            DropShadow: =DropShadow.None
            Height: =Parent.Height
            LayoutDirection: =LayoutDirection.Vertical
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Width: =Parent.Width
          Children:
            - Html_Text:
                Control: HtmlViewer@2.1.0
                Properties:
                  AlignInContainer: =AlignInContainer.Start
                  DisabledBorderColor: =RGBA(56, 56, 56, 1)
                  DisplayMode: =DisplayMode.View
                  Font: =Font.'Open Sans'
                  Height: =Parent.Height
                  HtmlText: |-
                    ="<section style='display: flex; flex-direction: column; justify-content: flex-start; align-items: flex-start; font-size: 14px; width: 100%; max-height: 100%; margin-right: 40px; padding: 50px'>" &
                        "<article style='position: relative; display: flex; flex-direction: row; justify-content: flex-start; align-items: center; width: 90%; height: 100px; background-color: #333399; padding: 10px 0px; margin-left: -20px; border-bottom-left-radius: 50px 50px; border-left: 4px solid #D85509'>" &
                            "<img src='https://bpolb.sharepoint.com/sites/Signals/Gedeelde%20documenten/Afbeeldingen/PowerApp_Logos/FedPol.svg' style='position: absolute; right: 0px; top: 0px; height:100px'/>" &
                            "<p style='display: flex; flex-grow: 1; max-width: full; font-size: 30px; padding: 0px 150px 0px 100px; text-align: center; color: white'>" & 
                                If(Language() = "fr-FR",If(Len(SharePointIntegration.Selected.Title_F) > 0,SharePointIntegration.Selected.Title_F,SharePointIntegration.Selected.Titel),If(Len(SharePointIntegration.Selected.Titel) > 0,SharePointIntegration.Selected.Titel,SharePointIntegration.Selected.Title_F))& 
                            "</p>" &
                        "</article>" &
                        "<article style='display:flex; flex-direction: column; justify-content: flex-start; align-items: flex-end; padding-left: 50px; margin-top: 10px; width: 85%'>" &
                            "<div style='display:flex; flex-direction: row; justify-content: flex-end; align-items: center; font-size: 20px; font-weight: bold; height:50px'>" &
                                "<img src='https://bpolb.sharepoint.com/sites/Signals/Gedeelde%20documenten/Afbeeldingen/PowerApp_Logos/Calendar.svg' style='width: 40px; height:40px'/>" &
                                "<p style='margin-left: 10px'>" & 
                                    Concatenate(Day(SharePointIntegration.Selected.Gemaakt),"/",Month(SharePointIntegration.Selected.Gemaakt),"/",Year(SharePointIntegration.Selected.Gemaakt)) & 
                                "</p>" &
                            "</div>" &
                            "<div style='display:" & If(DateDiff(SharePointIntegration.Selected.Gemaakt,SharePointIntegration.Selected.Gewijzigd) > 1,"flex","none") & "; flex-direction: row; justify-content: flex-end; align-items: center; font-size: 20px; font-weight: bold; height:50px'>" &
                                "<img src='https://bpolb.sharepoint.com/sites/Signals/Gedeelde%20documenten/Afbeeldingen/PowerApp_Logos/Revision.svg' style='width: 40px; height:40px'/>" &
                                "<p style='margin-left: 10px'>" &                  
                                    Concatenate(Day(SharePointIntegration.Selected.Gewijzigd),"/",Month(SharePointIntegration.Selected.Gewijzigd),"/",Year(SharePointIntegration.Selected.Gewijzigd)) & 
                                "</p>" &
                            "</div>" &
                            "<div style='display:" & If(Or(Lower(User().Email) = "nelis.eerdekens@police.belgium.eu",SharePointIntegration.Selected.'Gemaakt door'.Email = User().Email, CountRows(Filter(SharePointIntegration.Selected.Editors, Email = User().Email))>0), "flex", "none") & "; flex-direction: row; justify-content: flex-end; align-items: center; font-size: 20px; font-weight: bold; height:50px'>" &
                                "<span style='display: flex; justify-content: center; text-align: center; align-items: center; border-radius: 50px; width: 30px; height: 30px;"&
                                    Switch(SharePointIntegration.Selected.'Goedkeuringsstatus van inhoud', "Approved", "border: 2px solid green;color: green'>✔","Pending",If(SharePointIntegration.Selected.FlowRunning,"'>🕙","color: blue; font-weight: normal; border: 2px solid gray; font-size: 26px; padding: 0px 3px 5px 3px'>📑"),"Denied","color: orange; font-weight: normal; border: 2px solid orange; font-size: 26px; padding: 0px 3px 5px 3px'>⚠","")&
                                "</span>"&
                                "<p style='margin-left: 10px'>" & 
                                        Switch(SharePointIntegration.Selected.'Goedkeuringsstatus van inhoud', "Approved", If(Language()="fr-FR","Approuvé","Goedgekeurd"),"Pending",If(SharePointIntegration.Selected.FlowRunning,If(Language()="fr-FR","En attente","In behandeling"),If(Language()="fr-FR","Brouillion","Klad versie")),"Denied",If(Language()="fr-FR","Révision nécessaire","Revisie nodig"),"") & 
                                "</p>" &
                            "</div>" &
                        "</article>" &
                        "<article style='display:" & If(Or(Len(SharePointIntegration.Selected.Body_F) > 0, Len(SharePointIntegration.Selected.Body_N) > 0), "flex", "none") & "; flex-direction: column; justify-content: flex-start; align-items: flex-start; padding-left: 50px; margin-top: 5px; width: 85%; padding-bottom: 20px; border-bottom: 1px dashed grey'>" &
                            "<div style='display: " & If(IsBlank(SharePointIntegration.Selected.Reference.DisplayName),"none","flex") & "; flex-direction: column; padding: 15px; margin-left: 5px; margin-top: -20px'>" &
                                "<h3 style='display: flex; color: #333399'>" &
                                    If(Language()="fr-FR","Point de contact pour ce signal:","Contactpunt voor dit signaal: ") &
                                "</h3>" &
                                "<div style='display:flex; min-width: 30%; flex-direction: row; justify-content: flex-start; align-items: flex-start; margin-bottom: 20px;'>" &
                                    "<p style='display: flex; align-items: center; border-radius: 50px; padding: 5px 20px 5px 0px; margin-bottom: 3px; height: 30px'>" &
                                        "<span style='display: flex; margin-right: 10px; max-width: 30px; max-height: 30px; border-radius:50px; overflow: hidden'>" & 
                                            "<img src='" & SharePointIntegration.Selected.Reference.Picture & "' style='object-fit: cover; width: 30px; height:30px' alt='👮‍♂️'/>" & 
                                        "</span>" & SharePointIntegration.Selected.Reference.DisplayName & 
                                    "</p>" &
                                "</div>" &
                            "</div>" &
                            "<div style='position: relative; width: 85%; padding: 15px; margin-left: 5px; min-height: 200px'>" &
                                If(Language() = "fr-FR",If(Len(SharePointIntegration.Selected.Body_F) > 100,SharePointIntegration.Selected.Body_F,SharePointIntegration.Selected.Body_N),If(Len(SharePointIntegration.Selected.Body_N) > 100,SharePointIntegration.Selected.Body_N,SharePointIntegration.Selected.Body_F))& 
                            "</div>" &
                            "<div style='display:flex; flex-flow:row nowrap; justify-content: space-evenly; width: 100%;'>" &
                                "<div style='display:" & If(Len(Last(FirstN(SharePointIntegration.Selected.Bijlagen, 1)).Value) > 0, "flex", "none") & "; max-width: 50%; flex-direction: column; justify-content: flex-start; align-items: flex-start;'>" &
                                    "<ul style='display: flex; align-items: flex-start; justify-content: flex-start; flex-direction: column; background-color: white; min-width: 20%; padding: 5px; margin-left: 20px; border-radius: 5px'>" &
                                        Concat(SharePointIntegration.Selected.Bijlagen, "<li style='list-style-type: disc; padding: 5px 20px; display: flex; align-items: center'>"&
                                            "<img src='https://bpolb.sharepoint.com/sites/Signals/Gedeelde%20documenten/Afbeeldingen/PowerApp_Logos/paperclip.svg' style='width: 50px; height:50px'/>" &
                                            "<a href=' " & 
                                        AbsoluteUri & 
                                        "'>" &
                                        DisplayName &
                                        "</a>" &
                                        "</li>") &
                                    "</ul>" &
                                "</div>" &
                            "</div>" &
                        "</article>" &
                        "<article style='display: flex; flex-flow: row wrap; justify-content: flex-start; align-items: flex-start; width: 85%; margin-top: 30px; padding-left: 50px; border-bottom: 1px dashed grey'>" &
                            "<div style='display:" & If(IsBlank(SharePointIntegration.Selected.Signal.Value), "none", "flex") & "; width: 33%; flex-direction: row; justify-content: flex-start; align-items: center; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399'>" &
                                    If(Language()="fr-FR","Signal: ","Signaal: ") &
                                "</h2>" &
                                "<p style='max-width: 80%; border-radius: 50px; background-color: #F3FFE3; padding: 5px 20px 5px 10px; font-size: 14px; margin-left: 20px;'>📣  " &
                                   SharePointIntegration.Selected.Signal.Value & 
                                "</p>" &
                            "</div>" &
                            "<div style='display:" & If(Len(Last(FirstN(SharePointIntegration.Selected.Topic, 1)).Value) > 0, "flex", "none") & "; width: 33%; flex-direction: row; justify-content: flex-start; align-items: flex-start; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399'>" &
                                    If(Language()="fr-FR","Sujet: ","Thema: ") &
                                "</h2>" &
                                "<ul style='display: flex; align-items: flex-start; justify-content: flex-start; flex-direction: column; max-width: 80%; padding: 5px; margin-left: 20px'>" & 
                                Concat(
                                    SharePointIntegration.Selected.Topic, 
                                    "<li style='display: flex; align-items: center; border-radius: 50px; background-color:" & 
                                    If(
                                        IsMatch(Value, "cybercrime", MatchOptions.Contains & MatchOptions.IgnoreCase), "#D88FA3",
                                        IsMatch(Value, "drugs", MatchOptions.Contains & MatchOptions.IgnoreCase), "#6DBA9D",
                                        IsMatch(Value, "organised crime", MatchOptions.Contains & MatchOptions.IgnoreCase), "#8298BC",
                                        IsMatch(Value, "EcoFin", MatchOptions.Contains & MatchOptions.IgnoreCase), "#E8A987",
                                        IsMatch(Value, "Fuphec", MatchOptions.Contains & MatchOptions.IgnoreCase), "#A3B97F",
                                        IsMatch(Value, "property crime", MatchOptions.Contains & MatchOptions.IgnoreCase), "#D27A75",
                                        IsMatch(Value, "humtraf", MatchOptions.Contains & MatchOptions.IgnoreCase), "#9B65C4",
                                        IsMatch(Value, "humsmug", MatchOptions.Contains & MatchOptions.IgnoreCase), "#9B65C4",
                                        IsMatch(Value, "terro", MatchOptions.Contains & MatchOptions.IgnoreCase), "#75A6BA",
                                        IsMatch(Value, "fire arms", MatchOptions.Contains & MatchOptions.IgnoreCase), "#B7A83F",
                                        IsMatch(Value, "road safety", MatchOptions.Contains & MatchOptions.IgnoreCase), "#6D8A95",
                                        IsMatch(Value, "foot", MatchOptions.Contains & MatchOptions.IgnoreCase), "#C29374",
                                        IsMatch(Value, "irregular migration", MatchOptions.Contains & MatchOptions.IgnoreCase), "#9999BD",
                                        IsMatch(Value, "hybrid", MatchOptions.Contains & MatchOptions.IgnoreCase), "#7DB393",
                                        "#FFFFD1") & 
                                    ";padding: 5px 20px 5px 10px; font-size: 14px; margin-bottom: 3px'><span style='margin-right: 10px'>📌</span>" & 
                                    Substitute(Value, "_", "") & 
                                    "</li>"
                                ) & 
                                "</ul>" &

                            "</div>" &
                             "<div style='display:" & If(Len(SharePointIntegration.Selected.SignalLocation.Value) > 0, "flex", "none") & "; width: 33%; flex-direction: row; justify-content: flex-start; align-items: center; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399'>" &
                                    If(Language()="fr-FR","Origine: ","Oorsprong: ") &
                                "</h2>" &
                                "<p style='display: flex; align-items: center; max-width: 80%; margin-left: 20px; font-size: 14px; border-radius: 50px; background-color: #ECEAE4; padding: 5px 10px;'>" &
                                   SharePointIntegration.Selected.SignalLocation.Value & 
                                "</p>" &
                            "</div>" &
                            "<div style='display:" & If(Len(SharePointIntegration.Selected.'Status (1)'.Value) > 0, "flex", "none") & "; width: 33%; flex-direction: row; justify-content: flex-start; align-items: center; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399; flex-wrap: no-wrap'>" &
                                    If(Language()="fr-FR","Statut (1<sup>ière</sup> ligne): ","Status (1<sup>ste</sup> lijn): ") &
                                "</h2>" & 
                                "<p style='display: flex; align-items: center; max-width: 80%; padding: 5px 10px; font-size: 14px; margin-left: 20px; border-radius: 50px; background-color: " & If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"Closed", MatchOptions.Contains & MatchOptions.IgnoreCase), "#d3d3d3", If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"passive", MatchOptions.Contains & MatchOptions.IgnoreCase), "#ADFF2F",If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"active", MatchOptions.Contains & MatchOptions.IgnoreCase), "#FFFF00",If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"Ongoing analysis", MatchOptions.Contains & MatchOptions.IgnoreCase), "#FFA500; color: white",If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"Developing approach", MatchOptions.Contains & MatchOptions.IgnoreCase), "#FF4500","white"))))) & "'>" &
                                 "<span style='margin-right: 10px'>" &
                                        If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"Closed", MatchOptions.Contains & MatchOptions.IgnoreCase), "✖", If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"passive", MatchOptions.Contains & MatchOptions.IgnoreCase), "💬",If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"active", MatchOptions.Contains & MatchOptions.IgnoreCase),"🚩",If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"Ongoing analysis", MatchOptions.Contains & MatchOptions.IgnoreCase), "🔄",If(IsMatch(SharePointIntegration.Selected.'Status (1)'.Value,"Developing approach", MatchOptions.Contains & MatchOptions.IgnoreCase), "⚙",""))))) &
                                    "</span>" &
                                    SharePointIntegration.Selected.'Status (1)'.Value &
                                "</p>" &
                            "</div>" &
                            "<div style='display:" & If(Len(First(SharePointIntegration.Selected.'Status (2)').Value) > 0, "flex", "none") & "; min-width: 33%; padding-right: 15px; flex-direction: row; justify-content: flex-start; align-items: flex-start; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399'>" &
                                    If(Language()="fr-FR","Statut (2<sup>ième</sup> ligne): ","Status (2<sup>e</sup> lijn): ") &
                                "</h2>" &
                                "<ul style='display: flex; align-items: flex-start; justify-content: flex-start; flex-direction: column; max-width: 80%; padding: 5px; margin-left: 20px'>" &
                                    Concat(SharePointIntegration.Selected.'Status (2)', "<li style='display: flex; align-items: center; border-radius: 50px; background-color:" &
                                     If(IsMatch(Value,"Closed", MatchOptions.Contains & MatchOptions.IgnoreCase ),"#d3d3d3", IsMatch(Value,"passive", MatchOptions.Contains & MatchOptions.IgnoreCase ),"#ADFF2F", IsMatch(Value,"active", MatchOptions.Contains & MatchOptions.IgnoreCase ),"#FFFF00", IsMatch(Value,"Ongoing analysis", MatchOptions.Contains & MatchOptions.IgnoreCase ),"#FFA500; color: white", IsMatch(Value,"Developing approach", MatchOptions.Contains & MatchOptions.IgnoreCase ),"#FF4500","#FFFFD1") &
                                     ";padding: 5px 20px 5px 10px; font-size: 14px; margin-bottom: 3px'><span style='margin-right: 10px'>" &
                                        If(IsMatch(Value,"Closed", MatchOptions.Contains & MatchOptions.IgnoreCase), "✖", If(IsMatch(Value,"passive", MatchOptions.Contains & MatchOptions.IgnoreCase), "💬",If(IsMatch(Value,"active", MatchOptions.Contains & MatchOptions.IgnoreCase),"🚩",If(IsMatch(Value,"Ongoing analysis", MatchOptions.Contains & MatchOptions.IgnoreCase), "🔄",If(IsMatch(Value,"Developing approach", MatchOptions.Contains & MatchOptions.IgnoreCase), "⚙",""))))) &
                                    "</span>" & Value & "</li>") &
                                "</ul>" & 
                            "</div>" &
                            "<div style='display:" & If(Len(SharePointIntegration.Selected.'Confidentiality '.Value) > 0, "flex", "none") & "; width: 33%; flex-direction: row; justify-content: flex-start; align-items: center; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399'>" &
                                    If(Language()="fr-FR","Confidentialité: ","Vertrouwelijkheid: ") &
                                "</h2>" &
                                "<p style='display: flex; align-items: center; max-width: 80%; margin-left: 20px; font-size: 14px; border-radius: 50px; background-color: #C4FAF8; padding: 5px 20px 5px 10px;'>" &
                                    "<span style='margin-right: 10px'>" &
                                        If(IsMatch(SharePointIntegration.Selected.'Confidentiality '.Value,"Public", MatchOptions.Contains & MatchOptions.IgnoreCase ),"📣", IsMatch(SharePointIntegration.Selected.'Confidentiality '.Value,"Internal Police", MatchOptions.Contains & MatchOptions.IgnoreCase ),"👮", IsMatch(SharePointIntegration.Selected.'Confidentiality '.Value,"Sensitive", MatchOptions.Contains & MatchOptions.IgnoreCase ),"🔐","⏱") &
                                    "</span>" &
                                   SharePointIntegration.Selected.'Confidentiality '.Value & 
                                "</p>" &
                            "</div>" &
                            "<div style='display:" & If(Len(SharePointIntegration.Selected.Domain.Value) > 0, "flex", "none") & "; width: 33%; flex-direction: row; justify-content: flex-start; align-items: center; margin-bottom: 20px'>" &
                                "<h2 style='color: #333399'>" &
                                    If(Language()="fr-FR","Domaine: ","Domein: ") &
                                "</h2>" &
                                "<p style='display: flex; align-items: center; max-width: 80%; margin-left: 20px; font-size: 14px; border-radius: 50px; background-color: #ECEAE4; padding: 5px 10px;'>" &
                                   SharePointIntegration.Selected.Domain.Value & 
                                "</p>" &
                            "</div>" &
                        "</article>" &
                    "</section>"
                  LayoutMaxHeight: =Parent.Height
                  LayoutMaxWidth: =
                  OnSelect: |-
                    =Set(
                        visibility,
                        Patch(
                            visibility,
                            {
                                prioVis:false,
                                PrintLangVis:false,
                                PrintScaleVis:false,
                                forDirComSendVis: false
                            }
                        )
                    );
                  Size: =11
                  Width: =Parent.Width
      - Navigation:
          Control: GroupContainer@1.5.0
          Variant: AutoLayout
          Properties:
            DropShadow: =DropShadow.None
            Height: =150
            LayoutAlignItems: =LayoutAlignItems.Center
            LayoutDirection: =LayoutDirection.Horizontal
            PaddingBottom: =8
            PaddingLeft: =8
            PaddingRight: =8
            PaddingTop: =8
            RadiusBottomLeft: =0
            RadiusBottomRight: =0
            RadiusTopLeft: =0
            RadiusTopRight: =0
            Width: =1000
            X: =40
            Y: =200
          Children:
            - ValidationRequest:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  AlignInContainer: =AlignInContainer.Start
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =2
                  DropShadow: =DropShadow.None
                  Height: =50
                  LayoutMaxHeight: =200
                  LayoutMaxWidth: =200
                  LayoutMinWidth: =200
                  PaddingBottom: =5
                  PaddingLeft: =5
                  PaddingRight: =5
                  PaddingTop: =5
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  X: =
                  Y: =If(validationRequest.isValidationRequest,200,245)
                Children:
                  - ValidationRequest_Button:
                      Control: Classic/Button@2.2.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =If(validationRequest.isValidationRequested, RGBA(153, 153, 153, 1),RGBA(0, 120, 212, 1))
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =RGBA(255, 255, 255, 1)
                        HoverFill: =If(validationRequest.isValidationRequested, RGBA(153, 153, 153, 1),ColorFade(RGBA(0, 120, 212, 1), -10%))
                        OnSelect: "=Notify(\"--- Test --- Flow is already running: \" & system.isFlowRunning & \" FlowRunning Value: \" & SharePointIntegration.Selected.FlowRunning,NotificationType.Information,5000);\r\nRefresh([@SignaalFt_test]);\r\nIf(\r\n    system.isFlowRunning,\r\n        Notify(messages.flowIsRunningMsg,NotificationType.Information,5000),\r\n    Set(\r\n        visibility,\r\n        Patch(\r\n            visibility,\r\n            {\r\n                prioVis:false,\r\n                PrintLangVis:false,\r\n                PrintScaleVis:false,\r\n                forDirComSendVis: false\r\n            }\r\n        )\r\n    );\r\n    If(\r\n        !validationRequest.isValidationRequested,\r\n            If(\r\n                IsEmpty(Validators),\r\n                    Notify(\"--- TEST--- \" & Concatenate(messages.waitOnDataMsg,\" & isTeamMember: \",profiles.isTeamMember,\" & isRecipient: \",profiles.isRecipient),NotificationType.Information,5000); \r\n                    Notify(\"--- TEST--- \" & Concatenate(\"TeamMembers: \",Concat(SharePointIntegration.Selected.Team,Email,\"; \"),\"; User Email: \",User().Email),NotificationType.Information,5000); \r\n                    Notify(\"--- TEST--- \" & Concatenate(\"Recipients: \",Concat(SharePointIntegration.Selected.Recipients,Email,\"; \"),\"; User Email: \",User().Email),NotificationType.Information,5000);\r\n                    If(\r\n                        And(profiles.isTeamMember, !profiles.isRecipient),\r\n                            With(\r\n                                {\r\n                                    teamMemberMails:\r\n                                        AddColumns(\r\n                                            'Office365Groups'.ListGroupMembers(\r\n                                                Coalesce(\r\n                                                    LookUp(\r\n                                                        'Office365Groups'.ListOwnedGroups().value,\r\n                                                        displayName = \"SignalTest_ValidOne\"\r\n                                                    ).id,\r\n                                                    \"d59e4619-45a8-4375-a20e-15eeec07004b\"\r\n                                                )\r\n                                            ).value,\r\n                                            mailLower,\r\n                                            Lower(mail)\r\n                                        )\r\n                                },\r\n                                ClearCollect(\r\n                                    Validators,\r\n                                    Filter(\r\n                                        SharePointIntegration.Selected.Team,\r\n                                        Lower(Email) in teamMemberMails.mailLower\r\n                                    )\r\n                                )\r\n                            );\r\n                            Notify(\"--- TEST--- \" & \"Your validators are: \" & Concat(Validators,Email,\"; \"),NotificationType.Information,5000);\r\n                    );\r\n                \r\n                    If(\r\n                        profiles.isRecipient,\r\n                            With(\r\n                                {\r\n                                    recipientMails:\r\n                                        AddColumns(\r\n                                            'Office365Groups'.ListGroupMembers(\r\n                                                Coalesce(\r\n                                                    LookUp(\r\n                                                        'Office365Groups'.ListOwnedGroups().value,\r\n                                                        displayName = \"SignalTest_ValidTwo\"\r\n                                                    ).id,\r\n                                                    \"1dd78fb6-16d8-4047-aac4-10a37486da3c\"\r\n                                                )\r\n                                            ).value,\r\n                                            mailLower,\r\n                                            Lower(mail)\r\n                                        )\r\n                                },\r\n                                ClearCollect(\r\n                                    Validators,\r\n                                    Filter(\r\n                                        SharePointIntegration.Selected.Recipients,\r\n                                        Lower(Email) in recipientMails.mailLower\r\n                                    )\r\n                                )\r\n                            );\r\n                            Notify(\"--- TEST--- \" & \"Your validators are: \" & Concat(Validators,Email,\"; \"),NotificationType.Information,5000)\r\n\r\n                    ),\r\n                Navigate(ValidationRequestScreen, ScreenTransition.Cover)    \r\n            ),\r\n        \r\n        Notify(messages.valRequestCheckMsg, NotificationType.Warning,10000)     \r\n    )\r\n)\r\n"
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =If(validationRequest.isValidationRequested, RGBA(153, 153, 153, 1),ColorFade(RGBA(0, 120, 212, 1), -30%))
                        Size: =14
                        Text: ="Request Validation"
                        Visible: |-
                          =Or(
                              And(
                                  Not(SharePointIntegration.Selected.'Goedkeuringsstatus van inhoud'="Approved"),
                                  profiles.isMember,
                                  !profiles.isValidator
                              ),
                              system.toggleAdmin
                          )
                        Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
                        X: =10
                        Y: =5
            - Validate:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  AlignInContainer: =AlignInContainer.Start
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =2
                  DropShadow: =DropShadow.None
                  Height: =50
                  LayoutMaxHeight: =200
                  LayoutMaxWidth: =200
                  LayoutMinWidth: =150
                  PaddingBottom: =5
                  PaddingLeft: =5
                  PaddingRight: =5
                  PaddingTop: =5
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =200
                  X: =
                  Y: =If(validationRequest.isValidationRequest,200,245)
                Children:
                  - Validate_Button:
                      Control: Classic/Button@2.2.0
                      Properties:
                        BorderColor: =RGBA(0, 0, 0, 0)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =1
                        Color: =RGBA(255, 255, 255, 1)
                        DisabledBorderColor: =RGBA(0, 0, 0, 0)
                        Fill: =If(validationRequest.isValidationRequested, RGBA(153, 153, 153, 1),RGBA(0, 120, 212, 1))
                        FocusedBorderThickness: =1
                        Font: =Font.'Segoe UI'
                        Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                        HoverBorderColor: =RGBA(0, 0, 0, 0)
                        HoverColor: =RGBA(255, 255, 255, 1)
                        HoverFill: =If(validationRequest.isValidationRequested, RGBA(153, 153, 153, 1),ColorFade(RGBA(0, 120, 212, 1), -10%))
                        OnSelect: |-
                          =Notify("--- Test --- Flow is already running: " & system.isFlowRunning & " FlowRunning Value: " & SharePointIntegration.Selected.FlowRunning,NotificationType.Information,5000);
                          Refresh([@SignaalFt_test]);
                          If(
                              system.isFlowRunning,
                                  Notify(messages.flowIsRunningMsg,NotificationType.Information,5000),
                              Set(
                                  visibility,
                                  Patch(
                                      visibility,
                                      {
                                          prioVis:false,
                                          PrintLangVis:false,
                                          PrintScaleVis:false,
                                          forDirComSendVis: false
                                      }
                                  )
                              );
                              If(
                                  IsBlank(SharePointIntegration.Selected),
                                      Notify(messages.waitOnDataMsg,NotificationType.Error,5000);
                                      Set(
                                          validation,
                                          Patch(
                                              validation,
                                              {
                                                  isValidation: true
                                              }
                                          )
                                      );
                                  Navigate(ValidationScreen,ScreenTransition.Cover)
                              )
                          )
                        PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                        PressedColor: =RGBA(255, 255, 255, 1)
                        PressedFill: =If(validationRequest.isValidationRequested, RGBA(153, 153, 153, 1),ColorFade(RGBA(0, 120, 212, 1), -30%))
                        Size: =14
                        Text: ="Validate"
                        Visible: =Or(And(Not(SharePointIntegration.Selected.'Goedkeuringsstatus van inhoud'="Approved"),!validation.isValidated,profiles.isValidatorScoped),system.toggleAdmin)
                        Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
                        X: =10
                        Y: =5
            - For DirCom:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  AlignInContainer: =AlignInContainer.Start
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =2
                  DropShadow: =If(visibility.forDirComSendVis,DropShadow.Regular,DropShadow.None)
                  Height: =(Parent.Height - Parent.PaddingTop - Parent.PaddingBottom) * .75
                  LayoutMaxHeight: =200
                  LayoutMaxWidth: =200
                  LayoutMinWidth: =150
                  PaddingLeft: =5
                  PaddingRight: =5
                  PaddingTop: =5
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =150
                  X: =50
                  Y: =180
                Children:
                  - ForDirCom_Options:
                      Control: GroupContainer@1.5.0
                      Variant: AutoLayout
                      Properties:
                        DropShadow: =DropShadow.None
                        Height: =Parent.Height / 2 - Parent.PaddingTop - Parent.PaddingBottom
                        LayoutDirection: =LayoutDirection.Vertical
                        LayoutGap: =5
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        RadiusBottomLeft: =5
                        RadiusBottomRight: =5
                        RadiusTopLeft: =5
                        RadiusTopRight: =5
                        Visible: =visibility.forDirComSendVis
                        Width: =Parent.Width*0.75 - Parent.PaddingLeft - Parent.PaddingRight
                        X: =50
                        Y: =50
                      Children:
                        - ForDirCom_ConfirmButton:
                            Control: Classic/Button@2.2.0
                            Properties:
                              AlignInContainer: =AlignInContainer.Stretch
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(255, 255, 255, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              Fill: =RGBA(54, 176, 75, 1)
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                              LayoutMinHeight: =16
                              LayoutMinWidth: =16
                              OnSelect: |-
                                =Set(
                                    visibility,
                                    Patch(
                                        visibility,
                                        {
                                            forDirComSendVis: false
                                        }
                                    )
                                );
                                Notify(messages.sentForReviewMsg,NotificationType.Success,3000);
                                Set(
                                    validationRequest, 
                                    Patch(
                                        validationRequest,
                                        {
                                            isValidationRequest: true,
                                            validators: Validators,
                                            validationRequestComment: validationRequest.validationRequestCommentForDirCom,
                                            isForDirCom: true
                                        }
                                    )
                                );
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
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              RadiusBottomLeft: =5
                              RadiusBottomRight: =5
                              RadiusTopLeft: =5
                              RadiusTopRight: =5
                              Size: =14
                              Text: ="Send"
                              Width: =Parent.Width
                              Y: =Parent.Height
                  - ForDirComButton_Container:
                      Control: GroupContainer@1.5.0
                      Variant: ManualLayout
                      Properties:
                        BorderColor: =RGBA(51, 51, 153, 1)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =2
                        DropShadow: =DropShadow.None
                        Height: '=50 '
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        RadiusBottomLeft: =10
                        RadiusBottomRight: =10
                        RadiusTopLeft: =10
                        RadiusTopRight: =10
                        Width: =Parent.Width - Self.X
                      Children:
                        - ForDirComButton:
                            Control: Classic/Button@2.2.0
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(255, 255, 255, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              Fill: |-
                                =If(
                                    Or(
                                        validationRequest.isConfirmedForDirCom,
                                        priority.isPrioCalled
                                    ),
                                        ColorFade(RGBA(237, 237, 237, 1), -30%),
                                    RGBA(0, 120, 212, 1)
                                )
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: |-
                                =If(
                                    Or(
                                        validationRequest.isConfirmedForDirCom,
                                        priority.isPrioCalled
                                    ),
                                        ColorFade(RGBA(237, 237, 237, 1), -30%),
                                    ColorFade(RGBA(0, 120, 212, 1), -10%)
                                )
                              OnSelect: |-
                                =Set(
                                    visibility,
                                    Patch(
                                        visibility,
                                        {
                                            prioVis:false,
                                            PrintLangVis:false,
                                            PrintScaleVis:false
                                        }
                                    )
                                );

                                Notify("--- Test --- Flow is already running: " & system.isFlowRunning & " FlowRunning Value: " & SharePointIntegration.Selected.FlowRunning,NotificationType.Information,5000);
                                If(
                                    system.isFlowRunning,
                                        Notify(messages.flowIsRunningMsg,NotificationType.Information,5000);
                                        Refresh([@SignaalFt_test])
                                );
                                If(
                                    validationRequest.isConfirmedForDirCom,
                                        Notify(messages.isAlreadyForDirComMsg,NotificationType.Information,3000),
                                    If(
                                        priority.isPrioCalled,
                                             Notify(messages.isAlreadySeenByDirComMsg,NotificationType.Information,3000),
                                        Set(
                                            visibility,
                                            Patch(
                                                visibility,
                                                {
                                                    forDirComSendVis: !visibility.forDirComSendVis
                                                }
                                            )
                                        )
                                    )
                                )
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: |-
                                =If(
                                    Or(
                                        validationRequest.isConfirmedForDirCom,
                                        priority.isPrioCalled
                                    ),
                                        ColorFade(RGBA(237, 237, 237, 1), -30%),
                                    ColorFade(RGBA(0, 120, 212, 1), -30%)
                                )
                              Size: =14
                              Text: ="For DirCom"
                              Visible: =Or(And(profiles.isValidator,profiles.isRecipient),system.toggleAdmin)
                              Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
                              X: =10
                              Y: =5
            - DirCom:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  AlignInContainer: =AlignInContainer.Start
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  BorderThickness: =2
                  DropShadow: =If(visibility.prioVis,DropShadow.Regular,DropShadow.None)
                  Height: =Parent.Height - Parent.PaddingTop - Parent.PaddingBottom  - If(Or(priority.isPrioDirCom,priority.isNotPrioDirCom),40)
                  LayoutMaxHeight: =200
                  LayoutMaxWidth: =200
                  LayoutMinWidth: =150
                  PaddingLeft: =5
                  PaddingRight: =5
                  PaddingTop: =5
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =150
                  X: =50
                  Y: =180
                Children:
                  - DirCom_Options:
                      Control: GroupContainer@1.5.0
                      Variant: AutoLayout
                      Properties:
                        DropShadow: =DropShadow.None
                        Height: =Parent.Height - Self.Y - Parent.PaddingTop - Parent.PaddingBottom
                        LayoutDirection: =LayoutDirection.Vertical
                        LayoutGap: =5
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        RadiusBottomLeft: =5
                        RadiusBottomRight: =0
                        RadiusTopLeft: =5
                        RadiusTopRight: =0
                        Visible: =visibility.prioVis
                        Width: =Parent.Width - Self.X
                        X: =30
                        Y: =50
                      Children:
                        - DirCom_ConfirmButton:
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
                              Height: =If(priority.isNotPrioDirCom, Parent.Height, Parent.Height/2) - Parent.LayoutGap - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =If(visibility.PrintLangVis, ColorFade(RGBA(237, 237, 237, 1), -30%),ColorFade(RGBA(0, 120, 212, 1), -10%))
                              LayoutMinHeight: =16
                              LayoutMinWidth: =16
                              OnSelect: |+
                                =Set(
                                    visibility,
                                    Patch(
                                        visibility,
                                        {
                                            prioVis: false
                                        }
                                    )
                                );
                                Notify(messages.confirmPrioDirComMsg,NotificationType.Success,3000);
                                Set(
                                    priority,
                                    Patch(
                                        priority,
                                        {
                                            isPrioCall:true,
                                            isPrioConfirmed:true,
                                            prioCallComment: messages.confirmPrioDirComMsg
                                        }
                                    )
                                );
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
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              RadiusBottomLeft: =5
                              RadiusBottomRight: =5
                              RadiusTopLeft: =5
                              RadiusTopRight: =5
                              Size: =14
                              Text: |-
                                ="PRIO 👍"
                              Visible: =!priority.isPrioDirCom
                              Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight
                              Y: =Parent.Height / 4
                        - DirCom_DenyButton:
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
                              Height: =If(priority.isPrioDirCom, Parent.Height, Parent.Height/2) - Parent.LayoutGap - Parent.PaddingBottom
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                              LayoutMinHeight: =16
                              LayoutMinWidth: =16
                              OnSelect: |-
                                =Set(
                                    visibility,
                                    Patch(
                                        visibility,
                                        {
                                            prioVis: false
                                        }
                                    )
                                );
                                Notify(messages.confirmNonPrioDirComMsg,NotificationType.Success,3000);
                                Set(
                                    system,
                                    Patch(
                                        system,
                                        {
                                            isFlowRunning: true
                                        }
                                    )
                                );
                                Set(
                                    priority,
                                    Patch(
                                        priority,
                                        {
                                            isPrioCall:true,
                                            isPrioConfirmed:false,
                                            prioCallComment: messages.confirmNonPrioDirComMsg
                                        }
                                    )
                                );
                                EditForm(SharePointForm);
                                SubmitForm(SharePointForm);
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                              RadiusBottomLeft: =5
                              RadiusBottomRight: =5
                              RadiusTopLeft: =5
                              RadiusTopRight: =5
                              Size: =14
                              Text: |-
                                ="NO PRIO 👎"
                              Visible: =!priority.isNotPrioDirCom
                              Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight
                              Y: =Parent.Height / 4 *3
                  - DirComButton_Container:
                      Control: GroupContainer@1.5.0
                      Variant: ManualLayout
                      Properties:
                        BorderColor: =RGBA(51, 51, 153, 1)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =2
                        DropShadow: =DropShadow.None
                        Height: '=50 '
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        RadiusBottomLeft: =10
                        RadiusBottomRight: =10
                        RadiusTopLeft: =10
                        RadiusTopRight: =10
                        Width: =Parent.Width - Self.X
                      Children:
                        - DirComButton:
                            Control: Classic/Button@2.2.0
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(255, 255, 255, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              Fill: =If( visibility.prioVis, ColorFade(RGBA(237, 237, 237, 1), -30%),If(Or(Or(CountRows(Filter(Status2, Value = "Confirmed by DirCom"))>0,CountRows(Filter(Status2, Value = "Noticed by DirCom"))>0),CountRows(Filter(SharePointIntegration.Selected.'Status (2)', Value = "For DirCom"))=0),ColorFade(RGBA(237, 237, 237, 1), -30%),RGBA(0, 120, 212, 1)))
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =If( visibility.prioVis, ColorFade(RGBA(237, 237, 237, 1), -30%),If(Or(Or(CountRows(Filter(Status2, Value = "Confirmed by DirCom"))>0,CountRows(Filter(Status2, Value = "Noticed by DirCom"))>0),CountRows(Filter(SharePointIntegration.Selected.'Status (2)', Value = "For DirCom"))=0),ColorFade(RGBA(237, 237, 237, 1), -30%),ColorFade(RGBA(0, 120, 212, 1), -10%)))
                              OnSelect: |-
                                =Refresh([@SignaalFt_test]);
                                If(
                                    system.isFlowRunning,
                                        Notify(messages.flowIsRunningMsg,NotificationType.Information,5000),
                                    Set(
                                        visibility,
                                        Patch(
                                            visibility,
                                            {
                                                PrintLangVis:false,
                                                PrintScaleVis:false,
                                                forDirComSendVis: false
                                            }
                                        )
                                    );
                                    Set(
                                        priority,
                                        Patch(
                                            priority,
                                            {
                                                isPrioDirCom: Not(IsBlank(LookUp(SharePointIntegration.Selected.'Status (2)',Value = "Confirmed by DirCom"))),
                                                isNotPrioDirCom: Not(IsBlank(LookUp(SharePointIntegration.Selected.'Status (2)',Value = "Noticed by DirCom")))
                                            }
                                        )
                                    );
                                    If(
                                        And(
                                            !visibility.prioVis,
                                            priority.isPrioDirCom
                                        ),
                                            Notify(messages.isPrioDirComMsg,NotificationType.Information,3000)
                                    );
                                    If(
                                        And(
                                            !visibility.prioVis,
                                            priority.isNotPrioDirCom
                                        ),
                                            Notify(messages.isNotPrioDirComMsg,NotificationType.Information,3000)
                                    );
                                    If(
                                        And(
                                            !validationRequest.isForDirCom,
                                            !priority.isPrioDirCom,
                                            !priority.isNotPrioDirCom
                                        ),
                                            Notify(messages.isNotYetForDirComMsg,NotificationType.Error,3000),
                                        Set(
                                            visibility,
                                            Patch(
                                                visibility,
                                                {
                                                    prioVis:!visibility.prioVis
                                                }
                                            )
                                        )
                                    );
                                    If(profiles.isAdmin,Notify("--- Test --- Flow is already running: " & system.isFlowRunning & " FlowRunning Value: " & SharePointIntegration.Selected.FlowRunning,NotificationType.Information,5000));
                                );
                              PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =If( visibility.prioVis, ColorFade(RGBA(237, 237, 237, 1), -30%),If(Or(Or(CountRows(Filter(Status2, Value = "Confirmed by DirCom"))>0,CountRows(Filter(Status2, Value = "Noticed by DirCom"))>0),CountRows(Filter(SharePointIntegration.Selected.'Status (2)', Value = "For DirCom"))=0),ColorFade(RGBA(237, 237, 237, 1), -30%),ColorFade(RGBA(0, 120, 212, 1), -30%)))
                              Size: =14
                              Text: ="DirCom"
                              Visible: =Or(profiles.isDirComMember,profiles.isAdmin)
                              Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
                              X: =10
                              Y: =5
            - Bundle:
                Control: GroupContainer@1.5.0
                Variant: ManualLayout
                Properties:
                  AlignInContainer: =AlignInContainer.Start
                  BorderColor: =RGBA(51, 51, 153, 1)
                  BorderStyle: =BorderStyle.None
                  DropShadow: =If(visibility.PrintScaleVis,DropShadow.Regular,DropShadow.None)
                  Height: =Parent.Height - Parent.PaddingTop - Parent.PaddingBottom
                  RadiusBottomLeft: =10
                  RadiusBottomRight: =10
                  RadiusTopLeft: =10
                  RadiusTopRight: =10
                  Width: =150
                  X: =50
                  Y: =180
                Children:
                  - BundleContainer_Define:
                      Control: GroupContainer@1.5.0
                      Variant: AutoLayout
                      Properties:
                        DropShadow: =DropShadow.None
                        Height: =Parent.Height - Self.Y - Parent.PaddingBottom - Parent.PaddingTop
                        LayoutAlignItems: =LayoutAlignItems.Center
                        LayoutDirection: =LayoutDirection.Horizontal
                        PaddingTop: =
                        RadiusBottomLeft: =2
                        RadiusBottomRight: =2
                        RadiusTopLeft: =2
                        RadiusTopRight: =2
                        Width: =Parent.Width - Self.X
                        X: =50
                        Y: =50
                      Children:
                        - BundleContainer_Define_Scale:
                            Control: GroupContainer@1.5.0
                            Variant: AutoLayout
                            Properties:
                              AlignInContainer: =AlignInContainer.Start
                              DropShadow: =DropShadow.None
                              Height: =Parent.Height - Parent.PaddingTop - Parent.PaddingBottom
                              LayoutDirection: =LayoutDirection.Vertical
                              LayoutGap: =5
                              LayoutMaxHeight: =
                              LayoutMaxWidth: =Parent.Width*0.70
                              LayoutMinHeight: =
                              LayoutMinWidth: =
                              PaddingBottom: =5
                              PaddingLeft: =5
                              PaddingRight: =5
                              PaddingTop: =5
                              RadiusBottomLeft: =5
                              RadiusBottomRight: =0
                              RadiusTopLeft: =5
                              RadiusTopRight: =0
                              Visible: =visibility.PrintScaleVis
                              Width: =Parent.Width*0.75 - Parent.PaddingLeft - Parent.PaddingRight
                              X: =Parent.X
                            Children:
                              - Select_ThisSignal:
                                  Control: Classic/Button@2.2.0
                                  Properties:
                                    BorderColor: =RGBA(0, 0, 0, 0)
                                    BorderStyle: =BorderStyle.None
                                    BorderThickness: =1
                                    Color: =RGBA(255, 255, 255, 1)
                                    DisabledBorderColor: =RGBA(0, 0, 0, 0)
                                    Fill: =If(visibility.PrintLangVis, ColorFade(RGBA(237, 237, 237, 1), -30%),RGBA(0, 120, 212, 1))
                                    FocusedBorderThickness: =1
                                    Font: =Font.'Segoe UI'
                                    Height: =Parent.Height/2 - Parent.LayoutGap - Parent.PaddingTop
                                    HoverBorderColor: =RGBA(0, 0, 0, 0)
                                    HoverColor: =RGBA(255, 255, 255, 1)
                                    HoverFill: =If(visibility.PrintLangVis, ColorFade(RGBA(237, 237, 237, 1), -30%),ColorFade(RGBA(0, 120, 212, 1), -10%))
                                    LayoutMinHeight: =16
                                    LayoutMinWidth: =16
                                    OnSelect: |-
                                      =Set(
                                          visibility,
                                          Patch(
                                              visibility,
                                              {
                                                  PrintLangVis:true
                                              }
                                          )
                                      );
                                    PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                                    PressedColor: =RGBA(255, 255, 255, 1)
                                    PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    RadiusBottomLeft: =5
                                    RadiusBottomRight: =5
                                    RadiusTopLeft: =5
                                    RadiusTopRight: =5
                                    Size: =14
                                    Text: =If(Language()  = "fr-FR", "Ce signal", "Dit signaal")
                                    Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight - Parent.LayoutGap
                                    Y: =Parent.Height / 4
                              - Select_Multiple:
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
                                    Height: =Parent.Height/2 - Parent.LayoutGap - Parent.PaddingBottom
                                    HoverBorderColor: =RGBA(0, 0, 0, 0)
                                    HoverColor: =RGBA(255, 255, 255, 1)
                                    HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                                    LayoutMinHeight: =16
                                    LayoutMinWidth: =16
                                    OnSelect: |-
                                      =Navigate(BundleScreen,ScreenTransition.Cover);
                                      Set(
                                          visibility,
                                          Patch(
                                              visibility,
                                              {
                                                  PrintLangVis:false,
                                                  PrintScaleVis:false
                                              }
                                          )
                                      );
                                    PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                                    PressedColor: =RGBA(255, 255, 255, 1)
                                    PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    RadiusBottomLeft: =5
                                    RadiusBottomRight: =5
                                    RadiusTopLeft: =5
                                    RadiusTopRight: =5
                                    Size: =14
                                    Text: =If(Language()  = "fr-FR", "Plusieurs", "Kies signalen")
                                    Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight - Parent.LayoutGap
                                    Y: =Parent.Height / 4 *3
                        - BundleContainer_Define_Lang:
                            Control: GroupContainer@1.5.0
                            Variant: AutoLayout
                            Properties:
                              AlignInContainer: =AlignInContainer.Start
                              DropShadow: =DropShadow.None
                              Height: =Parent.Height - Parent.PaddingTop - Parent.PaddingBottom
                              LayoutDirection: =LayoutDirection.Vertical
                              LayoutGap: =5
                              LayoutMaxHeight: =
                              LayoutMaxWidth: =Parent.Width * 0.30
                              LayoutMinHeight: =
                              LayoutMinWidth: =
                              PaddingBottom: =5
                              PaddingLeft: =5
                              PaddingRight: =5
                              PaddingTop: =5
                              RadiusBottomLeft: =0
                              RadiusBottomRight: =0
                              RadiusTopLeft: =0
                              RadiusTopRight: =0
                              Visible: =visibility.PrintLangVis
                              Width: =Parent.Width*0.25 - Parent.PaddingLeft - Parent.PaddingRight
                            Children:
                              - Select_FR:
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
                                    Height: =Parent.Height/2 - Parent.LayoutGap  - Parent.PaddingTop
                                    HoverBorderColor: =RGBA(0, 0, 0, 0)
                                    HoverColor: =RGBA(255, 255, 255, 1)
                                    HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                                    LayoutMinHeight: =16
                                    LayoutMinWidth: =16
                                    OnSelect: "=Set(\n    visibility,\n    Patch(\n        visibility,\n        {\n            PrintLangVis:false,\n            PrintScaleVis:false\n        }\n    )\n);\nSet(PrintLanguage,false);\n'PrintFlow_Test'.Run(\n            JSON(\n                {\n                    user: User(),\n                    language: Language(),\n                    signal: {\n                        body: \n                            ShowColumns(\n                            SharePointIntegration.Selected,\n                            'Id (ID)',\n                            Titel,\n                            Gemaakt,\n                            Gewijzigd,\n                            Topic,\n                            'Gemaakt door',\n                            'Gewijzigd door',\n                            Team,\n                            Recipients,\n                            Notify,\n                            Editors,\n                            Title_F,\n                            'Validated (System)',\n                            'Status (1)',\n                            'Status (2)',\n                            'Confidentiality '\n                        ),\n                        isNewSignal : Value(SharePointForm.Mode) = FormMode.New,\n                        isTopicChanged: Coalesce(changes.topicChange,false),\n                        isConfidentChanged: Coalesce(changes.confiChange,false),\n                        isEditorsChanged: Coalesce(changes.editorsChange,false)\n                        \n                    },\n                    signalUpdate: {\n                        body: \n                            ShowColumns(\n                            SharePointForm.Updates,\n                            Titel,\n                            Title_F,\n                            Topic,\n                            Editors,\n                            'Status (2)',\n                            'Confidentiality '\n                        )\n                    },\n                    validationRequest: {\n                        isValidationRequest: false,\n                        validators: Coalesce(Validators,[]),\n                        validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\n                    },\n                    validation: {\n                        isValidation: false,\n                        isDirectValidation: false,\n                        validationComment: \"No Comment\",\n                        isApproved: false\n                    },\n                    dirCom: {\n                        isForDirCom: false\n                    },\n                    priority: {\n                        isPrioCall: false,\n                        isConfirmed: false,\n                        prioCallComment: \"No Comment\"\n                    },\n                    print: {\n                        isPrint: true,\n                        printLanguage: Coalesce(PrintLanguage,false),\n                        body: \n                            ShowColumns(\n                            colPrintItems,\n                            'Id (ID)',\n                            Titel,\n                            Title_F,\n                            Body_N,\n                            Body_F\n                        )\n                    }\n                },\n                JSONFormat.IncludeBinaryData\n            )\n        );\n'BackEndLogFlow'.Run(\n            JSON(\n                {\n                    user: User(),\n                    language: Language(),\n                    site: \"testbeeldsubc\",\n                    list: \"SignaalFt_test\",\n                    isNewItem: Value(SharePointForm.Mode) = FormMode.New,\n                    signals: {\n                        signal: {\n                            body: \n                                ShowColumns(\n                                SharePointIntegration.Selected,\n                                'Id (ID)',\n                                Titel,\n                                Title_F,\n                                Topic,\n                                'Status (1)',\n                                'Status (2)',\n                                Domain,\n                                Source,\n                                Signal,\n                                SignalLocation,\n                                Reference,                                \n                                Gemaakt,\n                                Gewijzigd,\n                                'Gemaakt door',\n                                'Gewijzigd door',\n                                Team,\n                                Recipients,\n                                Notify,\n                                Editors,\n                                'Validated (System)',\n                                'Confidentiality ',\n                                'Koppeling naar item'\n                            ),\n                            isNewSignal : Value(SharePointForm.Mode) = FormMode.New,\n                            isTopicChanged: Coalesce(changes.topicChange,false),\n                            isConfidentChanged: Coalesce(changes.confiChange,false),\n                            isEditorsChanged: Coalesce(changes.editorsChange,false)\n                            \n                        },\n                        validationRequest: {\n                            isValidationRequest: Coalesce(validationRequest.isValidationRequest,false),\n                            validators: Validators,\n                            validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\n                        },\n                        validation: {\n                            isValidation: Coalesce(validation.isDirectValidation,false),\n                            isDirectValidation: Coalesce(validation.isDirectValidation,false),\n                            validationComment: If(validation.isDirectValidation,validation.directValidationComment,\"No Comment\"),\n                            isApproved: Coalesce(validation.isDirectValidation,false)\n                        },\n                        dirCom: {},\n                        priority: {},\n                        print: {\n                            isPrint: true,\n                            printLanguage: Coalesce(PrintLanguage,false),\n                            body: \n                                ShowColumns(\n                                colPrintItems,\n                                'Id (ID)',\n                                Titel,\n                                Title_F,\n                                Body_N,\n                                Body_F\n                            )\n                        }\n                    },\n                    strategicAnalysisProducts: {},\n                    barrierModels: {},\n                    partners: {}\n                },\n                JSONFormat.IncludeBinaryData\n            )\n        );\nClear(colPrintItems);\nNotify(messages.fileSentMsg, NotificationType.Success)"
                                    PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                                    PressedColor: =RGBA(255, 255, 255, 1)
                                    PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    RadiusBottomLeft: =5
                                    RadiusBottomRight: =5
                                    RadiusTopLeft: =5
                                    RadiusTopRight: =5
                                    Size: =14
                                    Text: ="FR"
                                    Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight - Parent.LayoutGap
                              - Select_NL:
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
                                    Height: =Parent.Height/2 - Parent.LayoutGap  - Parent.PaddingBottom
                                    HoverBorderColor: =RGBA(0, 0, 0, 0)
                                    HoverColor: =RGBA(255, 255, 255, 1)
                                    HoverFill: =ColorFade(RGBA(0, 120, 212, 1), -10%)
                                    LayoutMinHeight: =16
                                    LayoutMinWidth: =16
                                    OnSelect: "=Set(\n    visibility,\n    Patch(\n        visibility,\n        {\n            PrintLangVis:false,\n            PrintScaleVis:false\n        }\n    )\n);\nSet(PrintLanguage,true);\n'PrintFlow_Test'.Run(\n            JSON(\n                {\n                    user: User(),\n                    language: Language(),\n                    signal: {\n                        body: \n                            ShowColumns(\n                            SharePointIntegration.Selected,\n                            'Id (ID)',\n                            Titel,\n                            Gemaakt,\n                            Gewijzigd,\n                            Topic,\n                            'Gemaakt door',\n                            'Gewijzigd door',\n                            Team,\n                            Recipients,\n                            Notify,\n                            Editors,\n                            Title_F,\n                            'Validated (System)',\n                            'Status (1)',\n                            'Status (2)',\n                            'Confidentiality '\n                        ),\n                        isNewSignal : Value(SharePointForm.Mode) = FormMode.New,\n                        isTopicChanged: Coalesce(changes.topicChange,false),\n                        isConfidentChanged: Coalesce(changes.confiChange,false),\n                        isEditorsChanged: Coalesce(changes.editorsChange,false)\n                        \n                    },\n                    signalUpdate: {\n                        body: \n                            ShowColumns(\n                            SharePointForm.Updates,\n                            Titel,\n                            Title_F,\n                            Topic,\n                            Editors,\n                            'Status (2)',\n                            'Confidentiality '\n                        )\n                    },\n                    validationRequest: {\n                        isValidationRequest: false,\n                        validators: Coalesce(Validators,[]),\n                        validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\n                    },\n                    validation: {\n                        isValidation: false,\n                        isDirectValidation: false,\n                        validationComment: \"No Comment\",\n                        isApproved: false\n                    },\n                    dirCom: {\n                        isForDirCom: false\n                    },\n                    priority: {\n                        isPrioCall: false,\n                        isConfirmed: false,\n                        prioCallComment: \"No Comment\"\n                    },\n                    print: {\n                        isPrint: true,\n                        printLanguage: Coalesce(PrintLanguage,false),\n                        body: \n                            ShowColumns(\n                            colPrintItems,\n                            'Id (ID)',\n                            Titel,\n                            Title_F,\n                            Body_N,\n                            Body_F\n                        )\n                    }\n                },\n                JSONFormat.IncludeBinaryData\n            )\n        );\n'BackEndLogFlow'.Run(\n            JSON(\n                {\n                    user: User(),\n                    language: Language(),\n                    site: \"testbeeldsubc\",\n                    list: \"SignaalFt_test\",\n                    isNewItem: Value(SharePointForm.Mode) = FormMode.New,\n                    signals: {\n                        signal: {\n                            body: \n                                ShowColumns(\n                                SharePointIntegration.Selected,\n                                'Id (ID)',\n                                Titel,\n                                Title_F,\n                                Topic,\n                                'Status (1)',\n                                'Status (2)',\n                                Domain,\n                                Source,\n                                Signal,\n                                SignalLocation,\n                                Reference,                                \n                                Gemaakt,\n                                Gewijzigd,\n                                'Gemaakt door',\n                                'Gewijzigd door',\n                                Team,\n                                Recipients,\n                                Notify,\n                                Editors,\n                                'Validated (System)',\n                                'Confidentiality ',\n                                'Koppeling naar item'\n                            ),\n                            isNewSignal : Value(SharePointForm.Mode) = FormMode.New,\n                            isTopicChanged: Coalesce(changes.topicChange,false),\n                            isConfidentChanged: Coalesce(changes.confiChange,false),\n                            isEditorsChanged: Coalesce(changes.editorsChange,false)\n                            \n                        },\n                        validationRequest: {\n                            isValidationRequest: Coalesce(validationRequest.isValidationRequest,false),\n                            validators: Validators,\n                            validationRequestComment: Coalesce(validationRequest.validationRequestComment,\"No Comment\")\n                        },\n                        validation: {\n                            isValidation: Coalesce(validation.isDirectValidation,false),\n                            isDirectValidation: Coalesce(validation.isDirectValidation,false),\n                            validationComment: If(validation.isDirectValidation,validation.directValidationComment,\"No Comment\"),\n                            isApproved: Coalesce(validation.isDirectValidation,false)\n                        },\n                        dirCom: {},\n                        priority: {},\n                        print: {\n                            isPrint: true,\n                            printLanguage: Coalesce(PrintLanguage,false),\n                            body: \n                                ShowColumns(\n                                colPrintItems,\n                                'Id (ID)',\n                                Titel,\n                                Title_F,\n                                Body_N,\n                                Body_F\n                            )\n                        }\n                    },\n                    strategicAnalysisProducts: {},\n                    barrierModels: {},\n                    partners: {}\n                },\n                JSONFormat.IncludeBinaryData\n            )\n        );\nClear(colPrintItems);\nNotify(messages.fileSentMsg, NotificationType.Success)"
                                    PressedBorderColor: =ColorFade(RGBA(0, 120, 212, 1), -50%)
                                    PressedColor: =RGBA(255, 255, 255, 1)
                                    PressedFill: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                                    RadiusBottomLeft: =5
                                    RadiusBottomRight: =5
                                    RadiusTopLeft: =5
                                    RadiusTopRight: =5
                                    Size: =14
                                    Text: ="NL"
                                    Width: =Parent.Width - Parent.PaddingLeft - Parent.PaddingRight - Parent.LayoutGap
                  - BundleButton_Container:
                      Control: GroupContainer@1.5.0
                      Variant: ManualLayout
                      Properties:
                        BorderColor: =RGBA(51, 51, 153, 1)
                        BorderStyle: =BorderStyle.None
                        BorderThickness: =2
                        DropShadow: =DropShadow.None
                        Height: =50 - Parent.PaddingBottom - Parent.PaddingTop
                        PaddingBottom: =5
                        PaddingLeft: =5
                        PaddingRight: =5
                        PaddingTop: =5
                        RadiusBottomLeft: =10
                        RadiusBottomRight: =10
                        RadiusTopLeft: =10
                        RadiusTopRight: =10
                        Width: =Parent.Width - Self.X
                        X: =5
                      Children:
                        - BundleButton:
                            Control: Classic/Button@2.2.0
                            Properties:
                              BorderColor: =RGBA(0, 0, 0, 0)
                              BorderStyle: =BorderStyle.None
                              BorderThickness: =1
                              Color: =RGBA(255, 255, 255, 1)
                              DisabledBorderColor: =RGBA(0, 0, 0, 0)
                              Fill: =If(visibility.PrintScaleVis, ColorFade(RGBA(237, 237, 237, 1), -30%),RGBA(203, 102, 102, 1))
                              FocusedBorderThickness: =1
                              Font: =Font.'Segoe UI'
                              Height: =Parent.Height - Parent.PaddingBottom - Parent.PaddingTop
                              HoverBorderColor: =RGBA(0, 0, 0, 0)
                              HoverColor: =RGBA(255, 255, 255, 1)
                              HoverFill: =ColorFade(RGBA(203, 102, 102, 1), -10%)
                              OnSelect: |-
                                =If(
                                    CountRows(colPrintItems)>0,
                                        If(
                                            visibility.PrintScaleVis,
                                                Set(
                                                    visibility,
                                                    Patch(
                                                        visibility,
                                                        {
                                                            PrintLangVis:false,
                                                            PrintScaleVis:false
                                                        }
                                                    )
                                                ),
                                            Set(
                                                visibility,
                                                Patch(
                                                    visibility,
                                                    {
                                                        PrintScaleVis:true
                                                    }
                                                )
                                            );
                                            Notify(messages.fileReadyMsg, NotificationType.Success,2500)
                                        ),
                                        Notify(messages.waitOnDataMsg,NotificationType.Error,5000);
                                        Collect(colPrintItems,SharePointIntegration.Selected);
                                );
                                Set(
                                    visibility,
                                    Patch(
                                        visibility,
                                        {
                                            prioVis:false,
                                            forDirComSendVis: false
                                        }
                                    )
                                );
                              PressedBorderColor: =ColorFade(RGBA(203, 102, 102, 1), -50%)
                              PressedColor: =RGBA(255, 255, 255, 1)
                              PressedFill: =ColorFade(RGBA(203, 102, 102, 1), -30%)
                              Size: =14
                              Text: ="Export signals"
                              Width: =Parent.Width - Self.X - Parent.PaddingLeft - Parent.PaddingRight
                              X: =10
                              Y: =5
      - EditButton_Container:
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
            Visible: =SharePointForm.Mode = FormMode.Edit
            Width: =50
            X: =OverViewScreen.Width - 200
            Y: =75
          Children:
            - EditButton:
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
                  Icon: =Icon.Edit
                  OnSelect: =Navigate(FormScreen,ScreenTransition.Cover);
                  PaddingBottom: =10
                  PaddingLeft: =10
                  PaddingRight: =10
                  PaddingTop: =10
                  PressedBorderColor: =RGBA(0, 0, 0, 0)
                  PressedColor: =ColorFade(RGBA(0, 120, 212, 1), -30%)
                  PressedFill: =RGBA(0, 0, 0, 0)
                  Tooltip: =
                  Width: =50
      - AdminSwitch_1:
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
            - AdminSwitch_Toggle_1:
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
            - AdminSwitch_Label_1:
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
