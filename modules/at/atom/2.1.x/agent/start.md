<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Atom (atom) — agent index

Adds an **Atom 1.0 feed** output format to Views. Two Views plugins, both limited to the `feed`
display type, turn a View into an Atom syndication feed as an alternative to core's RSS style.

- **Machine name:** `atom` · **Package:** Views · **License:** GPL-2.0-or-later
- **Dependencies:** `drupal:views` (core Views) only. No composer requirements, no PHP constraint
  beyond core.
- **Provides:** no routes, no permissions, no services, no config entities, no config schema, no
  Drush commands. Purely two Views plugins plus two Twig templates and preprocess hooks.

## What it provides

- **Views style plugin** `atom` — `src/Plugin/views/style/Atom.php` (`Drupal\atom\Plugin\views\style\Atom`).
  `@ViewsStyle(id="atom", display_types={"feed"})`, theme `views_view_atom`, `usesRowPlugin = TRUE`.
  Feed-level options form (subtitle, description URL, author name/email, category, logo, icon).
- **Views row plugin** `atom_fields` — `src/Plugin/views/row/AtomFields.php`
  (`Drupal\atom\Plugin\views\row\AtomFields`). `@ViewsRow(id="atom_fields", display_types={"feed"})`,
  theme `views_view_row_atom`, `usesFields = TRUE`. Maps View fields → Atom entry parts.
- **Templates** `templates/views-view-atom.html.twig` (the `<feed>` wrapper) and
  `templates/views-view-row-atom.html.twig` (each `<entry>`).
- **Preprocess hooks** in `atom.module`: `template_preprocess_views_view_atom()` (sets feed vars and
  the `application/atom+xml` Content-Type) and `template_preprocess_views_view_row_atom()` (sets
  entry vars, renders the summary render array to a string). Plus `atom_help()`.

## Solution docs

- [Set up an Atom feed on a View](plugins/atom-feed.md) — enable, add a Feed display, pick the Atom
  style + row plugin, map fields, feed-level options, templates, and the emitted XML.
