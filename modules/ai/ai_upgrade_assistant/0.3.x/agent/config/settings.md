<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & permissions

## Install / enable

1. `composer require drupal/ai_upgrade_assistant` (pulls `drupal/upgrade_status` ^4.0).
2. `drush en ai_upgrade_assistant` — enables `system`, `update`, `upgrade_status` as dependencies.
3. Run an Upgrade Status scan first; the AI report reads its results.

## Settings form — `Form\SettingsForm` (extends `ConfigFormBase`)

- Route `ai_upgrade_assistant.settings`, path `/admin/config/development/ai-upgrade-assistant`,
  permission **`administer site configuration`**. Also the module's `configure` link.
- Editable config: **`ai_upgrade_assistant.settings`** (`getEditableConfigNames()`). No
  `config/install` defaults and no `config/schema` ship with the module, so keys are created on
  first save and each `#default_value` supplies the fallback.

Config keys written by `submitForm()`:

| Key | Form element | Default (via `?:`) | Notes |
|-----|--------------|--------------------|-------|
| `openai_api_key` | textfield (required) | — | Validated against `/^sk-[a-zA-Z0-9]{32,}$/`. Used by `OpenAIService` as the Bearer token. |
| `model` | select | `gpt-4` | `gpt-4` or `gpt-3.5-turbo`. (Note: `OpenAIService` currently hardcodes `gpt-4` in its payload regardless of this value.) |
| `batch_size` | number (1–100) | `50` | Files per batch operation. |
| `file_patterns` | textarea | `*.php,*.module,*.inc,*.install` | Comma-separated include globs for `ProjectAnalyzer::findPhpFiles()`. |
| `excluded_paths` | textarea | `vendor/,node_modules/,tests/` | Comma-separated. (`findPhpFiles()` reads `exclude_patterns`/`exclude_dirs`, not this key — the two are not fully aligned.) |
| `report_format` | checkboxes | `['html']` | `html`, `pdf`, `json`. |
| `report_path` | textfield | `public://ai-upgrade-reports` | Validated with `FileSystem::prepareDirectory(..., CREATE_DIRECTORY)`. |
| `timeout` | number (5–120) | `30` | API timeout seconds. |
| `max_retries` | number (0–5) | `3` | API retry count. |
| `fallback_to_mock` | checkbox | `FALSE` | "Use mock results when API calls fail. Use for testing only." |

Other keys read elsewhere in code but **not** exposed on this form: `scan_custom_modules`,
`scan_contrib_modules` (read by `ProjectAnalyzer`/`BatchAnalyzer`), `patch_format`,
`cleanup_backups`. They stay null unless set manually.

`validateForm()` rejects a malformed API key, an uncreatable report directory, and empty file
patterns.

## Permissions — `ai_upgrade_assistant.permissions.yml`

- `access upgrade assistant` — "View the AI Upgrade Assistant dashboard and recommendations."
- `administer upgrade assistant` — "Configure AI Upgrade Assistant settings and manage OpenAI integration."

Both are `restrict access: true`. **Neither is used in `routing.yml`**: report routes require
`access upgrade status` (defined by the `upgrade_status` dependency) and the settings form requires
`administer site configuration`. So granting the module's own permissions has no routing effect in
0.3.0.
