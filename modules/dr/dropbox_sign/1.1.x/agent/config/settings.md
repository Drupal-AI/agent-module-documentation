<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, configuration, routes & permissions

## Install & enable

```bash
composer require drupal/dropbox_sign
drush en dropbox_sign -y
```

`composer require drupal/dropbox_sign` pulls in `drupal/encryption ^4.0` and the `dropbox/sign ^1.3`
PHP SDK (from `composer.json`). `dropbox_sign.install`'s `hook_requirements()` checks that
`vendor/dropbox/sign/src/Api/SignatureRequestApi.php` exists and raises a blocking error
(`RequirementSeverity::Error`) otherwise, during both `install` and `runtime`. The Encryption module
is a hard dependency (`dependencies: encryption:encryption` in the info file) and must have its
encryption key configured, or credential encrypt/decrypt will fail.

## Settings form

Class `Drupal\dropbox_sign\Form\DropboxSignSettingsForm` (`src/Form/DropboxSignSettingsForm.php`),
form id `dropbox_sign_settings_form`, extends `ConfigFormBase`. Injects `@encryption` alongside the
config factory and typed-config manager.

- Route `dropbox_sign.settings` → path `/admin/config/system/dropbox-sign`, title "Dropbox Sign API",
  requirement `_permission: administer dropbox sign`.
- Menu link `dropbox_sign.settings` (`dropbox_sign.links.menu.yml`) under `system.admin_config_system`
  (*Configuration → System*).

### Fields

| Field | Type | Storage |
|---|---|---|
| `api_key` (Dropbox Sign API Key, required) | textfield | encrypted, saved manually in `submitForm()` |
| `client_id` (Dropbox Sign Client ID) | textfield | encrypted, saved manually |
| `cc_emails` (CC Email Addresses) | textfield | plain, via `#config_target` `dropbox_sign.settings:cc_emails` |
| `test_mode` (Test Mode) | checkbox | plain, via `#config_target` `dropbox_sign.settings:test_mode` |

### How credentials are handled (from source)

- `buildForm()` shows the **decrypted** current values as defaults
  (`$this->encryption->decrypt($config->get('api_key'), TRUE)`).
- `validateForm()` calls the helper `dropbox_sign_validate_dropboxsign_api_key($api_key)`
  (in `dropbox_sign.module`), which does a **live health check**: a cURL Basic-auth request to
  `https://api.hellosign.com/v3/template/list`; if the JSON response contains an `error`, its
  `error_msg` is shown as a form error. (TLS verification uses the cURL defaults — it is not
  disabled; the key travels in the `Authorization` header, not the URL.)
- `submitForm()` encrypts both `api_key` and `client_id` with `EncryptionService::encrypt(..., TRUE)`
  and saves them explicitly; if either encrypt returns null it aborts with a messenger error telling
  the admin to enable Encryption and set a key. The two `#config_target` fields save automatically.

## Config object & schema

Config object `dropbox_sign.settings`. Schema `config/schema/dropbox_sign.schema.yml`
(`type: config_object`) with keys: `api_key` (text), `client_id` (text), `cc_emails` (text),
`test_mode` (boolean); all `translatable: false`. **No `config/install/` defaults ship** (the
directory is empty), so an un-configured site has null values and the service throws until a key is
saved.

Note: `api_key`/`client_id` are typed `text` in schema but actually hold ciphertext, because the form
encrypts them before saving (they are not plain values despite the schema type).

## Routes summary

- `dropbox_sign.settings` — admin form, `_permission: administer dropbox sign`.
- `dropbox_sign.signature_callback` — POST `/process-dropbox-sign-callback`, `_access: TRUE`
  (anonymous, so Dropbox Sign can reach it). See [../api/callback.md](../api/callback.md) for how the
  controller authenticates each request.

## Permission

`administer dropbox sign` (`dropbox_sign.permissions.yml`) — `restrict access: true`. Gates only the
settings form; it does not gate the callback route.
