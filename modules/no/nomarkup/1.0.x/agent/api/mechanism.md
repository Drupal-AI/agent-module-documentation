<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How No Markup works + Views style

## Field-markup removal (theme suggestions)

The whole feature is a few hooks in `nomarkup.module`:

- `hook_field_formatter_third_party_settings_form()` — adds the **Remove field markup**
  checkbox (+ separator, + referenced-entity option for `entity_reference_entity_view`).
- `hook_field_formatter_settings_summary_alter()` — shows the summary text on Manage display.
- `hook_theme_suggestions_field_alter()` — when `enabled`, forces the field theme suggestion
  to `field__nomarkup`, so the field renders through **`field--nomarkup.html.twig`** (which
  prints only values joined by `separator`, no wrappers).
- `hook_preprocess_field()` — exposes `separator` to the template and, for a referenced-entity
  reference field with `referenced_entity` on, flags each child with `#nomarkup`.
- `hook_theme_suggestions_alter()` / `hook_preprocess()` — when a referenced entity is flagged,
  switches it to `entity__nomarkup` → **`entity--nomarkup.html.twig`** (bare entity output),
  re-running the upstream preprocess so variables still populate.

Templates shipped (`templates/`): `field--nomarkup.html.twig`,
`entity--nomarkup.html.twig`, `views-view-nomarkup.html.twig`.

`NoMarkupInterface::DEFAULT_SEPARATOR = '|'`.

## Views style plugin

`Drupal\nomarkup\Plugin\views\style\NoMarkup` — `@ViewsStyle(id = "nomarkup", theme =
"views_view_nomarkup", display_types = {"normal"})`. Choose **No markup** as a view's Format
to render rows with no extra wrapping markup (template `views-view-nomarkup.html.twig`).
Extends `StylePluginBase`.

## No configure / permission / plugin type / Drush / API hooks

Everything is driven by the display config third-party setting (see
[../configure/remove-markup.md](../configure/remove-markup.md)) and the Views style. The
module invites no `hook_*` of its own and adds no services or Drush commands.
