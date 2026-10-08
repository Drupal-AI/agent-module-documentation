<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behat UI — running & authoring tests

How the module turns UI actions into Behat runs. All routes are `_admin_route: TRUE`.

## Install / enable
`ddev drush en behat_ui -y`. `hook_install()` (`behat_ui.install`) just logs/messages where the UI
lives. There is no bundled Behat — configure paths on the Settings tab (see
[../config/settings.md](../config/settings.md)) to point at an existing Behat install.

## Run the whole suite — `BehatUiRunTests` (route `behat_ui.run_tests`)
`src/Form/BehatUiRunTests.php`, form id `behat_ui_run_tests`, perm `run all tests in behat ui`.
- `buildForm()` shows a Submit button, a live status line, and either the HTML report iframe
  (`behat_ui.report`) or the console-log contents (`nl2br(htmlentities(file_get_contents(<log>)))`).
- Running state is tracked by a PID stored in `PrivateTempStore` collection `behat_ui`, key
  `behat_ui_pid`; liveness checked with `posix_kill(intval($pid), 0)`.
- The command is assembled and executed in **`validateForm()`** (not `submitForm()`, which is empty):
  HTML mode builds a `Symfony\Component\Process\Process` from an array of pieces
  (`cd <config_path>`, `<bin>`, `--config=<file> <features_path>`, `--format pretty --out std --format html`,
  `--out <html_report_dir>`); log mode builds a single backgrounded shell string
  (`cd …;<bin> --config=… <features_path> --format pretty --out std > <log>&`). `$process->start()`
  runs it; the stored PID is `getPid() + 1`.

## Author / run a single scenario — `BehatUiNew` (route `behat_ui.new`)
`src/Form/BehatUiNew.php`, form id `behat_ui_new_form`, perm `create tests with behat ui`.
- Two modes from `behat_ui_editing_mode`: **guided_entry** (Title + repeatable Given/When/Then/And/But
  step fieldsets with `#autocomplete_route_name = behat_ui.autocomplete`, "Add step" AJAX
  `::ajaxAddStep`, "Needs a real browser" checkbox) or **free_text** (a 30-row textarea + Ace editor,
  library `behat_ui/ace-editor`).
- `getExistingFeatures()` scans `<config_path>/<features_path>` for `*.feature` to populate the Feature
  radios; `getFeature()` returns a chosen feature's contents or a built-in sample Gherkin default.
- **Run (`behat_ui_run`, AJAX `::runSingleTest`)**: writes the composed scenario to a temp file
  `<features_path>/user-<date>.feature` (guided mode wraps `generateScenario()` output in a
  `Feature:`; free-text writes the raw textarea), runs `shell_exec()` of the same behat command shape
  as above with that temp file, then shows the report iframe (`behat_ui.report`). If
  `behat_ui_save_user_testing_features` is false the temp file is `unlink()`ed afterward.
- **Download updated feature (`behat_ui_create`, `submitForm()`)**: appends the scenario to the chosen
  `<config_path>/<features_path>/<feature>.feature` (or writes the free-text), then streams it back as
  an attachment (`Content-Type: text/x-behat`) via `readfile()`.

## Controller endpoints — `BehatUiController`
`src/Controller/BehatUiController.php`:
- `getTestStatus()` (`behat_ui.status`, JSON) — reports `running`/`pid` from tempstore + report iframe HTML.
- `getTestStatusReport()` (`behat_ui.report`) — renders `#theme => behat_ui_report` with the HTML
  report file contents, or the log file (`nl2br(htmlentities(...))`); `max-age 0`.
- `kill()` (`behat_ui.kill`) — `posix_kill($pid, SIGKILL)` on the tempstore PID, then deletes it.
- `autocompleteStep()` (`behat_ui.autocomplete`, JSON) — `Xss::filter()`s the `q` query param, matches
  it against step titles parsed from `getAutocompleteDefinitionSteps()`.
- `getDefinitionSteps()` / `getDefinitionStepsWithInfo()` / `getDefinitionStepsJson()` /
  `getAutocompleteDefinitionSteps()` — run `shell_exec("cd <config_path>; <bin> -dl|-di …")` and format
  the step list for display.
- `download($format)` (`behat_ui.download`) — for `html`/`txt`, streams the report/log file. Note this
  method calls removed D7-era helpers (`drupal_add_http_header`, `drupal_goto`, `drupal_html_to_text`),
  so it errors on Drupal 10/11 — the working download path is `BehatUiNew::submitForm()` above.

## Process / state model
- Only the log-mode suite run backgrounds itself (`&`); `runSingleTest()` and the definition-step
  listings run synchronously via `shell_exec` and block the request.
- A single PID per site is tracked in the private tempstore; there is no per-user isolation of runs.
- Report/log directories are auto-created with `FileSystemInterface::prepareDirectory(..., CREATE_DIRECTORY)`.

## Theme
`behat_ui_theme()` (`behat_ui.module`) registers `behat_ui_report` →
`templates/behat-ui-report.html.twig` (`{{ output }}`).
