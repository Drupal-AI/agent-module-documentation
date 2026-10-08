# Defining and arranging switchable styles

A "style" is a named CSS variant a visitor can switch to. Styles come from two sources, merged
at runtime (`styleswitcher_style_load_multiple()` = `styleswitcher_custom_styles()` +
`styleswitcher_theme_styles($theme)`):

1. **Custom styles** — added by an admin, stored in config, available to **all** themes.
2. **Theme-provided styles** — declared in a theme's `.info.yml`, available only to that theme
   and its sub-themes.

A permanent **blank style** `custom/default` (label "Default", `path: null`) always exists; it
removes the effect of other alternate stylesheets rather than adding one. It cannot be deleted.

All admin surfaces require the `administer styleswitcher` permission. Entry point:
`/admin/config/user-interface/styleswitcher` (route `styleswitcher.admin`,
form `\Drupal\styleswitcher\Form\StyleswitcherAdmin`).

## 1. Custom styles (admin-defined)

Add/edit form `\Drupal\styleswitcher\Form\StyleswitcherStyleForm`:
- Add: `styleswitcher.style_add` → `/admin/config/user-interface/styleswitcher/add`
- Edit: `styleswitcher.style_edit` → `/…/custom/{style}` (`{style}` upcasts via the ParamConverter)
- Delete: `styleswitcher.style_delete` → `/…/custom/{style}/delete`
  (confirm form `StyleswitcherStyleDeleteForm`; blank style cannot be deleted)

| Field | Element | Notes |
| --- | --- | --- |
| Title | textfield, required | Human-readable label; trimmed on submit. |
| Machine name | machine_name | Prefixed `custom/`; lowercase/numbers/underscores; uniqueness via `StyleswitcherStyleForm::exists()`. |
| Path | textfield, required | CSS file path **relative to site root** OR an external CSS URL. |

Path validation (`validateForm()`): empty → stored as `NULL` (blank style); otherwise the value must
either be an existing file (`is_file($path)`) or an external URL (`UrlHelper::isExternal($path)`),
else `"Stylesheet file %path does not exist."`. Renaming a style warns that visitors on the old name
fall back to the default until they re-pick; the rename also rewrites keys in `styles_settings`.

Stored in config object **`styleswitcher.custom_styles`**, key `styles` (sequence keyed by machine
name), each item `{name, label, path}`.

### Set custom styles via PHP

```php
$config = \Drupal::configFactory()->getEditable('styleswitcher.custom_styles');
$styles = $config->get('styles') ?: [];
$styles['custom/high_contrast'] = [
  'name' => 'custom/high_contrast',
  'label' => 'High contrast',
  'path' => 'sites/default/files/styleswitcher/high-contrast.css', // or an external https URL
];
$config->set('styles', $styles)->save();
```

Or via Drush: `drush config:set styleswitcher.custom_styles styles.custom/high_contrast.label 'High contrast'`
(set `name`, `label`, `path` sub-keys). Drush cex/cim export and import all three config objects.

## 2. Theme-provided styles (.info.yml)

A theme (or base theme) exposes styles under a `styleswitcher:` key. Read by
`styleswitcher_theme_styles()`; external paths pass through `UrlHelper::isExternal()`, relative
paths are prefixed with the theme path. Machine names become `theme/<transliterated-label>`.

```yaml
# my_theme.info.yml
styleswitcher:
  css:
    Light Blue: css/blue.css
    All Black: css/black.css
  default: All Black   # optional; the initial style for new visitors
```

`default` may name one of the `css` entries or be a standalone path (becomes `theme/default`).
If a theme declares its own default, the blank `custom/default` style is auto-disabled for that
theme (`styleswitcher_styles_settings()`).

## 3. Per-theme arrangement (enable / order / default)

Form `\Drupal\styleswitcher\Form\StyleswitcherConfigTheme`, route `styleswitcher.config_theme`
→ `/admin/config/user-interface/styleswitcher/settings/{theme}`. Local-task tabs are generated per
installed theme with a UI by `\Drupal\styleswitcher\Plugin\Derivative\ThemeLocalTask`. The route
carries `_access_theme: 'TRUE'` (core theme-access check) plus the admin permission, and the form
404s if `themeHandler->hasUi($theme)` is false — so only real, admin-visible themes are configurable.

Per style, per theme you set: **weight** (drag order), **enabled** (checkbox — the default style is
force-enabled), **default** (radio). Saved to config object **`styleswitcher.styles_settings`**,
key `settings` → `settings[<theme>][<style_name>] = {weight:int, status:bool, is_default:bool}`.
`hook_themes_uninstalled` (`styleswitcher_themes_uninstalled`) prunes settings for removed themes.

## Config schema (config/schema/styleswitcher.schema.yml)

- `styleswitcher.custom_styles`: `styles` sequence of `{name, label, path}` strings.
- `styleswitcher.styles_settings`: `settings` nested sequence → mapping `{weight:int, status:bool, is_default:bool}`.
- `styleswitcher.settings`: `{enable_overlay:bool, 7206_theme_default:string}` (see configure/settings.md).

## Runtime resolution

`styleswitcher_default_style_key($theme)` picks the default: admin-set default → theme-declared
default → blank style, in that order. The block only shows styles with `status = TRUE`, and only
when more than one exists. Sorting uses `styleswitcher_sort()` (weight, then insertion index `_i`).
