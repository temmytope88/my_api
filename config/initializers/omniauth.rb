Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, "541486061594-bs04tfc5spqdbgn9vtm82spvb01r9sis.apps.googleusercontent.com", "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"
end