<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Skribble — configuration

Settings form: `Drupal\skribble\Form\SettingsForm` at `/admin/config/services/skribble` (config object `skribble.settings`). Fields observed in code:

- `user`, `key` — Skribble API username and API key (used by `ApiClient::authenticate()` to obtain a Bearer token from `POST {base_url}/access/login`).
- `base_url` — optional API base override; defaults to `https://api.skribble.com/v2`.
- `use_protected_download_links` — if TRUE, send the file to Skribble as a fetch URL (`skribble.download_file`, HMAC+expire) instead of a base64 `content` upload.
- `send_email` — when FALSE, per-signature `notify` is forced off.
- `quality`, `legislation` — passed through to the signature request.
- `enable_success_callbacks` — when TRUE, adds `callback_success_url` pointing at `/skribble/callback/success/{uuid}`.

Signing-request entity settings: `SigningRequestSettingsForm` at `admin/structure/skribble-signing-request` (`administer skribble_signing_request`).

## Programmatic flow
1. `SkribbleController::startSigningRequest(File $file)` (route `/skribble/start/{file}`) builds signatures (default = current user email), calls `ApiClient::signatureRequest()`, saves a `skribble_signing_request`, and returns a `TrustedRedirectResponse` to the Skribble signing URL with `exitURL` = the finish route.
2. On return, `finishSigningRequest()` calls `ApiClient::updateSigningRequest()` then, only if `status_overall==='SIGNED'`, `downloadSignedDocument()` → stores PDF in `private://skribble/{document_id}.pdf`.

## Alter hooks (`skribble.api.php`)
`hook_skribble_alter_signatures()`, `_alter_title()`, `_alter_message()`, `_alter_signing_request_entity()`, `_alter_redirect_url()`, `_alter_destination()`, `hook_skribble_signed_document_download()`.
