Set(
    system,
    Patch(
        system,
        {
            isNotDirectModification: true,
            isRendered: false
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
If(system.isTutorialSeen,Navigate(RenderingScreen),Navigate(TutorialScreen));