<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behat UI — configuration (`behat_ui.settings`)

Single config object `behat_ui.settings`. Schema: `config/schema/behat_ui.schema.yml`
(all keys typed `string`/`boolean`). Install defaults: `config/install/behat_ui.settings.yml`.
Edited via `Drupal\behat_ui\Form\BehatUiSettings` at `/admin/config/development/behat-ui/settings`
(route `behat_ui.settings`, perm `administer behat ui settings`, config route id from `.info.yml`).

`BehatUiSettings::submitForm()` saves every submitted form value whose key contains the substring
`behat_ui` into the config object (no per-key allowlist). `validateForm()` only validates
`behat_ui_behat_tags` (must parse as a `key|label` list, keys ≤ 255 chars) via
`optionsExtractAllowedListTextValues()`.

## Keys (key — type — install default — meaning)
- `behat_ui_behat_config_path` — string — `"."` — dir holding `behat.yml`; the run commands `cd` into it.
- `behat_ui_behat_bin_path` — string — `"php ./bin/behat"` — the Behat executable command (may include `php`), absolute or relative to the config path. Required in the form.
- `behat_ui_behat_config_file` — string — `"behat.yml"` — `behat.yml` filename, passed as `--config=`.
- `behat_ui_behat_features_path` — string — `"tests/features"` — dir (relative to config path) holding `.feature` files; also where authored features are written.
- `behat_ui_autoload_path` — string — `"../../../vendor/autoload.php"` — autoload path (form field only; not used by the run code paths).
- `behat_ui_html_report` — boolean — `true` — when true, produce/serve an HTML report; when false, use a plain console log.
- `behat_ui_html_report_dir` — string — `"tests/reports"` — dir for the HTML report; report served from `<dir>/index.html`.
- `behat_ui_log_report_dir` — string — `"tests/logs"` — dir for the console log; log file is `<dir>/bethat-ui-test.log` (note the misspelling in source).
- `behat_ui_editing_mode` — string — `"free_text"` — `guided_entry` (step builder) or `free_text` (Ace Gherkin editor); drives `BehatUiNew::buildForm()`.
- `behat_ui_http_user` / `behat_ui_http_password` — string — `""` — HTTP basic-auth creds for the site under test (stored in config; password field is `#type => password`). Stored as plain config, not a Key entity.
- `behat_ui_http_auth_headless_only` — boolean — `true` — apply HTTP auth only to headless runs.
- `behat_ui_save_user_testing_features` — boolean — `false` — if false, a scenario run by `runSingleTest()` deletes its temp `.feature` file afterward; if true it is kept in the features dir.
- `behat_ui_needs_browser` — boolean — `true` — default for the "Needs a real browser" (Selenium/JS) checkbox.
- `behat_ui_behat_tags` — string — newline `key|label` list (`javascript|Selenium + JavaScript`, `api|Drupal API`, `local|Local`, …) — reference list of Behat tags shown in the UI.

## Notes
- The `behat_ui_http_user`/`behat_ui_http_password` values are consumed by the project's own
  `behat.yml`/FeatureContext, not by module PHP directly.
- Report/log directories are created on demand via `FileSystemInterface::prepareDirectory(..., CREATE_DIRECTORY)`
  before a run (see `BehatUiRunTests::validateForm()` and `BehatUiNew::runSingleTest()`).
