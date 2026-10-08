<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable UI Styles in a CKEditor 5 text format

No dedicated route or settings page. Everything is configured on a **text format's** CKEditor 5
toolbar (*Configuration → Content authoring → Text formats and editors* →
`/admin/config/content/formats/manage/<format>`).

## The two buttons

`ui_styles_ckeditor5.ckeditor5.yml` declares two plugins, each adding a toolbar item:

| plugin id | toolbar item | effect | allowed elements |
|---|---|---|---|
| `ui_styles_ckeditor5_uiStylesBlock` | `UiStylesBlock` | class on the current block element | `<$any-html5-element class>` |
| `ui_styles_ckeditor5_uiStylesInline` | `UiStylesInline` | wrap selection in a styled `<span>` | `<$any-html5-element class>`, `<span>` |

## Enable it

1. Add the **UI Styles (block)** and/or **UI Styles (inline)** button to the format's *Active
   toolbar* by dragging it in.
2. A vertical-tab settings section appears; tick the UI Styles you want that button to offer
   (styles are grouped by category).
3. Save the text format.

## Where it is stored

In the editor config `editor.editor.<format>`:

```yaml
# editor.editor.basic_html
settings:
  toolbar:
    items:
      - UiStylesInline          # (or UiStylesBlock)
  plugins:
    ui_styles_ckeditor5_uiStylesInline:
      enabled_styles:
        - text_color            # style plugin ids offered by this button
        - highlight
```

`enabled_styles` is a sequence of **style plugin ids** (schema
`ui_styles_ckeditor5_ckeditor5_plugin`; a `NotBlank` constraint means: enable at least one style
or remove the button). The block button uses key
`settings.plugins.ui_styles_ckeditor5_uiStylesBlock.enabled_styles`.

## Read it back

```bash
drush cget editor.editor.basic_html settings.plugins
```

## Runtime

The JS plugins (`js/build/uiStylesBlock.js`, `uiStylesInline.js`) apply the selected style's CSS
class to the block or to a `<span>`. The editor iframe preview uses the UI Styles stylesheet
generator so the classes render as they will on the front end.
