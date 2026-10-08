<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cosesi — configuration & theme settings

## Install / enable

`drush en cosesi` (or via UI). Requires PHP `>= 8.4`, core `^11.3`, and the core `config` module
(`cosesi.info.yml` `dependencies: [drupal:config]`). No install hook seeds data — `config/install/cosesi.theme_settings.yml`
ships `themes: {}` (empty). Uninstall clears per-theme settings (see hooks below).

## Config object: `cosesi.theme_settings`

`type: config_object` (schema `config/schema/cosesi.schema.yml`). Shape:

```
themes:
  <theme_id>:
    switcher:
      variableName: color-scheme          # CSS custom property name (no leading --)
      states:
        light:  { htmlClass, hideClass }
        system: { htmlClass }             # system has NO hideClass
        dark:   { htmlClass, hideClass }
```

Schema notes:
- `variableName`, and every `htmlClass`/`hideClass`, are validated by a `Regex` constraint
  `^[a-zA-Z0-9][a-zA-Z0-9_-]*$` (must be a valid CSS variable/class name).
- `themes` sequence keys must be non-blank (`ValidSequenceKeys` → `NotBlank`).
- Schema also declares `theme_settings.third_party.cosesi` (type `cosesi.theme_settings_single`) —
  intended third-party settings on `theme.settings`; see the core issues referenced in `README.md`.

Defaults if a theme has no stored settings come from `ThemeSettings\Provider::getDefaultSwitcherSettings()`:
`variableName: color-scheme`; light `color-scheme-light`/`color-scheme-only-light`;
system `color-scheme-system` (empty hideClass); dark `color-scheme-dark`/`color-scheme-only-dark`.

## Settings form

- Route `cosesi.theme_settings.edit` → path `/admin/appearance/cosesi-theme-settings`,
  form `Drupal\cosesi\ThemeSettings\EditForm` (extends `ConfigFormBase`), permission `administer themes`
  (`cosesi.routing.yml`). Shown as a local task under the appearance page (`cosesi.links.task.yml`,
  base_route `system.themes_page`).
  NOTE: `README.md` lists `/admin/config/cosesi/theme-settings`; the actual route path is the appearance one above.
- `EditForm::buildForm()` renders one `details` group per theme already present in config, plus a
  "Setup a new theme" group listing themes not yet configured (`getThemeOptions()`; installed themes
  come from `ThemeExtensionList`). Existing fields bind via `ConfigTarget` to
  `themes.<id>.switcher.*`; the `_new` group has no config target and is copied to the chosen theme id
  in `submitForm()`.
- `submitForm()` writes each theme's six values; if all six are empty it calls
  `$config->clear("themes.$themeId")` (removes the theme). After save it links to
  `config.export_single` for `cosesi.theme_settings` when the user has access.
- Field `#pattern` HTML attributes are pulled live from the typed-config `Regex` constraint definitions.

## Lifecycle hooks

- `src/Hook/ExtensionLifeCycleHooks::themesUninstalled()` (`#[Hook('themes_uninstalled')]`) — removes
  `themes.<name>` entries for uninstalled themes. (Note: it opens config name `cosesi_theme_settings`
  — no dot — rather than `cosesi.theme_settings`.)
- `cosesi_uninstall()` in `cosesi.install` delegates to `ExtensionLifeCycleHooks::uninstall()`
  (method not defined on the class in this release).

## Drush

Hidden, development-only command `cosesi:build` (`src/Drush/Commands/BuildCommand.php`,
`DrupalBootLevels::NONE`) — optimises the SVG icons with Inkscape/SVGO and rebuilds `logo.png`
with pngquant. Not for production use.
