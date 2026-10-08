<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analog Digital Clock — block, settings & theming

Everything this module ships is here: one config form, one config object, one block plugin,
one theme hook, four asset libraries, four Twig-selected skins. No entities, services, hooks
beyond theme/help, Drush, or REST.

## Install / enable

- `drush en analog_digital_clock -y`. No module dependencies (`.info.yml` requires only core
  `^8 || ^9 || ^10 || ^11`).
- The **analog** skin (skin 3) additionally needs the third-party `snap.svg` library at
  `libraries/snap.svg/snap.svg-min.js` (download from
  `cdnjs.cloudflare.com/ajax/libs/snap.svg/0.2.0/snap.svg-min.js`). The three digital skins
  need no extra library. If snap.svg is absent, skin 3 simply fails to animate client-side.

## Configuration (the settings form)

- Route `analog_digital_clock.settings` → path **`/admin/config/analog_digital_clock`**,
  `_form: \Drupal\analog_digital_clock\Form\AnalogDigitalClock`, requirement
  `_permission: 'administer site configuration'` (`.routing.yml`).
- Menu link `analog_digital_clock.settings` sits under **Configuration → Regional and language**
  (`parent: system.admin_config_regional`, `.links.menu.yml`).
- `AnalogDigitalClock` extends `ConfigFormBase` (`src/Form/AnalogDigitalClock.php`):
  - `getEditableConfigNames()` → `['analog_digital_clock.settings']`.
  - `buildForm()` renders one `#type => radios` element `analog_digital_clock_skin` with options
    `1` Simple digital clock with date, `2` 24 hr Digital clock with date, `3` Analog clock,
    `4` Animated digital clock. Default is the stored value or `1`.
  - `submitForm()` writes `analog_digital_clock_skin` back to the config object and saves.
- Being a `ConfigFormBase`, the form carries core's form token (CSRF) automatically.

## Config object & schema

- Config name **`analog_digital_clock.settings`**; single key `analog_digital_clock_skin`.
- Install default: `analog_digital_clock_skin: 1` (`config/install/analog_digital_clock.settings.yml`).
- Schema: `analog_digital_clock_skin` is typed `string` (`config/schema/analog_digital_clock.schema.yml`).
  The radios constrain saved values to the strings `'1'`–`'4'`.
- Set via CLI: `drush cset analog_digital_clock.settings analog_digital_clock_skin 3 -y`.

## The block

- Plugin `AnalogDigitalClockSkin` (`src/Plugin/Block/AnalogDigitalClockSkin.php`), id
  **`analog_digital_clock_skin`**, admin label *"Analog Digital Clock"*. Implements
  `ContainerFactoryPluginInterface`; injects `config.factory`.
- `build()` returns a render array: `#theme => 'analogDigitalLightDarkSkin'`,
  `#analog_digital_clock_selected_skin =>` the stored skin value, and **`#cache => ['max-age' => 0]`**
  (uncached, so the markup is always emitted; the actual ticking is client-side JS).
- Place it via **Structure → Block layout** in any region. It has no per-block settings — the skin
  comes from the global config object, so all placements share one skin.

## Theme & libraries

- `analog_digital_clock_theme()` (`.module`) registers hook `analogDigitalLightDarkSkin` with one
  variable `analog_digital_clock_selected_skin` (default NULL). Template
  `templates/analogDigitalLightDarkSkin.html.twig`.
- The template branches on the numeric skin value (`== 1..4`) and, per branch, `attach_library()`s
  the matching library and emits static markup (div wrappers, or an inline SVG clock face for
  skin 3). The skin value is only used in numeric comparisons and to pick a library — it is not
  printed into markup.
- Libraries (`.libraries.yml`, all depend on `core/jquery` + `core/drupal`):
  - `analog_digital_am_pm` → `js/analog_digital_ap_pm.js` + `css/analog_digital_am_pm.css` (skin 1).
  - `analog_digital_twenty_four` → `js/analog_digital_twentyfour_hr.js` + same CSS (skin 2).
  - `analog_digital_clock_circle` → `js/analog_digital_clock_circle.js` + `/libraries/snap.svg/snap.svg-min.js` (skin 3).
  - `analog_digital_animated_clock` → `js/analog_digital_animated.js` + same CSS (skin 4).
- All clock logic runs in `Drupal.behaviors.*` using the browser's `new Date()` (client/system
  time), not server time. Override the Twig template to restyle output.

## Permissions note

The module declares a permission `administer analog_digital_clock` (`.permissions.yml`,
`restrict access: TRUE`), but nothing references it — the settings route is gated by core's
`administer site configuration`. Assigning the declared permission grants no access on its own.

## Help

`analog_digital_clock_help()` prints a static About/skins list on `help.page.analog_digital_clock`.
