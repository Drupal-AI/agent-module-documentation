<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crux — install, bot user & settings

## Install / enable
`drush en crux -y`. Requires `ckeditor_mentions`, `ai` (plus a configured AI provider such as
`ai_provider_openai`), and core `user`/`system`. `league/commonmark` is pulled via Composer.

`crux_install()` (`crux.install`) creates (or reuses an existing) Drupal user named **`crux`**
with the site email and status 1, then stores its uid in `crux.settings:bot_uid`. To respond, the
bot user must be mentionable through `ckeditor_mentions` and able to post comments on the target
content. To point Crux at a different account, edit `bot_uid` (e.g. `drush cset crux.settings
bot_uid 5 -y`) — the settings form does **not** expose `bot_uid`.

`crux.module` protects the bot: `crux_entity_access()` returns `forbidden` for `update`/`delete`
on the bot user, and `crux_entity_predelete()` throws `RuntimeException` if something tries to
delete it.

## Settings form
Route `crux.settings` → `/admin/config/ai/crux`, `Drupal\crux\Form\CruxSettingsForm`
(`ConfigFormBase`), permission `administer crux settings` (`restrict access: true`). Menu link
`crux.settings` sits under `ai.admin_settings`.

Form groups (`buildForm()`):
- **Processing limits:** `user_daily_mention_limit`, `global_daily_limit`,
  `throttle_response_time` (all `#type => number`, `#min => 0`, required).
- **AI provider:** built by `ai.form_helper` (`AiProviderFormHelper::generateAiProvidersForm`) for
  operation type `chat`, element prefix `crux` → form values `crux_ai_provider` / `crux_ai_model`.
  `validateForm()` requires a provider and (unless `__default__`) a model; `submitForm()` persists
  `ai_provider_id`, `ai_model_id`, and `ai_provider_configuration` (via
  `generateAiProvidersConfigurationFromForm`).
- **Uninstall cleanup:** `delete_on_uninstall` checkbox.
- **Default AI system prompt:** `default_system_prompt` textarea.

## Config object `crux.settings` (schema `config/schema/crux.schema.yml`)
| Key | Type | Default (`config/install`) | Meaning |
|-----|------|----------------------------|---------|
| `bot_uid` | integer | 0 (set to the created user by install) | The bot Drupal user id. |
| `user_daily_mention_limit` | integer | 3 | Max mentions per content author per day; 0 = unlimited. |
| `global_daily_limit` | integer | 50 | Max total bot responses site-wide per day; 0 = unlimited. |
| `throttle_response_time` | integer | 5 | Minutes to wait after a mention before generating a reply. |
| `ai_provider_id` | string | '' | Selected `ai` provider plugin id. |
| `ai_model_id` | string | '' | Model id for that provider. |
| `ai_provider_configuration` | ignore | {} | Dynamic provider-specific config from the AI form helper. |
| `delete_on_uninstall` | boolean | false | Delete bot content + bot user on uninstall. |
| `default_system_prompt` | text | long default | System prompt sent with every chat request. |

## Uninstall
`crux_uninstall()` only deletes if `delete_on_uninstall` is TRUE and `bot_uid` is set: it deletes
all nodes (chunks of 50) and comments (chunks of 100) authored by the bot uid, then deletes the
bot user (using a `drupal_static('crux_allow_delete_bot', TRUE)` flag). With the toggle off,
bot-authored content is preserved.

## Operating
Replies are produced asynchronously. Cron runs the `crux_mentions_response` queue
(`cron = {time = 30}`); to flush manually: `drush queue-run crux_mentions_response`. The
mention→reply mechanics are documented in [../queue/mention-response.md](../queue/mention-response.md).
