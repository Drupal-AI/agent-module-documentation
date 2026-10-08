# UI Skins — settings & storage

No `configure` route in info.yml. Two entry points, both gated by core `administer themes`:

| Route | Path | Form / controller |
|---|---|---|
| `ui_skins.overview` | `/admin/appearance/css-variables` | System admin menu block (lists themes). |
| `ui_skins.css_variables.theme_settings` | `/admin/appearance/css-variables/{theme}` | `CssVariablesThemeSettingsForm` — edit CSS variable values per scope. |

Additionally, `FormSystemThemeSettingsAlter` (`hook_form_system_theme_settings_alter`) adds a **Theme**
(skin) `select` to each theme's own settings form (`/admin/appearance/settings/{theme}`), whose options
are the `ui_skins.themes` plugins for that theme.

The per-theme CSS-variables route is derived by `Plugin/Derivative/CssVariables` for every installed
theme that has at least one applicable CSS variable plugin (menu/local-task links).

## Where values are stored

In the **theme's own** config `{theme}.settings`, under third-party settings key `ui_skins`
(schema `ui_skins.schema.yml`, `theme_settings.third_party.ui_skins`):

```yaml
# e.g. olivero.settings
third_party_settings:
  ui_skins:
    theme: "dark"                 # selected skin (a ui_skins.themes plugin id)
    css_variables:
      color_primary:              # css variable plugin id
        "%root": "#0066ccff"      # scope key: dots stored as "%" (getConfigScopeName), so ":root" → ":%root"
```

Notes on the CSS variables form (`CssVariablesThemeSettingsForm`):
- Reads current values via `ThemeSettingsProvider` for `{theme}`; groups plugins by `category` into
  vertical tabs when there is more than one group.
- Each plugin shows one row per scope: a **Scope** textfield (the CSS selector) + a **Value** input of
  the plugin's `type`. Default scopes (from `default_values`) are shown disabled; "Add new scope"
  (AJAX) appends editable rows.
- On save, `filterPluginValues()` drops rows with an empty scope and drops values equal to the plugin
  default (so config only stores real overrides). Scope dots are encoded to `%` for config storage.

## Programmatic set

```php
$t = \Drupal::configFactory()->getEditable('olivero.settings');
$tp = $t->get('third_party_settings') ?? [];
$tp['ui_skins']['css_variables']['color_primary'][':%root'] = '#0066ccff';
$tp['ui_skins']['theme'] = 'dark';
$t->set('third_party_settings', $tp)->save();
```
