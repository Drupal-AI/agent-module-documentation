<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mailjet_webform_subscription — agent start

Custom Webform element (`WebformMailListCheckbox`) that opts a submitter into a **Mailjet contact list**
with a double-opt-in confirmation link. Depends on `webform` + `mailjet_api`.

Flow: on submit, plugin stores a token `hash('sha256', random_bytes(55))`. Confirmation route
`GET /newsletter-subscription` (`ConfirmSubscriptionController::content`, `_access: 'TRUE'`, no-cache):
sanitises `token`/`caller` (regex to alnum/underscore), resolves via a **parameterised** query on
`webform_submission_data` (value=token, name=caller), rejects already-consumed tokens, then
`MailjetApiWrapper::appendToList()`; optional template email; optional success node render guarded by
`isPublished()` + `access('view')`.

## Security — reviewed, sound
- Anonymous confirm route, but keyed on a 256-bit random token; DB lookup is parameterised (no SQLi).
- Success-node render is access-checked (no IDOR/disclosure).
- `new \Mailjet\Client($public, $secret, TRUE, ...)` — keys from `mailjet_api.settings`; TLS via the
  Mailjet SDK (HTTPS), **not** disabled. No `verify=>false`.
