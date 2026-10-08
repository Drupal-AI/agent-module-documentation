<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# altcolor — configuring & operating colors

## Install / enable

`drush en altcolor -y`. No module config object is created. The module does nothing visible until
the active (or any enabled) theme provides a `THEME.colors.yml` (see
[../plugins/theme-colors.md](../plugins/theme-colors.md) for that file format).

## Where you configure it

There is **no dedicated route** (`configure` is null). The UI is grafted onto core's theme
settings form. Go to **Appearance → Settings → <theme>** (route `system_theme_settings`, path
`/admin/appearance/settings/<theme>`, permission **`administer themes`**). If that theme defines
colors, a **"Color scheme"** `details` element (`#id = altcolor_form`) appears with:

- a **Color scheme** `select` — options built from the theme's `schemes` (`label` column), plus an
  empty **"Custom"** option;
- one **`#type => color`** field per configurable color, keyed by variable name, defaulting to the
  saved value or the first scheme's value (`ColorForm::altcolorPaletteColorValue`);
- a **live preview iframe** pointing at `<front>?altcolor_preview=1`.

Chosen `schemes` are passed to JS via `drupalSettings.altcolor.colorSchemes`; picking a scheme
fills the color fields client-side (`js/altcolor_admin.js`), and `js/altcolor_preview.js` +
library `altcolor/altcolor.preview` update the iframe live.

## How the form saves (AltColorFormHooks)

`src/Hook/AltColorFormHooks.php`:

- `formSystemThemeSettingsAlter($form, $form_state, $form_id)` — only acts when
  `$build_info['args'][0]` (the theme name) is set and
  `AltColorPluginManagerInterface::getColorDefinitionsByTheme($theme)->getColors()` is non-empty.
  It class-resolves `ColorForm` (form id `altcolor_settings`), calls its `buildForm([], …, $theme)`,
  merges the result into `$form`, and `array_unshift`es `formSystemThemeSettingsSubmit` to the
  front of `$form['#submit']`.
- `formSystemThemeSettingsSubmit()` runs **before** core's handler and relocates the values:
  `$values['third_party_settings']['altcolor']['colors'] = $values['altcolor']['colors']`, then
  `unsetValue('altcolor')` so the raw key is not saved. Core's `ThemeSettingsForm::submitForm()`
  then persists everything into the theme's settings config.

Result: colors live at **`<theme>.settings : third_party_settings.altcolor.colors`** (a map of
`variable => value`). `ColorForm` itself extends `ConfigFormBase` but its `getEditableConfigNames()`
returns `[<theme>.settings]` and it is only ever used as an embedded fragment — the actual save is
done by the core theme settings form.

## Config schema

`config/schema/altcolor.schema.yml` extends the theme settings mapping:

```yaml
theme_settings.third_party.altcolor:
  type: mapping
  mapping:
    colors:
      type: sequence
      sequence:
        type: color_hex
```

So each stored color is typed `color_hex`. Values export/import with the theme's config.

## How colors reach the page (AltColorPreprocessHooks)

`src/Hook/AltColorPreprocessHooks.php::preprocessHtml(&$variables)` (`#[Hook('preprocess_html')]`):

1. Get the active theme; fetch its color definition via
   `AltColorPluginManager::getColorDefinitionsForActiveTheme()`. Bail if none / no colors.
2. Read saved colors: `theme_get_setting('third_party_settings.altcolor.colors', $theme) ?? []`.
3. Build `CacheableMetadata` from the render array, add the **`theme`** cache context, and add the
   `<theme>.config` object as a cacheable dependency.
4. Invoke `hook_altcolor_alter_colors($theme, &$colors, &$cacheableMetadata)` (see
   [../api/alter-colors.md](../api/alter-colors.md)).
5. Concatenate `--color-$variable: $value;` for each color and set it as the `<html>` element's
   `style` attribute (`$variables['html_attributes']->setAttribute('style', $style)`).

`AltColorHooks::themeRegistryAlter` (`#[Hook('theme_registry_alter')]`) moves
`altcolor_preprocess_html` to the **end** of the `html` hook's preprocess list so its variables win
over the theme's own. `themesInstalled` / `themesUninstalled` call
`AltColorPluginManager::clearCachedDefinitions()` to refresh discovery when the theme set changes.

## Theme-builder contract

Define your CSS defaults with the same variable names the module emits:

```css
:root { --color-base_primary_color: yellow; }
body  { background-color: var(--color-base_primary_color); }
```

Once an admin picks a color, the `<html style>` declaration overrides the `:root` default. (Note:
the variable name is used verbatim, so match the key you declared in `THEME.colors.yml`.)
