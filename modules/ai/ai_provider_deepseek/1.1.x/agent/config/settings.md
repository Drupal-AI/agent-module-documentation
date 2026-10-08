<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install & configure DeepSeek Provider

## Install / enable

- `composer require drupal/ai_provider_deepseek` (pulls `deepseek-php/deepseek-php-client:^1.0`).
- `drush en ai_provider_deepseek` — requires `ai` (>=1.0-beta) and `key` to be present.

## Create the key first

The API key is not stored in module config directly; config stores the **id of a Key entity**.
Create the key at `/admin/config/system/keys/add` (any provider — file, env var, config). Storing
it as an environment-variable key keeps the secret out of exported configuration.

## Settings form

- Route `ai_provider_deepseek.settings` → **`/admin/config/ai/providers/deepseek`**, form
  `src/Form/SettingsForm.php` (`getFormId()` = `ai_provider_deepseek_settings`).
- Permission **`administer ai_provider_deepseek configuration`** (`restrict access: TRUE`).
- Menu link `ai_provider_deepseek.settings` sits under `ai.admin_providers`
  (*Configuration → AI → Providers*), weight 10.
- One field: `api_key` — a **`key_select`** element (from the `key` module) listing available keys,
  `#required`. `buildForm()` also has a `model` reference in `submitForm()` but renders no model
  element, so no model is actually saved by this form.

## Config object & schema

- Editable config: **`ai_provider_deepseek.settings`** (`getEditableConfigNames()`).
- Schema `config/schema/ai_provider_deepseek.schema.yml`: a `config_object` with one mapping key,
  `api_key: string`. There is no `config/install/` default, so `api_key` is empty until set —
  which is why `isUsable()` returns FALSE on a fresh install.
- Example export:

```yaml
# ai_provider_deepseek.settings.yml
api_key: deepseek_api_key   # the machine name of a Key entity
```

## Permission

`ai_provider_deepseek.permissions.yml`:

```yaml
administer ai_provider_deepseek configuration:
  title: 'Administer DeepSeek Provider configuration'
  description: 'Allow access to configure DeepSeek Provider settings.'
  restrict access: TRUE
```

Grant it only to trusted roles: it controls which Key entity supplies the DeepSeek credential and
therefore what account is billed for API calls.
