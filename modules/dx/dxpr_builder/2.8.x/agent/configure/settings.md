<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# Configure: global settings, licensing & AI

Config object: **`dxpr_builder.settings`** (schema `config/schema/dxpr_builder.schema.yml`).
Forms: `DxprBuilderSettingsForm` at route `dxpr_builder.settings`
(`admin/dxpr_studio/dxpr_builder/settings`) and `DxprBuilderAiSettingsForm` at
`dxpr_builder.ai_settings` (`.../ai_settings`). Both require `administer dxpr builder configuration`.

## General settings keys
| Key | Meaning |
|---|---|
| `json_web_token` | The DXPR license JWT/API key (when stored in config). |
| `api_key_storage` | `'config'` or `'key'` — where the token lives (default `config`). |
| `key_provider` | Key entity id when `api_key_storage == 'key'` (needs the `key` module). |
| `bootstrap` | Bootstrap version DXPR loads. |
| `cke_stylesset` | Text-editor formatting styles. |
| `editor_assets_source` | Where editor JS/CSS assets are served from. |
| `format_filters` | Bool — run text-format filters on builder output. |
| `media_browser` | Media browser to use (e.g. `media_library`, or `''` = basic upload). |
| `offset_selector` | Smooth-scroll offset selector (default `.dxpr-theme-header--sticky, .dxpr-theme-header--fixed`). |

## Licensing
The key can be stored in plain config (`json_web_token`) or, preferably, a **Key** entity
(`api_key_storage: key`, `key_provider: <key_id>`). Access to the editor's AJAX routes is gated
by `_dxpr_builder_billable_user` (service `dxpr_builder.license_service`,
`DxprBuilderLicenseService::isBillableUser()`), which validates against DXPR's central license.
Changing the JWT triggers a user re-sync. Read current values with
`drush cget dxpr_builder.settings`.

## AI settings (subset of the same config object)
`ai_enabled`, `ai_page_enabled`, `ai_image_enabled`, `ai_user_model_selection`, `ai_model`,
`ai_provider_selection_mode` (`automatic` default), `ai_providers` (sequence of
`{enabled, weight, region}`), `tone_of_voice_vocabulary` (+ `enable_taxonomy_tones`),
`commands_vocabulary` (+ `enable_taxonomy_commands`), and output sanitization:
`ai_output_allowed_domains`, `ai_output_allowed_tags`, `ai_output_stripped_tags`.
Default model comes from `Constants\AiModelConstants::getDefaultModel()`.

## Shipped config
`config/install/` ships five page templates (`dxpr_builder.page_template.*`: about_me,
about_us, homepage_basic, split_content_and_buttons, text_columns) and two system actions
(`dxpr_builder_avow_user`, `dxpr_builder_disavow_user`).
