<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & mechanism — Happy New Year!

## Install & enable

```bash
composer require drupal/happy_new_year
drush en happy_new_year -y
```

No other Drupal modules required (`composer.json` `require: {}`, info.yml has no `dependencies`).
Core `^10 || ^11`. For CDN-free snow, place Snowstorm at `/libraries/snowstorm/snowstorm.js`
(and `snowstorm-min.js`); otherwise the default is the jsDelivr CDN (see libraries below).

## Settings form

Route `happy_new_year.happy_new_year_admin_settings` → `/admin/config/media/happy_new_year`,
requirement `_permission: 'administer site configuration'`. Form class
`Drupal\happy_new_year\Form\HnySettingsForm` (`ConfigFormBase`), form id
`happy_new_year_settings`, editable config name `happy_new_year.settings`. Menu link
(`links.menu.yml`) sits under `system.admin_config_media` (*Configuration → Media*).
The snow-color field renders a Farbtastic color wheel via `core/jquery.farbtastic` +
`happy_new_year/colorpicker` (`js/colorpicker.js` binds `#color-picker` to
`#edit-happy-new-year-snowcolor`). The form uses `#states` to show/hide the period, garland
and snow sub-fieldsets based on their enable checkboxes.

## Config object `happy_new_year.settings`

Defaults from `config/install/happy_new_year.settings.yml`. There is **no config schema file**
(no `config/schema/`), so keys are untyped for config inspection/translation.

| Key | Default | Meaning |
|---|---|---|
| `happy_new_year_period` | `0` | Enable the working period. If off, the effect runs all the time. |
| `happy_new_year_start` | `'0'` | Start **December** day; select index 0–30 = day 1–31 (code adds 1). |
| `happy_new_year_end` | `'0'` | End **January** day; select index 0–30 = day 1–31 (code adds 1). |
| `happy_new_year_garland` | `0` | Enable the garland strip. |
| `happy_new_year_garland_topfixed` | `0` | Garland `position: fixed` (else `absolute`). |
| `happy_new_year_garland_coretoolbar` | `0` | Offset garland below the Drupal core toolbar. |
| `happy_new_year_garland_bootstrapfixed` | `0` | Offset garland below a Bootstrap `.navbar-fixed-top`. |
| `happy_new_year_garland_custommargin` | `0` | Use a custom top margin for the garland. |
| `happy_new_year_garland_custommargintext` | `''` | Custom top margin value in px (maxlength 7). |
| `happy_new_year_snow` | `0` | Enable falling snow (Snowstorm). |
| `happy_new_year_snowcolor` | `'#FFFFFF'` | Snowflake color; hex string (maxlength 7), Farbtastic wheel. |
| `happy_new_year_minified` | `1` | Use minified Snowstorm assets. |
| `happy_new_year_cdn` | `1` | Load Snowstorm from the jsDelivr CDN (else local `/libraries/`). |

`HnySettingsForm::submitForm()` writes all thirteen keys straight into
`happy_new_year.settings` and shows a saved message. No validation beyond form element
`#maxlength`.

## How the effect is rendered — `hook_page_attachments()`

In `happy_new_year.module`, `happy_new_year_page_attachments(&$attachments)`:

1. Skips **admin routes** entirely (`router.admin_context->isAdminRoute()`), so the back office
   is never decorated.
2. If `happy_new_year_period` is on **and** `_happy_new_year_isholidaytime()` is false, returns
   (no decoration). The helper returns TRUE when `date('m') == 12 && date('d') >= start+1`, or
   `date('m') == 1 && date('d') <= end+1`; otherwise FALSE. With the period off, decoration is
   always attached.
3. If garland is on: attaches library `happy_new_year/garland` and passes `fixed_garland`,
   `garlandCoreToolbar`, `garlandBootstrapFixed`, `garlandCustomMargin`,
   `garlandCustomMarginText` via `drupalSettings`. `js/garland.js` prepends a `#garland` div to
   `<body>`, animates its CSS `background-position` on a 500 ms `setInterval`, and applies the
   position/offset options.
4. If snow is on: attaches `happy_new_year/snow` plus one of the four Snowstorm variants chosen
   from (`minified`, `cdn`) — `snowstorm-min-cdn`, `snowstorm-min`, `snowstorm-cdn`, or
   `snowstorm` — and passes `happy_new_year.snowcolor` via `drupalSettings`. `js/snow.js` sets
   `snowStorm.snowColor` from that value and `snowStorm.className = 'snowflake'`.

## Asset libraries (`happy_new_year.libraries.yml`)

- `garland` — `css/garland.css` + `js/garland.js` (deps `core/jquery`, `core/drupal`).
- `snow` — `css/snow.css` + `js/snow.js` (deps `core/jquery`, `core/drupal`).
- `settings-form` — `css/settings-form.css` (attached by the form's period fieldset).
- `colorpicker` — `js/colorpicker.js`.
- `snowstorm-cdn` / `snowstorm-min-cdn` — external Snowstorm from
  `https://cdn.jsdelivr.net/gh/ivnish/Snowstorm/…` (BSD).
- `snowstorm` / `snowstorm-min` — local `/libraries/snowstorm/snowstorm(-min).js`.

## Install/update hooks (`happy_new_year.install`)

- `happy_new_year_update_8100` — deletes `happy_new_year.settings` (config reset).
- `happy_new_year_update_8101` — returns a "visit the settings page" notice.
- `happy_new_year_update_8102` — sets `happy_new_year_cdn = 1` (CDN loading on by default).

## Operate it

- Enable the module, visit `/admin/config/media/happy_new_year`, tick *Enable garland* and/or
  *Enable snow*, adjust options, save.
- For a holiday-only window, tick *Enable working period* and pick the December start / January
  end days; leave it off for year-round decoration.
- On light themes, change *Snow color* from `#FFFFFF` so flakes are visible.
- For offline/CDN-free sites, untick *Load libraries from CDN* and drop Snowstorm into
  `/libraries/snowstorm/`.
