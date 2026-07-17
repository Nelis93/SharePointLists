"<section style='display: flex; flex-direction: column; justify-content: flex-start; align-items: flex-start; font-size: 14px; width: 100%; max-height: 100%; margin-right: 40px; padding: 50px'>" &
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