<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings & custom classes

Route `responsivewrappers.settings` → `/admin/config/content/responsivewrappers`
(also under *Configuration → Content authoring*). Permission: `administer filters` (core;
the module adds none of its own). Form: `ResponsiveWrappersSettings` (a `ConfigFormBase`).

These settings set the **classes/markup** the per-format filter emits and whether to attach the
module's minimal CSS. The filter toggles themselves are per text format — see
[../plugins/filter.md](../plugins/filter.md).

## Config object `responsivewrappers.settings`

Schema `config_object` (`config/schema/responsivewrappers.schema.yml`); install defaults:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `version` | int | `4` | Bootstrap output version: `3`, `4`, `5`, or `0` (Custom). Drives which class values are saved. |
| `add_css` | int | `0` | `0` = No, `1` = Yes. When `1` the filter attaches the module's minimal CSS library (not full Bootstrap). |
| `image_class` | string | `img-fluid` | Class added to `<img>`. |
| `iframe_wrapper_class` | string | `embed-responsive embed-responsive-16by9` | Wrapper div class for matching iframes. |
| `iframe_class` | string | `embed-responsive-item` | Class added to matching iframes. |
| `table_wrapper_class` | string | `table-responsive` | Wrapper div class for tables. |
| `table_class` | string | `table` | Class added to `<table>`. |

## How the form derives classes (submit logic)

The five class fields live in a collapsed "Custom classes" details section, but they are
**only honored when `version` = 0 (Custom)**. On save the form overwrites them from `version`:

- `version` 3 → `image_class` = `img-responsive`; iframe/table classes = the Bootstrap defaults above.
- `version` 4 or 5 → `image_class` = `img-fluid`; iframe/table classes = the Bootstrap defaults above.
- `version` 0 (Custom) → all five class fields are saved verbatim from the form (trimmed).

Note: Bootstrap 5 selects the same output classes and the same `responsivewrappers_v4`
CSS library as Bootstrap 4 (`embed-responsive*`, `img-fluid`); choose **Custom** if you need
Bootstrap 5's own ratio utilities instead.

## Set via Drush

    ddev drush cset responsivewrappers.settings version 3 -y
    ddev drush cset responsivewrappers.settings add_css 1 -y

For fully custom classes, set `version` to 0 first, then set each `*_class` key. Changing
`version` through the UI rewrites the class keys; setting keys directly with `cset` does not.

## CSS libraries

Defined in `responsivewrappers.libraries.yml`, attached by the filter only when `add_css` = 1:

- `responsivewrappers_v3` → `assets/css/responsivewrappers-b3.css`
- `responsivewrappers_v4` → `assets/css/responsivewrappers-b4.css` (used for versions 4 and 5)

Leave `add_css` = 0 on a Bootstrap 3/4/5 theme or sub-theme (the theme already defines the classes).
