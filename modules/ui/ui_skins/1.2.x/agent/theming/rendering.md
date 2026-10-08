# UI Skins — how values reach the page

Three hooks (attribute-based `#[Hook(...)]` classes in `src/Hook/`).

## Inline CSS variables — `hook_page_top` (`PageTop`)

Reads `{active_theme}.settings` third-party `ui_skins.css_variables`, regroups the saved values by
scope, and emits one `#type => 'html_tag'` `<style>` element whose value is built by
`UiSkinsUtility::getCssVariablesInlineCss()`:

```
<selector>{--var-name:value;--other:value;}<selector2>{...}
```

Cached against cache tag `config:{theme}.settings`. Only scalar values are emitted.

## Body/HTML attributes + libraries — `hook_preprocess_html` (`PreprocessHtml`)

Reads the selected skin (`ui_skins.theme` setting), resolves it plus its dependency chain via
`ThemePluginManager::getDefinitionWithDependencies()`, and for each definition merges
`{key: value}` into `$variables['attributes']` or `$variables['html_attributes']`
(`AttributeHelper::mergeCollections`). `key: class` values are run through `Html::getClass()`. Any
`library` on a definition is added to `#attached['library']`.

## `hook_form_system_theme_settings_alter` (`FormSystemThemeSettingsAlter`)

Adds the skin-selection `select` to a theme's settings form (see configure/theme-settings.md).

## Where the inline CSS values come from

`getCssVariablesInlineCss()` builds the inline `<style>` from the stored scope selector and variable
values. These values are written through the `administer themes` theme-settings UI (a
`restrict access: true` core permission).
