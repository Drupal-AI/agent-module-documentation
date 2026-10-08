<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build scripts (build_scripts) — agent index

Trigger named build **stages** on an external build daemon from the Drupal UI and stream their logs. The module runs **no shell command itself** — `BuildManager` is an HTTP client that POSTs `stage` + current language to a configurable daemon address (`oikeuttaelaimille/builder`); the daemon runs the script. Inert without the daemon.

- **Version:** 2.0.0-beta2 · **Core:** `^8 || ^9 || ^10 || ^11` · **Package:** OE · no module dependencies, no composer requirements beyond core.
- **Config object:** `build_scripts.settings` (`address` string, `stages` list). Defaults: `address: http://localhost:9999`, `stages: [live]`. No config schema shipped.
- **Permissions:** `use build_scripts` (run builds / view logs), `administer build_scripts configuration` (edit address + stages; `restrict access: TRUE`).
- **Service:** `build_scripts.build_manager` → `Drupal\build_scripts\BuildManager` (args `@config.factory`, `@http_client_factory`).
- **Hook:** `build_scripts_toolbar()` adds a "Build" toolbar tray with one link per stage (only for users with `use build_scripts`).
- **Libraries:** `build_scripts/build_scripts.toolbar` (POST-on-click), `build_scripts/build_scripts.builder` (fetch + stream log to `#builder-output`).

## Routes

| Route | Path | Method | Permission | Controller |
| --- | --- | --- | --- | --- |
| `build_scripts.settings_form` | `/admin/config/system/build` | GET | `administer build_scripts configuration` | `Form\BuildSettingsForm` |
| `build_scripts.start` | `/admin/build/{stage}` | POST | `use build_scripts` | `BuildController::start` |
| `build_scripts.view` | `/admin/build/{stage}` | GET | `use build_scripts` | `BuildController::view` |
| `build_scripts.logs` | `/admin/build/logs/{build_id}` | GET | `use build_scripts` | `BuildController::logs` |

## Solution docs

- [config/settings.md](config/settings.md) — install, the `build_scripts.settings` object, permissions, and how the daemon protocol works.
- [api/build-manager.md](api/build-manager.md) — `BuildManager` / `BuildLogStream` service API and the controller/JS flow.
