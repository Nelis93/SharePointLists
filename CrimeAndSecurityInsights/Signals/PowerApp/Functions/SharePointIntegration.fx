##### SharePointIntegration ######
##### onView:
ViewForm(SharePointForm1);
Set(userForm, false);
Set(visitorForm, true);
Set(printForm, false);
ClearCollect(colPrintItems,SharePointIntegration.Selected); 
Set(Topics, SharePointIntegration.Selected.Topic);
Set(PrintLanguage, false); 
Set(PrintScaleVis,false);
Set(PrintLangVis,false); 
Set(PrintSelectedVis,true);
##### onCancel:
ResetForm(SharePointForm1);
Clear(colPrintItems);
##### onSave:
Set(StopRunBoolean, false);
SubmitForm(SharePointForm1)
##### onNew:
NewForm(SharePointForm1); 
Set(userForm, true); 
Set(visitorForm, false); 
Set(BodyF, false); 
Set(BodyN, false); 
Set(printForm, false)
##### OnEdit:
ClearCollect(colPrintItems,SharePointIntegration.Selected); 
Set(isAdmin, Or(User().Email = "Nelis.Eerdekens@police.belgium.eu",User().Email = "Paul.Wouters@police.belgium.eu",User().Email = "Marjolein.Delplace@police.belgium.eu")); 
Set(isEditor, CountRows(Filter(SharePointIntegration.Selected.Editors,Email = User().Email))>0);
Set(isRecipient, CountRows(Filter(SharePointIntegration.Selected.Recipients,Email = User().Email))>0);
Set(isAuthor, SharePointIntegration.Selected.'Gemaakt door'.Email = User().Email);
Set(isTeamMember, CountRows(Filter(SharePointIntegration.Selected.Team,Email = User().Email))>0);
Set(Topics, SharePointIntegration.Selected.Topic);
Set(isMember,Or(isEditor,isAuthor,isRecipient,isTeamMember)); 
If(SharePointIntegration.Selected.'SRB (System)', 
    If(Or(isMember,isAdmin),
         EditForm(SharePointForm1); 
         Set(userForm, true); 
         Set(visitorForm, false);
         Set(printForm, false);
         Notify(
            If(isAdmin, 
                Concatenate(
                    "TEST - ",
                    "Auteur? : ",
                    isAuthor,
                    ", ",
                    "Gebruiker: ",
                    User().Email,
                    ", ",
                    "Auteur van signaal: ",
                    SharePointIntegration.Selected.'Gemaakt door'.Email,
                    ", ",
                    "Editor? : ",
                    CountRows(Filter(SharePointIntegration.Selected.Editors,Email = User().Email))>0,
                    " = ",
                    isEditor,
                    ", ",
                    "Member? ",
                    isMember
                )
            ), 
            NotificationType.Warning
        ),
         Notify(
            Concatenate(
                nonAuthMsg,
                "Auteur? : ",
                isAuthor,
                ", ",
                "Gebruiker: ",
                User().Email,
                ", ",
                "Auteur van signaal: ",
                SharePointIntegration.Selected.'Gemaakt door'.Email,
                ", ",
                "Editor? : ",
                CountRows(Filter(SharePointIntegration.Selected.Editors,Email = User().Email))>0,
                " = ",
                isEditor,
                ", ",
                "Member? : ",
                isMember
            ),
            NotificationType.Warning
        ); 
        ViewForm(SharePointForm1)
    ),
    Notify(waitOnUpdatesMsg, NotificationType.Warning); ViewForm(SharePointForm1)
)