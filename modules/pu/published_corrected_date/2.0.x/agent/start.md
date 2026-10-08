<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Published and corrected dates (published_corrected_date) — agent index

Adds **three read-only base fields to every node** — `published_date` (first time saved published),
`corrected_date` (last time saved published) and `correction_number` (count of published saves after
the first). They are defined in `published_corrected_date_entity_base_field_info()` and populated
automatically in `published_corrected_date_node_presave()`; there is no widget, form-display entry or
settings page, so an editor cannot change them by hand — the README calls them properties "that
cannot be modified in the UI." The values exist to be *displayed* (Views, Layout Builder, Twig) so a
site can show "Published 3 March, updated 11 March" honestly.

Why this over core: `created` is when the node was made (often long before publication) and `changed`
moves on *every* save — a typo fix, a taxonomy tweak, a bulk operation — so neither answers "when was
this published" or "when was it corrected". This module records those two moments separately and
counts corrections, which is what news/editorial SEO (`datePublished` / `dateModified`) actually
needs. `hook_install()` back-fills the three fields for existing nodes from published-revision
timestamps.

- Depends on: `drupal:node`. No optional/suggested modules.
- Core: `^10 || ^11`. Package: `Workflow`.
- No settings page / `configure` route, no permissions, no drush, no services, no config schema, no
  plugin types. Pure base-field + presave logic in two procedural files.

## What you'd do → where

- **Use / display the three fields (machine names, types, Views, Layout Builder, Twig)** →
  [fields/base-fields.md](fields/base-fields.md)
- **Understand when/how the values are set, the correction-count rule, and the install back-fill** →
  [hooks/lifecycle.md](hooks/lifecycle.md)

## Key facts (real machine names)

- Base fields on `node`: `published_date` (`timestamp`), `corrected_date` (`timestamp`),
  `correction_number` (`integer`). All `revisionable = FALSE`, `translatable = TRUE`; date fields
  default `NULL`, count defaults `0`. Defined at `published_corrected_date.module:19-38`.
- Hooks: `hook_entity_base_field_info()` (`.module:15`), `hook_node_presave()` (`.module:46`),
  `hook_install()` (`.install:13`), `hook_uninstall()` (`.install:24`).
- Population rule: first published save sets `published_date`; each later published save sets
  `corrected_date = now` and increments `correction_number`; unpublished saves change nothing.
- Install back-fill uses static SQL over `{node_field_data}` / `{node_field_revision}` (status = 1).
- No routes, controllers, services, permissions, forms, templates, JS or CSS.
