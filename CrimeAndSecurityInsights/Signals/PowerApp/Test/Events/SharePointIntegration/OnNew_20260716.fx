ResetForm(SharePointForm);
NewForm(SharePointForm);
Navigate(RenderingScreen);
Set(
    changes,
    Patch(
        changes,
        {
            confiChange: false,
            topicChange: false
        }
    )
);
Set(isNewSignal, true);
