# Webform Email Confirmation Link — agent index

Adds one Webform handler, `email_confirmation` (extends core `EmailWebformHandler`). New submissions are
saved as drafts; the submitter is emailed an HMAC-signed confirmation link; visiting it completes the
submission. Depends on `webform`. No permissions, no Drush, no global config page (per-handler settings
only). Provides a config schema and one token.

- **Add & configure the handler, its settings, the confirmation token/route, and the confirm flow** →
  [configure/handler.md](configure/handler.md)

Key facts:
- Handler id `email_confirmation`; states forced to draft-created/updated; `preSave()` sets
  `in_draft = TRUE` on new submissions.
- Token `[webform_submission:confirmation_link]` → route `webform_email_confirmation_link.confirmation`
  path `/webform_email_confirmation/{uuid}/{timestamp}/{hash}` (permission `access content`).
- `hash = Crypt::hmacBase64("{timestamp}:{uuid}", Settings::getHashSalt())`; validated with
  `hash_equals` and only while the submission is still a draft (so single-use).
- Handler settings: `confirmation_url_timeout` (sec, empty=never), `redirect_path`, `confirmation_message`
  (schema `webform.handler.email_confirmation`, with the core email handler mapping appended via
  `hook_config_schema_info_alter`).
