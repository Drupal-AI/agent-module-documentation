<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Libraries UI adds an admin report at `/admin/reports/libraries` that lists every asset (CSS/JS) library declared by the site's installed modules and themes, plus core, so you can browse each library's version, files, dependencies and settings without reading `*.libraries.yml` files.

---

The module has no configuration and no storage: it is a read-only inspector over Drupal's library discovery. A controller (`LibrariesUiController::libraries`, route `libraries_ui.overview` at `/admin/reports/libraries`, gated by the permission `access libraries_ui`) renders the `libraries_ui` theme hook (template `libraries-ui.html.twig`) with the output of the `libraries_ui` service. That service, `LibrariesUiService::getAllLibraries()`, walks the module handler and theme handler, and for each extension that ships a `<name>.libraries.yml` calls `LibraryDiscovery::getLibrariesByExtension()`, returning an array keyed by extension → library name → definition (also always including `core`). A Drush command `libraries:debug` (alias `ld`) exposes the same data on the CLI with an interactive picker and a version/dependencies table. The module ships a permission (`access libraries_ui`, marked restricted) and its menu link lives under *Reports*. For developers, `getAllLibraries()` is a convenient one-call way to get all library metadata as a PHP array for use in other code.

---

- Browse every CSS/JS library defined on the site from one admin page.
- Look up a specific library's declared version without opening a `*.libraries.yml` file.
- See which libraries a given module or theme provides.
- Inspect a library's `dependencies` to understand load order and requirements.
- Check whether a library marks its assets as minified.
- Audit third-party JS/CSS libraries shipped by contrib modules for review.
- Give site builders a self-service way to discover available libraries.
- Debug why an asset isn't loading by confirming the library definition exists.
- List core's own libraries alongside module/theme libraries in one view.
- Use `drush libraries:debug` (alias `ld`) to dump library info on the CLI.
- Pick a single extension in the Drush picker to see just its libraries.
- Export/screenshot a library inventory for documentation or handoff.
- Verify a newly added `*.libraries.yml` entry is discovered by Drupal.
- Compare library versions across environments during upgrades.
- Find the file paths (CSS/JS) a library attaches.
- Confirm a theme's libraries after a theme change.
- Restrict library inspection to trusted admins via the `access libraries_ui` permission.
- Programmatically fetch all library metadata via the `libraries_ui` service (`getAllLibraries()`).
- Build a custom report or integration on top of the returned library array.
- Spot duplicate or conflicting library definitions across extensions.
- Teach new developers what libraries a Drupal site exposes.
- Sanity-check dependency chains before removing a module that provides a library.
