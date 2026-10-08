<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config & upload form

## Install / enable

```
composer require drupal/apple_pay_verification
drush en apple_pay_verification -y
```

No other modules required (relies on core `file`, `config`, `entity`). Ensure the **private file
system** is configured (`file_private_path` in `settings.php`), because the upload targets
`private://applepay`.

## The form — `src/Form/SettingsForm.php`

- Route `apple_pay_verification.settings_form` → `/admin/config/system/apple-pay-verification`.
- Permission required: **`administer apple_pay_verification configuration`** (defined in
  `apple_pay_verification.permissions.yml`, `restrict access: true`, description "Allows for
  modifying the Apple Pay verification file.").
- `getFormId()` = `apple_pay_verification_settings`; extends `ConfigFormBase`;
  `getEditableConfigNames()` = `['apple_pay_verification.settings']`.
- `buildForm()` adds one element:
  - `verification_file` — `#type => 'managed_file'`,
    `#upload_location => 'private://applepay'`,
    `#upload_validators => ['FileExtension' => []]`,
    `#default_value` = current config value.
- `submitForm()` — if a file was uploaded, `File::load($fid)->setPermanent()->save()` (managed
  files start temporary; this keeps it), then writes the whole element value into
  `apple_pay_verification.settings:verification_file` and calls `parent::submitForm()`.

## Config object

- Name: **`apple_pay_verification.settings`**.
- Key **`verification_file`**: the raw `managed_file` value — an array of file entity IDs (the
  controller uses `reset()` to take the first). No `config/install/` default ships, so the key is
  empty until an admin saves the form.
- Schema `config/schema/apple_pay_verification.schema.yml`: `type: config_object` with a single
  placeholder mapping `example: string`. It does **not** declare `verification_file`, so that key
  is effectively unschematized (a config-completeness gap, not a functional break).

## Operating it

1. Download the association file from Apple's Developer portal (or from Stripe's "payment method
   domain" registration).
2. Upload it via the settings form and save.
3. Clear cache (`drush cr`) if the well-known route still 404s or serves stale bytes — the
   response is a `CacheableResponse`.
4. Confirm at `/.well-known/apple-developer-merchantid-domain-association` (see
   [../routes/well-known.md](../routes/well-known.md)).
