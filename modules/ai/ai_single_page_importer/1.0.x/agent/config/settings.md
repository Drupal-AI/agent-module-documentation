<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Single Page Importer — configuration & permissions

## Install / enable
`composer require drupal/ai_single_page_importer`, then `drush en ai_single_page_importer -y`. Pulls core `node` and `drupal/ai`. Configure a chat provider/model in the AI module first — extraction reads `ai.settings` `default_providers.chat.provider_id` / `.model_id` (`AiContentExtractor::extractWithAi()`); with no chat provider set, imports fail.

## Permissions (`ai_single_page_importer.permissions.yml`)
- `use ai single page importer` — shows the "AI Content Import" panel on node forms and runs imports. `restrict access: true`. Checked in `hook_form_node_form_alter` and again in the AJAX callback.
- `administer ai single page importer settings` — access the settings form. `restrict access: true`.

Grant `use ai single page importer` only to trusted editors: the import makes the server fetch a URL the editor types and sends the page text to a billable AI provider.

## Settings form
Route `ai_single_page_importer.settings` → `Drupal\ai_single_page_importer\Form\SettingsForm` at `/admin/config/ai/ai-single-page-importer` (menu link under the AI settings group; `configure` in info.yml). Editable config object: `ai_single_page_importer.settings`.

## Config keys (`config/install/ai_single_page_importer.settings.yml`, schema in `config/schema/`)
| Key | Type | Default | Meaning |
|---|---|---|---|
| `max_content_length` | integer | 30000 | Max characters of cleaned page text sent to the AI (`AiContentExtractor::cleanHtml()` truncates with `mb_substr`). |
| `request_timeout` | integer | 30 | Guzzle timeout (seconds) for the page fetch. |
| `allowed_content_types` | sequence | `[]` | Node bundles the panel appears on. Empty = all bundles. |
| `domain_blacklist` | sequence | `localhost`, `127.0.0.1`, `*.local`, `*.internal` | Blocked source hosts; `*` wildcards (`UrlValidator::matchesDomain()` → regex). |
| `flood_limit` | integer | 5 | Max imports per user+IP per window. |
| `flood_window` | integer | 3600 | Flood window in seconds. |

## Flood / rate limiting
`ai_single_page_importer_import_callback()` builds identifier `uid . '-' . clientIp`, checks `flood()->isAllowed('ai_single_page_importer.import', flood_limit, flood_window, identifier)`, and on success `register('ai_single_page_importer.import', 3600, identifier)` (note: the register TTL is hardcoded to 3600, not `flood_window`). `hook_uninstall()` clears the flood event and deletes the config.

## Operating notes
- The module fetches the URL, extracts readable text (DOMDocument, dropping `script/style/nav/footer/header/aside`), asks the AI to return JSON keyed by field name, sanitizes it, and pushes values into form fields over AJAX. It does not create or save the node — normal node create/edit access governs the save.
- Errors are surfaced through `MessageCommand` with sanitized text; details are logged to the `ai_single_page_importer` logger channel (`drush watchdog:show --channel=ai_single_page_importer`).
