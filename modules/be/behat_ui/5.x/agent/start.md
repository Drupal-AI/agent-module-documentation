<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behat UI (behat_ui) — agent index

Web UI to author and run **Behat/Mink (Gherkin) functional tests** against a Drupal site, wrapping a
project's existing `behat` binary + `behat.yml` + `.feature` files. Version dir **5.x** (5.0.1).
Core `^10 || ^11`. License GPL-2.0-or-later. A **development/CI tool** — it shells out to the
configured Behat binary on the server; limit to trusted developers and prefer not to run in production.

## Requirements
- Composer libs (not Drupal modules): `drupal/drupal-extension:~5`, `webship/behat-html-formatter:~1`.
- No Drupal module dependencies (`behat_ui.info.yml` declares none). A working Behat install on the server.
- Optional external JS lib: Ace editor 1.16.0 from cdnjs (free-text editor), declared in `behat_ui.libraries.yml`.

## What it provides
- **Config**: single config object `behat_ui.settings` (schema `config/schema/behat_ui.schema.yml`,
  defaults `config/install/behat_ui.settings.yml`). Settings route id `behat_ui.settings`.
- **Permissions** (`behat_ui.permissions.yml`): `run all tests in behat ui`,
  `create tests with behat ui`, `administer behat ui settings`.
- **Forms** (`src/Form/`): `BehatUiRunTests` (run suite), `BehatUiNew` (author/run a scenario),
  `BehatUiSettings` (config form, `ConfigFormBase`).
- **Controller** (`src/Controller/BehatUiController.php`): status, report, kill, autocomplete,
  step-definition listings, download.
- **Theme hook** `behat_ui_report` (template `templates/behat-ui-report.html.twig`), `hook_help`,
  `hook_install` (both in `behat_ui.module` / `behat_ui.install`).
- No services, no plugins, no Drush commands, no entities.

## Routes (all `_admin_route`)
- `behat_ui.run_tests` `/admin/config/development/behat-ui` — run suite form — perm `run all tests in behat ui`.
- `behat_ui.new` `/admin/config/development/behat-ui/new` — author/run scenario — perm `create tests with behat ui`.
- `behat_ui.settings` `/admin/config/development/behat-ui/settings` — settings — perm `administer behat ui settings`.
- `behat_ui.behat_dl` / `behat_ui.behat_di` / `behat_ui.behat_dl_json` — step-definition listings — perm `create tests with behat ui`.
- `behat_ui.autocomplete` `/behat-ui/autocomplete` — step autocomplete (JSON) — perm `create tests with behat ui`.
- `behat_ui.status` `/behat-ui/status`, `behat_ui.report` `/behat-ui/report` — perm `run all tests in behat ui+create tests with behat ui`.
- `behat_ui.kill` `/behat-ui/kill` — kill process — perm `run all tests in behat ui`.
- `behat_ui.download` `/behat-ui/download/{format}` — perm `create tests with behat ui`.

## Solution docs
- Configuration (all `behat_ui.settings` keys, defaults, schema): [agent/config/settings.md](config/settings.md)
- Running & authoring tests (routes, forms, controller, process model): [agent/operation/running-tests.md](operation/running-tests.md)
