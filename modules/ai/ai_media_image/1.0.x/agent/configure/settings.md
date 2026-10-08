# Configure — settings form & prerequisites

## Prerequisite (lives in the `ai` module, not here)
This module only consumes whatever the **AI** module is configured with. It needs a **default
`text_to_image` provider + model** set at `/admin/config/ai/settings`
(`ai.settings:default_providers.text_to_image.provider_id` / `.model_id`). On install,
`hook_install` → `_ai_media_image_check_default_provider_and_model()` reads `ai.settings` and, if
that default is missing/empty, prints an error message pointing to the AI settings page. The API
key/credentials belong to the AI provider module, never to `ai_media_image`.

## This module's settings form
- **Route:** `ai_media_image.settings_form` at `/admin/config/ai/ai_media_image`
  (`_permission: administer ai`). Menu link `ai_media_image.settings`, parent `ai.admin_settings`.
- **Form class:** `Drupal\ai_media_image\Form\AiMediaImageSettingsForm` (a `ConfigFormBase` using
  `RedundantEditableConfigNamesTrait`; the single element is bound via `#config_target`).

### Config object `ai_media_image.settings`
| Key | Type | Default | Effect |
|---|---|---|---|
| `provider_configuration_open` | boolean | `true` | Whether the "Provider Configuration" fieldset on the generate UI (`image_generator_ajax_prefix` details) is expanded by default. |

Schema: `config/schema/ai_media_image.schema.yml` (`ai_media_image.settings` → `config_object`).
Install default: `config/install/ai_media_image.settings.yml` sets it to `true`. The
`ai_media_image_post_update_add_settings` post-update backfills the key to `TRUE` if it was `NULL`.

### Set it without the UI
```php
\Drupal::configFactory()->getEditable('ai_media_image.settings')
  ->set('provider_configuration_open', FALSE)->save();
```
```bash
drush config:set ai_media_image.settings provider_configuration_open false -y
```
