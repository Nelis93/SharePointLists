If(
    system.isNotDirectModification,
        If(
            system.isRendered,
                If(
                    Or(profiles.isMember,profiles.isAdmin),
                        If(
                            profiles.isAdmin,
                                Notify("--- Test --- Flow is already running: " & system.isFlowRunning & " FlowRunning Value: " & SharePointIntegration.Selected.FlowRunning,NotificationType.Information,5000);
                                Notify("isRendered: " & system.isRendered & "; isNotDirectModification: " & system.isNotDirectModification,NotificationType.Information,5000)
                        );
                        EditForm(SharePointForm);
                        Navigate(FormScreen,ScreenTransition.Cover),
                    Notify(messages.nonAuthMsg, NotificationType.Warning,3000)
                );
                Set(
                    system,
                    Patch(
                        system,
                        {
                            isNotDirectModification: false,
                            isRendered: false
                        }
                    )
                ),
            Notify(messages.waitOnDataMsg, NotificationType.Information,3000);
            EditForm(SharePointForm);
        ),
    EditForm(SharePointForm);
    If(
        system.isTutorialSeen,
            Navigate(RenderingScreen),
        Navigate(TutorialScreen)
    )
);
Set(
    changes,
    Patch(
        changes,
        {
            topicChange: false,
            confiChange: false
        }
    )
);

Set(
    validationRequest,
    Patch(
        validationRequest,
        {
            isValidationRequest: false
        }
    )
);
Set(isNewSignal, false);
