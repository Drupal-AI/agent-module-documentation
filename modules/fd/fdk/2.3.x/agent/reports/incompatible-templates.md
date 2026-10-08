<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Incompatible field-templates report

Because FDK only replaces core's `field.html.twig` (theme overrides win — see
[../theming/field-rendering.md](../theming/field-rendering.md)), a theme that overrides that template
must adopt FDK's variables or FDK settings silently do nothing. This read-only report finds such themes.

## Route & access

- Route `fdk.reports` (`fdk.routing.yml`): path `/admin/reports/fdk`,
  `_controller: \Drupal\fdk\Controller\FDKController::report`, `_title: 'FDK incompatible templates'`.
- Permission: `_permission: 'administer site configuration'` (admin-only; FDK defines no permissions).
- Menu link `fdk.reports` under `system.admin_reports` (`fdk.links.menu.yml`).
- `fdk_form_alter()` also shows a warning message (linking here for users with
  `administer site configuration`) on Layout Builder forms and `entity_view_display_edit_form`.

## What it scans (`FDKHelper::getIncompatibleFieldTemplates()`)

- Iterates all **active** themes (`theme_handler` `listInfo()`), scanning each theme's `templates/`
  directory for files matching `/^field(\-\-.*)?\.html\.twig$/` via `file_system->scanDirectory()`.
- Reads each file and checks (with regexes) whether it references any FDK variable:
  `field_wrapper_tag`, `label_tag`, or `field_item_wrapper_tag`. A template with **none** of these is
  considered incompatible.
- Results are keyed by theme and cached permanently under cache key `fdk_incompatible_template_files`
  (`CacheBackendInterface::CACHE_PERMANENT`) — clear caches after editing a theme template to refresh.

## What the controller renders

`FDKController::report()` builds a description (static `#markup`) plus, per theme, an `<h2>` heading with
the theme's human name and a `#type => table` listing the relative file paths of incompatible templates.
Output is admin-gated and read-only; the report changes no configuration.

## Fixing an incompatible template

Base the theme's `field.html.twig` override on FDK's `templates/field.html.twig` (use the
`field_wrapper_tag`, `label_tag`, `field_item_wrapper_tag` variables and the `field_delimiter` handling),
then rebuild caches so the template no longer appears in the report.
