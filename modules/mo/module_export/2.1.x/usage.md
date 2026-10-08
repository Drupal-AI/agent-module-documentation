<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Export builds an empty module whose `.info.yml` depends on all your current modules, so enabling it on another site pulls in the same set.

---

The module exposes one admin form at `/admin/modules/export` (`SettingsForm`, gated by the core `administer users` permission). You give the generated module a name and description, choose which modules to include (All / Enabled / Disabled), and pick an output format. In Module format it writes a `<machine>.info.yml` (with a `dependencies:` list of every selected module, grouped by package) plus a `<machine>.module` into `public://<machine>/`, tars them into `<machine>.tar.gz`, and streams the archive as a download. In CSV format it writes a spreadsheet of title, package, installed/current version, latest-release status, project URL, dependencies, and status.

An optional "Check Minor Version" mode injects a `hook_module_preinstall` into the generated `.module` that uninstalls any module whose version does not match the exported version — a strict replication guard. The generated machine name is sanitised to `[a-z0-9_]`, so no path traversal. Output files land in the public files directory; their content is only a module inventory (names, versions, project links) — not secrets — and generating them requires the `administer users` permission.

---
- Replicate the exact module set from one Drupal site onto another.
- Produce a single "glue" module you enable to install everything at once.
- Export only the enabled modules, or only disabled, or all.
- Hand a client a tarball that reproduces your site's contrib stack.
- Generate a CSV inventory of every module and its version.
- Audit which modules are behind their latest release.
- Capture project URLs for every contrib module in one file.
- Document a site's dependencies for a migration or upgrade.
- Enforce identical minor versions across environments with the version-check option.
- Seed a new environment's composer/enable step from the dependency list.
- Share a reproducible baseline between dev, stage, and prod.
- Snapshot the module set before a major refactor.
- Give auditors a machine-readable module list.
- Bootstrap a distribution's install profile dependency list.
- Compare two sites' module inventories via their CSV exports.
- Enable the whole dependency tree on the target with `drush en <name>`.
