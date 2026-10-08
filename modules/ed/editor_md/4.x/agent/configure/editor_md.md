<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Editor.md

**Prerequisites**
- Install the JS library at `/libraries/editor.md` (the module's fork is recommended). `editormd.min.js`, CSS and `languages/en.js` are loaded from there.
- `composer require drupal/markdown` and enable it — it provides the Markdown filter that turns stored Markdown into HTML.

**Enable the editor on a format**
1. Go to *Configuration > Content authoring > Text formats and editors* (`/admin/config/content/formats`).
2. Configure (or add) a format and set **Text editor** to *Editor.md*.
3. In the **Text format** filters, enable the Markdown filter (from the `markdown` module) so output is converted to HTML, plus *Limit allowed HTML tags* to bound what the converted HTML may contain.
4. Configure Editor.md settings (vertical tabs):
   - **General** — mode (`gfm`/`markdown`), width, height, watch/preview.
   - **Themes** — container theme (light/dark), CodeMirror editor theme, preview theme.
   - **Toolbar** — enabled, auto-fixed, mode (full/simple/mini/custom); for *custom* enter a CSV of icon names (pipe `|` for separators).
5. Save.

**Security note:** because the editor is `is_xss_safe = FALSE`, never grant the format to untrusted roles without the Markdown filter + an HTML restriction filter — the module stores raw Markdown and relies entirely on the format's filters for output sanitization.