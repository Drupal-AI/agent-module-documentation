<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Bootstrap Buttons (c5bb) adds a "Bootstrap Buttons" toolbar button to CKEditor 5 that lets editors insert and style links as Bootstrap-style buttons, choosing from configurable class groups (size, style, colour, etc.) and optional icons.

---

The module ships a single CKEditor 5 plugin (`c5bb_bbutton`, class `Drupal\c5bb\Plugin\CKEditor5Plugin\C5BB`, JS plugin `bbutton.BButton`) that registers a `BButton` toolbar item. It is configurable per text format: on *Configuration → Content authoring → Text formats and editors*, add the button to a format's CKEditor 5 toolbar and open its settings to define **Class Selectors** (a textarea using a `Label` / `- Option|css-class` line syntax that becomes grouped dropdowns in the button dialog), a **Text Class** applied to the button's inner `<span>`, and a **Show Icon Settings** toggle enabling a Glyphicon/Font Awesome picker UI. `getDynamicPluginConfig()` parses the class textarea into selector groups passed to the JS; `submitConfigurationForm()` sanitizes the text class with `Html::getClass()`. The plugin declares the HTML elements it needs (`<a class href target>`, `<em class>`, `<span class>`) so the text format's allowed-tags filter permits them. Bootstrap CSS is not bundled — the module only injects its own editor stylesheet (`css/cke5.css` via `ckeditor5-stylesheets` and `hook_css_alter`) and admin styles; your theme must provide the actual Bootstrap button CSS on the front end. If the Font Awesome module is present but not using the "webfonts" method, the settings form shows a compatibility warning.

---

- Add a toolbar button to CKEditor 5 for inserting styled Bootstrap buttons.
- Turn a selected link into a `btn btn-primary`-style call-to-action without hand-editing source.
- Offer editors a curated dropdown of button sizes (Small `btn-sm`, Normal, Large `btn-lg`).
- Offer button style/colour class groups (Primary, Secondary, etc.) defined per text format.
- Define custom class groups using the `Group` heading + `- Label|class` line syntax.
- Apply a consistent inner text wrapper class (`Text Class`) to every button's `<span>`.
- Enable a Glyphicon / Font Awesome icon picker inside the button dialog via Show Icon Settings.
- Open button links in a new tab (the plugin allows `<a target>`).
- Provide different button class palettes for different text formats (e.g. Full HTML vs. Basic).
- Keep editor markup clean by letting the plugin declare the exact allowed `<a>/<em>/<span>` attributes.
- Preview button styling inside the editor using the module's `cke5.css` editor stylesheet.
- Standardize marketing CTAs across a site's rich-text content.
- Let non-technical editors pick brand colours without typing CSS class names.
- Warn admins when a Font Awesome method incompatible with the button icons is configured.
- Combine size + style + colour dropdowns into a single button-insertion dialog.
- Restrict which roles can use buttons by adding the toolbar item only to trusted text formats.
- Reuse the same button configuration across content types that share a text format.
- Build accordion/hero CTAs that rely on Bootstrap button classes already in the theme.
