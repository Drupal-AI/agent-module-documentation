<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global options: wrapper / position / colour lists

These are the dropdown choices offered on every section's Configure-section form. They live in
the single config object `layout_builder_sections_config.settings`.

- Route: `layout_builder_sections_config.settings` →
  `/admin/config/content/layout-builder-sections-config`
  (form `Drupal\layout_builder_sections_config\Form\SettingsForm`,
  permission `administer site configuration`).

## Keys (all plain strings)

Each is a **newline-separated list of `key|Label` pairs** (the `key` becomes the stored value
/ CSS class; the `Label` is what editors see):

| Key | Purpose | Shipped default (`\r\n`-separated) |
|---|---|---|
| `title_wrappers` | HTML tag wrapping a shown title | `h1|H1` … `h6|H6` |
| `title_positions` | CSS class for title alignment | `section-left-title|Left`, `section-center-title|Center`, `section-right-title|Right` |
| `title_colors` | CSS class for title colour | `section-black-title|Black`, `section-white-title|White`, `section-blue-title|Blue` |

Parsing: `_layout_builder_sections_config_extract_values()` splits on `\n`, trims, and requires
**every** non-empty line to contain a `|` (an explicit key). A line with no `|` makes the whole
list parse to `NULL` (the select then shows only the `- None -` empty option). So always use
`key|Label` on every line.

## Read / edit via drush

```bash
drush cget layout_builder_sections_config.settings title_colors
```

Add a colour option (append to the existing list, keep the `key|Label` shape):

```php
$c = \Drupal::configFactory()->getEditable('layout_builder_sections_config.settings');
$c->set('title_colors', $c->get('title_colors') . "\nsection-red-title|Red")->save();
```

The new `key` (`section-red-title`) is emitted as a CSS class on the title wrapper when an
editor selects "Red" for a section, so add the matching CSS in your theme.

## Restore defaults

Set the three keys back to the shipped strings above (note the module installs them with
`\r\n` line separators; `\n` also parses correctly).
