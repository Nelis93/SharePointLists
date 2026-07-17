##### SharePointIntegration ######
##### OnNew:
NewForm(SharePointForm);
Navigate(RenderingScreen);
##### onView:
Set(isRendered,false);
Set(isNotDirectModification,true);
If(isTutorialSeen,Navigate(RenderingScreen),Navigate(TutorialScreen))
##### onCancel:
ResetForm(SharePointForm1);
##### onSave:
If(SharePointForm.Mode = FormMode.New, ClearCollect(Validators,NewValidators));
SubmitForm(SharePointForm);
Notify(Concatenate("Data saved? ",!SharePointForm.Unsaved),NotificationType.Information,3000);
If(isValidationRequest,
    'ValidationFlow_Test'.Run(
            JSON(
                ShowColumns(
                    SharePointIntegration.Selected,
                    'Id (ID)',
                    Titel,
                    Gemaakt,
                    Gewijzigd,
                    Topic,
                    'Gemaakt door',
                    'Gewijzigd door',
                    Team,
                    Recipients,
                    Notify,
                    Editors,
                    Title_F,
                    'Validated (System)',
                    'Status (2)'
                ),
                JSONFormat.IncludeBinaryData
            ),
            User().Email,
            Coalesce(commentText,"test validation"),
            Coalesce(Concat(Validators,Email,";"),"Nelis.Eerdekens@police.belgium.eu;Marjolein.Delplace@police.belgium.eu"),
            false,
            JSON(
                {
                    isApproval: false,
                    Approved: false
                }
            ),
            JSON(
                {
                    isPrioCall: false,
                    Confirmed: false
                }
            )
        );
);
If(isDirectValidation,
    'ValidationFlow_Test'.Run(
            JSON(
                ShowColumns(
                    SharePointIntegration.Selected,
                    'Id (ID)',
                    Titel,
                    Gemaakt,
                    Gewijzigd,
                    Topic,
                    'Gemaakt door',
                    'Gewijzigd door',
                    Team,
                    Recipients,
                    Notify,
                    Editors,
                    Title_F,
                    'Validated (System)',
                    'Status (2)'
                ),
                JSONFormat.IncludeBinaryData
            ),
            User().Email,
            "Direct validation",
            "Nelis.Eerdekens@police.belgium.eu",
            false,
            JSON(
                {
                    isApproval: true,
                    Approved: true
                }
            ),
            JSON(
                {
                    isPrioCall: false,
                    Confirmed: false
                }
            )
        );
);
RequestHide()
##### onNew:
NewForm(SharePointForm1); 
Set(userForm, true); 
Set(visitorForm, false); 
Set(BodyF, false); 
Set(BodyN, false); 
Set(printForm, false)
##### OnEdit:
If(
    isNotDirectModification,
        If(
            isRendered,
                If(
                    Or(isMember,isAdmin),
                        Notify("isRendered: " & isRendered & "isNotDirectModification: " & isNotDirectModification,NotificationType.Information,3000);
                        EditForm(SharePointForm);
                        Navigate(FormScreen,ScreenTransition.Cover),
                    Notify(nonAuthMsg, NotificationType.Warning,3000)
                );
                Set(isRendered,false);
                Set(isNotDirectModification,false),
            Notify(waitOnDataMsg, NotificationType.Information,3000);
            EditForm(SharePointForm);
        ),
    EditForm(SharePointForm);
    If(isTutorialSeen,Navigate(RenderingScreen),Navigate(TutorialScreen))
)