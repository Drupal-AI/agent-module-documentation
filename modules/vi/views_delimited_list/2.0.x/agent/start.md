<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Delimited List (views_delimited_list) — agent index

Adds one Views **style** plugin, *"Delimited text list"* (`id = views_delimited_list`), that renders
a result set as a single inline run of text — `Design, Engineering, and Marketing` — instead of an
HTML list, table, or grid. You select it under a View's **Format**, and the style **Settings** dialog
exposes the delimiter, an optional conjunctive ("and") before the last item, a prefix/suffix, and
length-dependent rules that switch between US ("A, B, and C") and UK ("A, B and C") punctuation. A
small helper class (`ViewsDelimitedList`) decides per row whether a delimiter and/or conjunctive
follows it; a wrapper template plus a whitespace-free fields-row template (installed via a
theme-registry alter and a preprocess hook) keep everything on one line.

The whole module is this render layer — there is nothing else to it. All output is produced by Twig
templates with default autoescaping (no `|raw`/`Markup`), so the admin-set delimiter/prefix/suffix
strings are escaped like any other Views text; configuring the style requires the core *administer
views* permission.

- Depends on: `drupal:views` (core). No other modules.
- Core: `^9 || ^10 || ^11`. Package: `Views`. Version `2.0.0` (runtime-verified enabled on Drupal 11.4.5).
- No settings page / `configure` route, no routes, no services, no permissions of its own, no drush.
- Provides config schema (`views.style.views_delimited_list`). Defines no new plugin **type** — it is
  an instance of core's `views_style` plugin type.

## What you'd do → where

- **Understand/configure the style, its options, separator logic, hooks and templates** →
  [plugins/delimited-list-style.md](plugins/delimited-list-style.md)

## Key facts (real machine names)

- Style plugin: `views_delimited_list` — class
  `Drupal\views_delimited_list\Plugin\views\style\ViewsDelimitedListStyle` (extends `StylePluginBase`),
  `theme = views_view_delimited_list`, `display_types = { normal }`, `usesRowPlugin` + `usesFields`.
- Helper: `Drupal\views_delimited_list\ViewsDelimitedList` (`getSeparator`, `getDelimiters`,
  `getConjunctives`).
- Style option / config keys: `delimiter` (default `', '`), `conjunctive` (default `' and&nbsp;'`),
  `long_count` (default `3`; select `2`|`3`), `separator_two` (default `conjunctive`),
  `separator_long` (default `both`), `prefix` (`''`), `suffix` (`''`). Separator values:
  `delimiter` | `conjunctive` | `both`. Schema: `views.style.views_delimited_list`.
- Theme hooks: `views_view_delimited_list` (wrapper), `views_delimited_list_fields` (row).
  Templates: `templates/views-view-delimited-list.html.twig`,
  `templates/views-delimited-list-fields.html.twig`.
- Hooks implemented: `hook_theme`, `hook_theme_registry_alter`,
  `template_preprocess_views_view_delimited_list`, `hook_preprocess_HOOK` (for `views_view_fields`).
- Template CSS classes: `views-delimited-list`, `views-delimited-list-prefix`, `views-row`,
  `views-row-delimiter`, `views-row-conjunctive`, `views-delimited-list-suffix` (no bundled library).
