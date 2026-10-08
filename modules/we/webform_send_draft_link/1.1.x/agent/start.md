<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform send draft link (webform_send_draft_link) — agent index
**Emails a Webform draft resume link (Webform core secure update token) via a per-webform "Send draft link" tab.**

- **Version:** 1.1.x — core `^8.8.0 || ^9 || ^10`
- **Depends on:** webform, simple_mail
- **Routes:** `/form/{webform}/send_draft_link` and submission-scoped variants, all `_custom_access: WebformSendDraftLinkForm::access`, `no_cache: TRUE`
- **Token:** Webform core `getTokenUrl('update')` — unguessable, per-submission secure token (NOT a weak token); module refuses to enable unless `token_update` is on
- **Security observations:**
  - Access check (`WebformSendDraftLinkForm.php:78`) only requires the `enabled` third-party setting + an allowed route name — no ownership/permission gate. On a publicly reachable webform, any user can open the form.
  - The token URL is stored in `\Drupal::state()` keyed by **webform id only** (`webform_send_draft_link.module` `set_settings`), overwritten on every draft presave — so the send form emails the *last-saved* draft's resume link for that webform. Combined with the open access check this lets a user send another user's draft resume link to an arbitrary email (cross-user draft disclosure / takeover). Recipients are validated as emails but not restricted.

See [configure/send-draft.md](configure/send-draft.md).
