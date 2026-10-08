<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Color Button integrates the third-party CKEditor 4 "Color Button" plugin so editors can apply text and background colors from the toolbar.

---

This module registers a `CKEditorPlugin` (`src/Plugin/CKEditorPlugin/ColorButton.php`) that exposes the toolbar buttons `TextColor` and `BGColor` for Drupal's core **CKEditor 4** editor. The actual JavaScript comes from the upstream CKEditor Color Button add-on (v4.5.6+), which you download and place in `/libraries/colorbutton/plugin.js`; `colorbutton.install` implements `hook_requirements()` to verify the library is present. It depends on the Panel Button module, which provides the shared floating-panel UI the color picker uses.

Configuration is per text format via the CKEditor toolbar builder: drag the Text Color and/or Background Color buttons into the active toolbar. A settings pane lets you supply a comma-separated list of allowed hex colors (leave blank to use the plugin defaults) and the number of colors per row. Because both buttons emit inline `style` attributes on `<span>` tags, they only work in formats where "Limit allowed HTML tags" is off or where `<span style>` is explicitly allowed. Config schema lives in `config/schema/colorbutton.schema.yml`. Note this is a CKEditor 4 module; CKEditor 4 was removed from Drupal core in Drupal 10, so it applies only to sites still running the contrib CKEditor 4 editor.

---

- Add a text-color button to a CKEditor toolbar
- Add a background-color button to a CKEditor toolbar
- Restrict editors to a curated palette of hex colors
- Set how many color swatches appear per row
- Use the plugin's default color palette
- Enable colors only for specific text formats
- Allow `<span style>` so inline colors survive filtering
- Give editors brand-approved color choices
- Combine text and background color for highlighted callouts
- Keep color styling inline for email-safe HTML
- Pair with Panel Button for the color picker panel UI
- Verify the plugin library is installed via status report
- Provide a WYSIWYG color picker without custom JS
- Limit color usage to enforce a design system
- Highlight key text with a coloured background inline
- Apply consistent brand colours across articles
- Offer a small fixed palette to non-technical editors
- Style callout boxes with background colour in the body field
- Detect a missing plugin library via `hook_requirements()`
- Roll out colour controls on a single dedicated text format
