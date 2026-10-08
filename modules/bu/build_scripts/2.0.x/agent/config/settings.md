<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build scripts — configuration & operation

## Install / enable

`drush en build_scripts`. No module or composer dependencies (core only). The module does nothing on its own: it needs the companion **build daemon** (`https://github.com/oikeuttaelaimille/builder`) running and reachable at the configured `address`, plus a shell script on that server that accepts two positional args (`ENVIRONMENT` = stage, `LANGUAGE` = langcode). See the project `README.md` for the reference Gatsby script.

## Config object `build_scripts.settings`

Shipped defaults (`config/install/build_scripts.settings.yml`):

```yaml
address: "http://localhost:9999"   # base URI of the build daemon
stages: ["live"]                    # free-form list of stage/environment names
```

- `address` — base URI Guzzle uses (`base_uri`) for all daemon calls. Admin-set only.
- `stages` — array of stage names. Each becomes a toolbar link and a valid `{stage}` route value. Only names in this list are accepted (see `BuildManager::isValidStage()`).

No `config/schema/*` is shipped (so `data.json` `provides_config_schema: false`; config translation / typed-config validation is unavailable for these keys).

## Settings form

`Form\BuildSettingsForm` (`getFormId` = `build_scripts_settings`, editable config `build_scripts.settings`) at `/admin/config/system/build` (route `build_scripts.settings_form`, menu link `build_scripts.settings` under `system.admin_config_system`). It renders the `address` textfield plus an AJAX "Add stage / Remove one" repeater of stage textfields. `submitForm()` saves `stages` via `array_filter($stages, 'strlen')` (drops blanks) and `address`.

## Permissions (`build_scripts.permissions.yml`)

- `use build_scripts` — "Build site": run builds and view logs. Gates `build_scripts.start`, `.view`, `.logs`, and the toolbar tray.
- `administer build_scripts configuration` — "Administer builder": edit `address` + `stages`. `restrict access: TRUE` (treated as a security-sensitive permission). Gates only `build_scripts.settings_form`.

## How a build runs (protocol)

1. Operator clicks a stage in the "Build" toolbar tray (`build_scripts_toolbar()` in `.module`, only shown to `use build_scripts` holders). JS `build_scripts.toolbar` intercepts the click and `fetch`es the stage URL with `POST`.
2. `build_scripts.start` (POST `/admin/build/{stage}`) → `BuildController::start()` calls `BuildManager::start($stage, $language)`, which validates the stage and POSTs to `{address}/start/{stage}+{language}` on the daemon. The daemon returns a build id (JSON).
3. The build id is stored in the session key `build_scripts.{stage}` and logged (`logger('build_scripts')->info(...)`). The browser then navigates (GET) to the same path → `BuildController::view()` renders `#builder-output` and attaches `build_scripts.builder`.
4. `build_scripts.builder` JS `fetch`es `build_scripts.logs` (`/admin/build/logs/{build_id}`), which streams the daemon's `/logs/by-id/{build_id}` response chunk-by-chunk into a `StreamedResponse` (`Content-Type: text/plain`, `X-Accel-Buffering: no`) and appends each chunk to the `<code>` element via `textContent`.

Notes for operators: `stage` is only accepted if it is in `stages` (invalid stage → `\Exception` → 500). `language` is the current interface langcode, not user input. The daemon `address` is fixed admin config; the web request cannot redirect it elsewhere. Log streaming raises the PHP time limit to 10 minutes (`BUILD_TIMEOUT`).
