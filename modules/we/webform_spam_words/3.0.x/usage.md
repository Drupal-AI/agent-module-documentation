<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Spam Words (WSW) blocks Webform submissions whose text fields contain configured spam keywords, via a Webform submission handler you attach to individual forms.

---

The module ships two separate pieces that are easy to conflate. First, a global settings form at `/admin/config/webform/webform-spam-words` (config object `webform_spam_words.settings`) lets an administrator define a default list of spam words, an error message, and a comma-separated list of field names — but this global config is **only ever read by that settings form itself**; nothing in the module applies it automatically to any webform. Second, and separately, the module registers a Webform submission handler plugin (id `webform_spam_words`, class `BlockWordsWebformHandler`) that you must explicitly add to a specific webform's Handlers list. Only once attached does blocking actually happen: on submission validation the handler splits its configured field-name list on commas and, for each named field, lowercases and HTML-escapes the submitted value and checks it for any configured spam word as a substring; a match calls `setErrorByName()` with the configured error message, which blocks the submission entirely. The handler's own settings (`spam_words`, `spam_text_message`, `spam_field_name`) are hardcoded defaults (`SEO`, a generic message, `message`) and are independent of the global config — the handler has no configuration form UI in the admin "Add handler" screen, so per-webform values can only be changed by editing the webform's exported/config YAML or setting the handler's configuration array programmatically. There is no config schema, no Drush integration, and no new plugin type — WSW only implements the Webform module's existing `WebformHandler` plugin type.

---

- Block a contact form's "message" textarea from being submitted if it contains "SEO" or "Digital Marketing".
- Stop comment/inquiry webforms from accepting submissions that promote "unsubscribe" spam-list harvesting text.
- Reject a webform submission whose message field contains "Click Here" link-bait phrasing.
- Filter out free-trial spam pitches ("FREE", "trial") from a lead-generation webform.
- Attach the Webform Spam Words handler to a support-request webform to cut down keyword-stuffed spam.
- Configure a distinct spam-word list per webform by giving each webform its own handler instance with custom `spam_words`.
- Check multiple fields at once (e.g. `message,subject`) by setting a comma-separated `spam_field_name`.
- Present spammers with a generic, non-revealing error message so they can't tell exactly which word tripped the filter.
- Add a lightweight keyword blocklist to a contact form without installing a CAPTCHA or third-party anti-spam service.
- Combine WSW with Honeypot or reCAPTCHA on the same webform as an additional layer of spam mitigation.
- Block submissions containing "casino", "viagra", or other common spam-campaign vocabulary.
- Prevent a public event-registration webform from being flooded with promotional spam text in the "comments" field.
- Restrict which staff can edit the module's global default word list via the `edit webform spam words` permission.
- Curate an editorial team's shared starting point for spam words on `/admin/config/webform/webform-spam-words`, to be copied into individual webform handler settings.
- Give a job-application webform its own spam_field_name of `cover_letter` to catch keyword-stuffed cover letters.
- Reject a newsletter-signup webform submission whose "name" field contains obvious spam phrases.
- Guard a multi-step webform's later page (e.g. a "details" field) by attaching the handler with that field named.
- Export a webform's YAML config (including the attached `webform_spam_words` handler and its settings) for deployment across environments.
- Programmatically create the handler with `Webform::addWebformHandler()` and a custom `settings` array when provisioning webforms from code.
- Tune the error message per-webform so a translated/localized error shows for that specific audience.
- Quickly triage spam by testing candidate keywords against a scratch webform before rolling the handler out site-wide.
- Add the handler to a "request a quote" webform whose open text field is a common spam target.
- Keep the shipped defaults (`SEO`, `Digital Marketing`, `Click Here`, `unsubscribe`, `FREE`, `trial`) as a baseline and extend them per site.
- Block webform submissions containing referral-spam phrasing on a public feedback form.
- Prevent low-effort spam bots from getting past a simple keyword check before a submission reaches staff inboxes.
- Disable spam-word checking on a given webform simply by removing or disabling its `webform_spam_words` handler instance.
