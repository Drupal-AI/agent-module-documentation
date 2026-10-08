<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & generate the icon font

Route `custom_bootstrap_icon_font.generate` → `/admin/config/media/bootstrap-icon-font`
(permission `administer custom bootstrap icon font`). Form: `CustomBootstrapIconFontGenerateForm`.

## Config: `custom_bootstrap_icon_font.settings`
- `bootstrap_icons` / `fontawesome_icons` — selected icon lists (accept name, `bi bi-*` class, or pasted `<i>` HTML).
- `codepoints` — persisted glyph → Unicode map (keeps values stable across rebuilds).
- `font_name` — output font-family (default `custom-bootstrap-icons`).
- `icons_source_dir` / `fontawesome_icons_source_dir` — where SVGs live (default `libraries/bootstrap-icons/icons`, `libraries/fontawesome/icons`).
- `generator_command` — default `npx fantasticon`; run via `Process(preg_split('/\s+/', $cmd))`.
- `version` — integer, incremented each build; used as `?v=` CSS cache-buster.

## Build flow
1. Ensure source SVG libraries exist under `web/libraries/…`.
2. Select icons on the form; save.
3. Build via the UI button (dev) or Drush (CI). Fantasticon must be installed (`npm install --save-dev fantasticon`).
4. Output goes to `public://custom_bootstrap_icon_font/font/` — `hook_page_attachments()` attaches the CSS automatically.

## Usage in markup
Generated CSS maps `.di-<icon>` to a glyph: `<span class="di-arrow-right-circle-fill"></span>`. A Twig helper is also provided.
