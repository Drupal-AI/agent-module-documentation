<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Scheme Field (color_scheme_field) — agent index

Provides a single **field type** that stores the machine name of one **color scheme** chosen
from the list a theme declares in its `.info.yml`. The field value is just that identifier
(a `varchar(255)` string); the actual colors live in the theme. Installed **1.0.0-beta2**
(version dir `1.0.x`). Core `^10 || ^11`, PHP `>=8.1`. License GPL-2.0-or-later. No module
dependencies, no external libraries, no permissions, no routes, no config schema of its own.

## Setup prerequisite

Before the field is useful, the **default theme** must declare options under a `color_scheme:`
key in its `<theme>.info.yml`, e.g.:

```yaml
color_scheme:
  scheme-one: Scheme one
  scheme-two: Scheme two
```

Keys are the stored/selectable values; values are the labels editors see. `hook_requirements`
(`color_scheme_field.install`, runtime phase) raises `REQUIREMENT_ERROR` on the status report if
the default theme defines no `color_scheme`, or if any entry has a non-string/empty key or label.

## What it provides (from source)

- **Field type** `color_scheme_field` (`src/Plugin/Field/FieldType/ColorSchemeItem.php`) — one
  string property `name`, stored as `varchar(255)` with an index named `format` on that column.
  `default_widget = color_scheme_field_widget`, **`default_formatter = NULL`** (the module ships
  no formatter).
- **Field widget** `color_scheme_field_widget` (`src/Plugin/Field/FieldWidget/ColorSchemeWidget.php`)
  — a `select` element whose options are the default theme's `color_scheme` entries, filtered to
  non-empty string key/label pairs. `#empty_value => ''`.
- **`hook_entity_view`** (`color_scheme_field.module`) — for the first `color_scheme_field` on the
  entity with a non-empty value, sets `$build['#color_scheme_field'] = $name`. This exposes the
  chosen scheme to the render array so a **theme/preprocess/template** can act on it; the module
  itself does not render or print the value anywhere.
- **`hook_requirements`** (`color_scheme_field.install`) — the theme-options status check above.

## How a theme consumes it

The module does not output colors. A theme reads `#color_scheme_field` (the scheme machine name)
from the entity build — e.g. via a preprocess hook — and maps it to a CSS class or a scheme-specific
stylesheet defined in the theme. Escaping/whitelisting of the value on output is the theme's
responsibility.

## Solution docs

- **Field type, widget, storage, theming integration** →
  [fields/color-scheme-field.md](fields/color-scheme-field.md)
