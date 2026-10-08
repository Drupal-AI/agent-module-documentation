# Configure Project Browser — sources, install flow, access

## The Browse page

| Route | Path | Access |
|---|---|---|
| `project_browser.browse` | `/admin/modules/browse/{source}` | `administer modules` |
| `project_browser.api_project_get_all` | `/project-browser/data/project` | `administer modules` (JSON data endpoint the Svelte app calls) |
| `project_browser.settings` | `/admin/config/development/project_browser` | `administer site configuration` |
| `project_browser.actions_form` | `/admin/config/development/project_browser/actions` | `administer site configuration` |

`{source}` is the plugin ID of the active source (defaults to the configured
`default_source`). Each enabled source can also add its own local task tab on the Browse
page. The UI is a Svelte app (`project_browser_main_app` theme hook / `ProjectBrowser`
render element + block).

## Settings — config object `project_browser.admin_settings`

Edit at `project_browser.settings` (SettingsForm) or via `drush cset`. Install defaults:

| Key | Default | Meaning |
|---|---|---|
| `default_source` | `drupalorg_jsonapi` | Source shown first on the Browse page (NotBlank) |
| `enabled_sources` | `{drupalorg_jsonapi: [], recipes: []}` | Map of enabled source plugin ID → per-source settings; order = display order |
| `allow_ui_install` | `false` | Enable experimental in-UI installation (needs Package Manager) |
| `max_selections` | `null` | Max projects selectable for install at once (internal use) |

At least one source must stay enabled (form validation). Per-source schema lives under
`project_browser.source.*`; e.g. `drupalorg_jsonapi` adds `show_development_status`,
`recommended` adds `uri` + `ttl`, `recipes` adds `additional_directories`, and
order-capable sources take an `order` sequence.

Built-in sources (plugin IDs): `drupalorg_jsonapi` (Drupal.org contrib via JSON:API,
default), `drupal_core` (core modules), `recipes` (local recipes), `local_modules`
(installed modules), `recommended` (curated list from a `uri`).

## Install flow (experimental)

Set `allow_ui_install: true` **and** enable core's `package_manager` module. The install
routes only exist when `package_manager` is installed (`ProjectBrowserRoutes::routes`).
`InstallerController::access()` allows the flow only when `allow_ui_install` is on. A
multi-phase Package Manager sandbox stage runs:
`project_browser.stage.begin` → `.require` (Composer download in sandbox) → `.apply` →
`.post_apply` → `.destroy`, with `project_browser.install.unlock` to clear a stuck sandbox.
Which activator handles a project is decided by `ActivationManager`: `ModuleActivator`
enables modules, `RecipeActivator` applies recipes. With Package Manager absent, the UI
just shows the `composer require` command instead of installing.

`composer.json` conflicts: `drupal/automatic_updates < 4`, `drupal/gin < 4.0.6`.

## Access / permissions

The module defines **no permissions of its own**. Browsing and activating use the core
`administer modules` permission; the settings and actions forms use core
`administer site configuration`.

## Drush

`drush project-browser:storage-clear` (alias `pb-sc`) clears stored Project Browser data.
The Actions form (`project_browser.actions_form`) exposes the same "Clear storage" action.
