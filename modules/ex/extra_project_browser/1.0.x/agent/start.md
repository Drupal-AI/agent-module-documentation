<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Browser Extra Recipes (extra_project_browser) — agent index

Adds one **Project Browser source** plugin (`extra_recipes`) that lists the codebase's own `extra_*` recipes in
core's Project Browser UI. It scans **local disk** for `recipe.yml` files — there is **no remote fetch**. Package
`Project Browser`. License GPL-2.0-or-later. Version 1.0.2. Core `^10 || ^11` (Composer requires
`drupal/project_browser:^2.1`).

## Dependencies

- `drupal:project_browser` — provides the `ProjectBrowserSource` plugin type, `ProjectBrowserSourceBase`, the
  `Project`/`ProjectsResultsPage`/`ProjectType` value objects, the core `Recipes` source (reused for its recipes
  path), the `cache.project_browser` bin, and the `recipe-logo.svg` image. Composer `drupal/project_browser:^2.1`.

## What it provides (from source)

- **One ProjectBrowserSource plugin**: `Drupal\extra_project_browser\Plugin\ProjectBrowserSource\ExtraRecipes`
  (attribute id `extra_recipes`, label *Extra recipes*), extending `ProjectBrowserSourceBase`. It scans recipe
  directories, filters to `extra_*`, drops a hardcoded exclusion list, and returns `ProjectType::Recipe` results
  with a `search` text filter and in-memory paging. → [plugins/extra-recipes.md](plugins/extra-recipes.md)
- **Install/uninstall hooks** (`extra_project_browser.install`): `hook_install` auto-enables `extra_recipes` in
  `project_browser.admin_settings` (`enabled_sources`); `hook_uninstall` removes it. → [plugins/extra-recipes.md](plugins/extra-recipes.md)

## What it does NOT provide

No routes, no controllers, no permissions, no forms, no config objects, **no config schema**, no `config/install`,
no entities, no custom services, no Drush. It defines **no plugin type of its own** — it implements Project
Browser's existing `ProjectBrowserSource` type. `configure` is null; there is nothing to configure. No content or
access-control role.

## Install / operate

1. `composer require drupal/extra_project_browser` (pulls `drupal/project_browser`).
2. `drush en extra_project_browser -y`.
3. `drush cr` so Project Browser picks up the source and the scan runs.
4. Open Project Browser; the **Extra recipes** source is enabled automatically and lists any `extra_*` recipes
   found in the recipes locations. No settings page exists.
