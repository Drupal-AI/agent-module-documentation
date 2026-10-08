<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable UI Styles buttons on a text format

Enable with `drush en ui_styles_ckeditor5` (needs `ckeditor5` + `ui_styles`). Configure per
text format at *Configuration → Text formats and editors → (a CKEditor 5 format)*.

## The two plugins / toolbar items

Declared in `ui_styles_ckeditor5.ckeditor5.yml`:

| CKEditor 5 plugin id | toolbar item | class | config key | allowed elements |
|---|---|---|---|---|
| `ui_styles_ckeditor5_uiStylesBlock`  | `UiStylesBlock`  | `UiStylesBlock` (final, extends `UiStylesBase`)  | `uiStylesBlock`  | `<$any-html5-element class>` |
| `ui_styles_ckeditor5_uiStylesInline` | `UiStylesInline` | `UiStylesInline` (final, extends `UiStylesBase`) | `uiStylesInline` | `<$any-html5-element class>`, `<span>` |

Drag the toolbar item into the active toolbar to reveal its settings vertical tab.

## Choosing which styles appear

`UiStylesBase::buildConfigurationForm()` lists all `getGroupedDefinitions()` as checkboxes
grouped by category (a group opens if it has an enabled style). `validateConfigurationForm()`
flattens the checked ids and `submitConfigurationForm()` stores them:

```
editor.editor.<format>:
  settings:
    plugins:
      ui_styles_ckeditor5_uiStylesBlock:
        enabled_styles: [text_color, spacing]
      ui_styles_ckeditor5_uiStylesInline:
        enabled_styles: [inline_emphasis]
```

Schema `ui_styles_ckeditor5_ckeditor5_plugin` — `enabled_styles` is a `NotBlank` sequence of
strings ("Enable at least one style, otherwise disable the UI Styles button.").

## Runtime

- `getDynamicPluginConfig()` builds, per enabled style, an options list of
  `{name: label, classes: [...], excluded_classes: [...]}` under `config[<ckeditor5ConfigKey>]`
  (`uiStylesBlock` / `uiStylesInline`). `excluded_classes` are the other options' classes so
  selecting one option removes the sibling classes.
- `getElementsSubset()` removes the wildcard `<$any-html5-element class>` and re-adds a
  concrete `<$any-html5-element class="c1 c2 …">` limited to the enabled styles' classes
  (`getEnabledStylesClasses()`), so the text-format filter only permits those classes.
- The JS plugins (`js/build/uiStylesBlock.js`, `uiStylesInline.js`) render the dropdown and
  apply/remove classes on the model.
