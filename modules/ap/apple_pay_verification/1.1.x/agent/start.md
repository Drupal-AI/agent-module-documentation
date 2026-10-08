<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apple Pay Verification (apple_pay_verification) — agent index

Uploads the **Apple Pay merchant domain-association file** and serves its contents at the fixed
well-known route(s) Apple fetches to verify domain ownership. Package `Commerce`. **No module
dependencies** (uses core `file`, `config`, `entity`). Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.1.0.

## What it actually is

- One admin form + one invokable controller. No entities, no plugins, no services, no Drush, no
  hooks, no libraries.
- Config object **`apple_pay_verification.settings`**, key `verification_file` — a managed-file
  value (array of file entity IDs, as produced by a `managed_file` element).

## Routes (`apple_pay_verification.routing.yml`)

- `apple_pay_verification.verification` → `/.well-known/apple-developer-merchantid-domain-association`
- `apple_pay_verification.verification_txt` → same path with `.txt`
  - Both `_controller: \Drupal\...\ApplePayVerificationController` (invokable), permission
    `access content` — intentionally public so Apple's anonymous crawler can read the file.
- `apple_pay_verification.settings_form` → `/admin/config/system/apple-pay-verification`, form
  `SettingsForm`, permission **`administer apple_pay_verification configuration`**
  (`restrict access: true`). Menu link under *Configuration → System*.

## Solution docs

- **Upload form, config object, permission, install/enable** →
  [config/settings.md](config/settings.md)
- **How the well-known routes resolve and serve the file (controller mechanics)** →
  [routes/well-known.md](routes/well-known.md)

## Mechanism (from source)

- `Form/SettingsForm.php`: `managed_file` element, `#upload_location => 'private://applepay'`; on
  submit it marks the uploaded file permanent and stores the element value in
  `apple_pay_verification.settings:verification_file`.
- `Controller/ApplePayVerificationController.php` (`__invoke`): reads that config, `reset()`s the
  fid array, loads the `file` entity, and returns a `CacheableResponse` of
  `file_get_contents($file->getFileUri())` with `Content-Type: text/plain`. The served path comes
  only from admin config — no request/path parameter reaches it.
- Config schema `config/schema/apple_pay_verification.schema.yml` declares the config object but
  its mapping lists only a placeholder `example` key, not `verification_file` (schema is
  incomplete vs. what the form writes).
