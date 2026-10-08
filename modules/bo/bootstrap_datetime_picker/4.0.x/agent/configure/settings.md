<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — global settings & library

## Settings form
- Route `bootstrap_datetime_picker.settings`, path `/admin/config/content/bootstrap_datetime_picker`,
  form `Form\BootstrapDateTimeSettingsForm` (extends `ConfigFormBase`),
  **permission `administer site configuration`** (core).
- Saves the single config object `bootstrap_datetime_picker.settings` (schema in
  `config/schema/bootstrap_datetime_picker.schema.yml`).

## Config `bootstrap_datetime_picker.settings`
| Key | Default | Meaning |
|---|---|---|
| `icon_type` | `fontawesome` | Icon set: `fontawesome` or bootstrap-icons. |
| `use_cdn` | `true` | Load the icon CSS from a CDN. |
| `use_tempus_dominas_cdn` | `false` | Load the Tempus Dominus **library** from a CDN (`datetimepicker-cdn`) instead of `/libraries`. |
| `display_icons_time`/`_date`/`_up`/`_down`/`_previous`/`_next`/`_today`/`_clear`/`_close` | `fa-solid fa-*` | Glyph classes for each picker control. |
| `display_sideBySide` | `false` | Show date & time side by side. |
| `display_calendarWeeks` | `false` | Show ISO week numbers. |
| `display_viewMode` | `calendar` | Initial view (`calendar`/`clock`/…). |
| `display_toolbarPlacement` | `bottom` | Toolbar position. |
| `display_keepOpen` | `false` | Keep picker open after selection. |
| `display_buttons_today`/`_clear`/`_close` | `false` | Show toolbar buttons. |
| `display_components_calendar`/`_date`/`_month`/`_year`/`_decades`/`_clock`/`_hours`/`_minutes` | `true` | Which components are shown. |
| `display_components_seconds` | `false` | Show seconds. |
| `display_inline` | `false` | Render inline (always visible). |
| `display_theme` | `auto` | `auto`/`light`/`dark`. |
| `hourCycle` | `undefined` | Force 12/24-hour, or guess. |
| `language` | `en` | Locale; loads `/libraries/tempus-dominus/dist/locales/<lang>.js`. |

Example:
```bash
ddev drush cset bootstrap_datetime_picker.settings use_tempus_dominas_cdn true -y
```

## Library
Install Tempus Dominus to `/libraries/tempus-dominus` (assets at
`dist/js/tempus-dominus.min.js`, `dist/css/tempus-dominus.min.css`). `hook_requirements` (runtime)
reports Installed/Not installed and the detected version from the library's `package.json`; the settings
form also warns if the folder is missing. Set `use_tempus_dominas_cdn: true` to skip the local install
and load `@eonasdan/tempus-dominus@6.9.4` from jsDelivr. Popper.js loads from a CDN in both library
definitions (`bootstrap_datetime_picker.libraries.yml`).

## Per-widget settings
Global config sets the defaults; each field widget instance (Manage form display) additionally exposes
`wrapper_class`, `column_size_class`, `date_date_format`, `date_date_min`, `date_date_max`,
`disabled_hours`, `disable_days` (weekdays), `exclude_date` (specific dates) — see
[../plugins/widgets.md](../plugins/widgets.md).
