<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

`src/Form/EnvokeAdminSettingsForm.php` (`EnvokeAdminSettingsForm extends ConfigFormBase`).

- **Form id:** `envoke_admin_settings`. **Route:** `envoke.admin` → `/admin/config/services/envoke`
  (`envoke.routing.yml`), `_permission: 'administer envoke'`.
- **Menu link:** `envoke.links.menu.yml`, label "Envoke", parent `system.admin_config_services`.
- **Editable config:** `envoke.settings` (`getEditableConfigNames()`). Install defaults in
  `config/install/envoke.settings.yml` (all keys default to `''`). There is **no** `config/schema/`,
  so the config is untyped.

## Config keys (all stored in `envoke.settings`)

| Key | Form field | Purpose |
|-----|-----------|---------|
| `envoke_api_id` | textfield "Envoke API ID" | API ID for transactional send + default contact ops |
| `envoke_api_key` | textfield "Envoke API KEY" | API key paired with `envoke_api_id` |
| `envoke_subscription_api_id` | textfield "Envoke API ID for Subscription" | API ID used when `forSubscription` ops run |
| `envoke_subscription_api_key` | textfield "Envoke API KEY for Subscription" | API key for subscription ops |
| `envoke_campaign` | textfield "Campaign name" | Envoke campaign name; falls back to `system.site` name |
| `envoke_email_from` | textfield "From email" | Default sender email |
| `envoke_name_from` | textfield "From name" | Default sender name |
| `envoke_email_reply` | textfield "Reply to email" | Default reply-to email |
| `envoke_filter_format` | select "Input format" | Text format applied to the body before send (options from `filter_formats()`) |

`buildForm()` populates each field's `#default_value` from the current config; `submitForm()` writes
every value back to `envoke.settings` via `\Drupal::configFactory()->getEditable('envoke.settings')`.

## How config is consumed

- `EnvokeService` reads credentials through the injected immutable config service
  `envoke.load_settings.read_only` (a `config.factory:get('envoke.settings')` factory in
  `envoke.services.yml`).
- `EnvokeMailer` reads `envoke.settings` directly via `\Drupal::service('config.factory')->get(...)`.

## Permission

`envoke.permissions.yml` defines a single permission `administer envoke` (title "Administer Envoke",
`restrict access: true`). It is the only thing gating the settings route.
