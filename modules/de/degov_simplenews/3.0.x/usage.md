<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# deGov Simplenews

Adds GDPR-related requirements to Simplenews subscription forms, such as requiring acceptance of a per-language privacy policy and recording the subscriber's name and consent time.

- Injects a required privacy-policy consent checkbox into subscription block/page forms.
- Adds required Forename/Surname fields to subscription forms.
- Records and displays when a subscriber accepted the data-protection regulations.

---

## Installation & configuration

- Requires the **simplenews** module.
- Settings at `/admin/config/degov/simplenews` (route `degov_simplenews.settings`, perm `administer simplenews settings`).
- Configure a **privacy_policy** node per language and a **consent_message** per language.
- If no privacy-policy node exists for the current language, the signup form is hidden (admins see an error message).
- Config object: `degov_simplenews.settings`.
- An `.install` file adds forename/surname/created columns to the subscriber table.

---

## Usage & behaviour / security

- `hook_form_alter` targets `simplenews_subscriptions_block` and `simplenews_subscriber_page_form`.
- The consent checkbox links to the configured privacy-policy node and is `#required`.
- The consent message is rendered via `check_markup()` with the admin-selected text format (admin-trusted content).
- Forename/surname are stored via the `degov_simplenews.insert_name` service on submit.
- Subscriber lookups use **parameterised** `select()` queries filtered by `mail` — no SQL injection.
- The admin subscriber form shows the stored consent timestamp ("Has accepted ... at DATE TIME").
- Cache context `user.roles` is added so the consent UI varies correctly.
- The unsubscribe/opt-out submit handler redirects to a configured confirmation page or the front page.
- Newsletter add-form options are regrouped into optgroups for clarity.
- No external HTTP calls, no SSRF, no anonymous mutation beyond Simplenews' own subscribe flow.
- Consent data is captured to support GDPR record-keeping.
- Works per-language; each language needs its own policy node/message.
- Tests and phpunit config are included.
- Pair with a cookie-consent/GDPR strategy site-wide.
- Read: `degov_simplenews.module`, `src/Service/InsertNameService.php`, `src/Form/SettingsForm.php`.
