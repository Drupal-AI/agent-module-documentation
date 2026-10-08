Project Browser adds an in-admin UI for finding, comparing, and installing contrib modules (and recipes) from Drupal.org and other sources without leaving the site or knowing Composer.

---

Project Browser replaces the trip to Drupal.org with a browsing UI at **Admin → Extend → Browse** (`/admin/modules/browse/{source}`), rendered by a Svelte app that queries a REST-ish endpoint (`/project-browser/data/project`). Results come from pluggable **ProjectBrowserSource** plugins: `drupalorg_jsonapi` (contrib modules via Drupal.org JSON:API, the default), `recipes` (recipes found in the local code base), `drupal_core` (core modules), `local_modules` (already-installed modules), and `recommended` (a curated list from a configured URI). Each source declares filters (category, maintenance/security status, development status), sort options, and an optional local task tab. Site builders enable and order sources, pick the default source, and toggle experimental in-UI installation on the settings form (`project_browser.settings`, config object `project_browser.admin_settings`). When `allow_ui_install` is on and core's **Package Manager** module is present, an **Activator** pipeline installs the chosen project: `ModuleActivator` enables modules (downloading contrib through Package Manager's Composer sandbox stage) and `RecipeActivator` applies recipes, with a multi-step begin/require/apply/post-apply/destroy stage flow. Without Package Manager the UI still shows the Composer command to run. Access is gated by the core `administer modules` permission (browsing and activating) and `administer site configuration` (the settings and actions forms); the module defines no permissions of its own. Developers extend it by writing a custom `ProjectBrowserSource` plugin (the `#[ProjectBrowserSource]` attribute + `ProjectBrowserSourceInterface`) to expose any catalog of projects, and it ships a Drush command to clear its stored data.

---

- Browse Drupal.org contrib modules from inside the admin UI without visiting drupal.org.
- Search, sort, and filter available modules by category, security coverage, and maintenance status.
- See only projects compatible with the current site's Drupal version.
- Install a contrib module directly from the UI (experimental) using Package Manager, no shell.
- Get the exact `composer require` command for a module when UI install is off.
- Browse and apply local **recipes** from the admin UI.
- Enable and reorder which sources appear (contrib, core, recipes, local, recommended).
- Set the default source shown when the Browse page opens.
- Present a curated "recommended add-ons" list to editors via the `recommended` source.
- List already-installed local modules through the `local_modules` source.
- Browse Drupal **core** modules through the `drupal_core` source.
- Add a custom project catalog (e.g. a private module registry) via a `ProjectBrowserSource` plugin.
- Expose an internal/enterprise module marketplace inside the site's admin.
- Limit how many projects can be selected for installation at once (`max_selections`).
- Turn on filtering by development status for the Drupal.org source.
- Embed a Project Browser as a block on an admin page (Project Browser block).
- Give site builders module discovery without granting Composer/server access.
- Onboard new Drupalers by making module discovery point-and-click.
- Gate browsing behind `administer modules` and settings behind `administer site configuration`.
- Deploy source/install settings as configuration (`project_browser.admin_settings`) across environments.
- Alter or reorder discovered source plugins via `hook_project_browser_source_info_alter()`.
- Clear cached/stored Project Browser data with `drush project-browser:storage-clear` (`pb-sc`).
- Provide a fixture-backed test source for module discovery UIs (example submodule pattern).
- Show a warning/status while a background install (Package Manager stage) is in progress.
- Cancel or unlock a stuck in-UI installation sandbox.
- Filter recommended/recipe projects to a specific display order per source.
