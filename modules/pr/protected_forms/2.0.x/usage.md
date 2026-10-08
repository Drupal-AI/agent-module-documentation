Protected Forms is a lightweight, non-invasive spam filter that rejects node, comment, webform, user-profile, contact, and private-message submissions containing undesired language scripts or preset text patterns — no CAPTCHA required.

---

The module implements `hook_form_alter()` and, for any non-admin, non-delete form whose id contains `user_`, `node_`, `comment_`, `contact_message_`, or `webform_` (or equals `private_message_add_form`), appends a validation handler `_protected_forms_validate()`. It skips users holding the `bypass protected forms validation` permission. Validation concatenates the submitted text/textarea values and does two checks against configurable settings in `protected_forms.settings` (nested under a `protected_forms` mapping): (1) it samples up to `check_quantity` random characters and rejects the submission if any belongs to a Unicode script not in `allowed_scripts` (e.g. blocking Cyrillic/CJK spam on a Latin-only site); and (2) it scans the text for any of the `reject_patterns` (a comma/newline-separated list of spammy words and URL schemes) and rejects on a match. Rejected submissions show the configurable `reject_message`, increment a counter stored in State (`protected_forms.rejected`, surfaced on the Status report), and — when `log_rejected` is true — are logged to the "protected forms" dblog channel. An `allowed_patterns` list can whitelist strings before checking, and `excluded_forms` lists form ids to skip entirely. Configuration lives at `/admin/config/content/protected_forms` (route `protected_forms.admin`, permission `administer protected forms`). The module ships defaults via `config/install`, a config schema, and supports config translation; it has no plugins or Drush commands.

---

- Block comment spam containing links (http://, www, mailto:) without adding a CAPTCHA.
- Reject contact-form messages written in a script your site never uses (e.g. Cyrillic).
- Stop webform submissions that include known spam words like "viagra" or "casino".
- Protect user registration/profile forms from spammy free-text fields.
- Allow only Latin-script submissions on an English-only site.
- Add extra allowed scripts (e.g. Greek, Arabic) for a multilingual audience.
- Customize the rejection message shown to blocked submitters.
- Tune how many random characters are sampled for the language-script check (check_quantity).
- Maintain a site-specific blocklist of spam phrases via reject_patterns.
- Whitelist legitimate strings (allowed_patterns) that would otherwise trip a pattern.
- Exclude specific forms from protection by listing their form ids in excluded_forms.
- Give trusted roles the "bypass protected forms validation" permission.
- Log every rejected submission to the dblog for review and tuning.
- Track the running count of rejected spam on the Status report page.
- Protect a private-message add form from spam content.
- Reduce moderation load on a high-traffic community site.
- Keep node body/text fields free of injected spam links.
- Block submissions mixing many non-allowed characters typical of bot spam.
- Deploy consistent spam rules across environments via exported config.
- Translate the reject message and settings for multilingual sites (config translation).
- Combine with core contact/comment forms for out-of-the-box spam filtering.
- Prevent SEO-spam keyword stuffing in user-submitted content.
- Quickly disable protection on one form while keeping it on the rest.
- Avoid third-party CAPTCHA services for basic spam control.
