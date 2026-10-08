<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dropbox Sign (dropbox_sign) — agent index

A thin developer-facing bridge to the **Dropbox Sign** (formerly HelloSign) eSignature API. It
wraps the official `dropbox/sign` PHP SDK behind one Drupal service, adds an admin settings form,
and exposes a verified inbound callback endpoint. No entities, no plugins, no Views, no Drush.

- **Core requirement:** `^10.2 || ^11`. **License:** GPL-2.0-or-later. **Version:** 1.1.x.
- **Dependencies:** Drupal `encryption` module (`drupal/encryption ^4.0`) and the Composer library
  `dropbox/sign ^1.3` (checked by `hook_requirements()` in `dropbox_sign.install`).
- **Package:** none declared. **Configure route:** `dropbox_sign.settings`.

## What it provides

- **Service `dropbox_sign`** (`src/DropboxSign.php`) — builds and sends eSignature requests and
  reaches the raw SDK client. Also a private logger channel `logger.channel.dropbox_sign`.
  → [services/dropbox_sign.md](services/dropbox_sign.md)
- **Settings form** `DropboxSignSettingsForm` at `/admin/config/system/dropbox-sign`
  (route `dropbox_sign.settings`, permission `administer dropbox sign`), config object
  `dropbox_sign.settings`, schema in `config/schema/dropbox_sign.schema.yml`, menu link under
  *Configuration → System*. → [config/settings.md](config/settings.md)
- **Inbound callback** `DropboxSignController::signatureCallback` at `/process-dropbox-sign-callback`
  (route `dropbox_sign.signature_callback`, POST only) and the hook
  `hook_process_dropbox_sign_callback($data)`. → [api/callback.md](api/callback.md)

## Permissions

- `administer dropbox sign` (title "Administer Dropbox Sign", `restrict access: true`) — gates the
  settings form only.

## Key facts (from source)

- The API key and client ID are stored **encrypted** via the Encryption module's `EncryptionService`
  in `dropbox_sign.settings` and decrypted at read time. `cc_emails` and `test_mode` are plain config.
- Two request modes: `email` (Dropbox Sign emails signers) and `embedded` (your site renders the
  signing UI via `getSignUrl()`). Embedded mode requires the client ID.
- The callback controller decodes `request->get('json')`, enforces a 24-hour event-time window, and
  validates the event HMAC before invoking `hook_process_dropbox_sign_callback()`.
- `dropbox_sign_help()` provides `help.page.dropbox_sign` text. No config is shipped in
  `config/install/` (that directory is empty), so defaults are the config-object nulls.
