<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Bootstrap Buttons plugin

There is no site-wide admin form. You configure it per **text format / editor**:
`/admin/config/content/formats` → edit a format that uses **CKEditor 5** → drag the
**Bootstrap Buttons** item from *Available* into the *Active toolbar* → a
**Bootstrap Buttons** vertical tab appears under the toolbar with the settings below.

Config is stored on the `editor.editor.<format>` entity under
`settings.plugins.c5bb_bbutton` (schema `ckeditor5.plugin.c5bb_bbutton`).

## Settings

| Key | Form field | Type | Default |
|---|---|---|---|
| `classes` | Class Selectors | textarea | see below |
| `textClass` | Text Class | textfield | `text` |
| `showIconSettings` | Show Icon Settings | checkbox | `1` |

- **`classes`** — defines the grouped dropdowns shown in the button dialog. Line syntax:
  a line with no leading `-` is a **group label**; a line `- Label|css-class` is an **option**
  under the current group (empty class after `|` = no class). `getDynamicPluginConfig()` parses
  this into `selectors: [{label, options:[{value,label}]}]` for the JS. Default value:
  ```
  Size
  - Small|btn-sm
  - Normal|
  - Large|btn-lg
  Style
  - Primary|btn-primary
  - Secondary|btn-secondary
  Color
  - Light|
  - Dark|dark
  ```
- **`textClass`** — CSS class put on the inner `<span>` wrapping the button label. On submit it is
  passed through `Html::getClass(trim(...))`, so only a single sanitized class token is stored.
- **`showIconSettings`** — when on, the button dialog exposes a Glyphicon / Font Awesome icon UI.

## Notes

- The plugin's `getElementsSubset()` returns `<a>`, `<a class target href>`, `<em>`, `<em class>`,
  `<span>`, `<span class>` — the format's allowed-HTML filter must permit these (adding the button
  updates the format's tags automatically in the CKEditor 5 UI).
- If the `fontawesome` module is enabled with a `method` other than `webfonts`, the settings form
  renders a red warning linking to the Font Awesome settings — icons need the webfonts method.
- Bootstrap's own button CSS must come from your theme/base CSS; c5bb only adds an editor-preview
  stylesheet and admin styles.
