<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Bootstrap Icon Font builds a lightweight custom webfont (WOFF2 + optional WOFF) and matching CSS from only the Bootstrap Icons and/or Font Awesome Free SVGs a site actually uses.
---
Instead of shipping an entire icon set, an admin selects a subset of icons (by name, by class, or by pasting `<i class="bi ...">` snippets) on the admin form, and the module runs a font generator (Fantasticon, invoked as `npx fantasticon` by default) to produce a compact font written to `public://custom_bootstrap_icon_font/font/`. Codepoints are persisted in config so re-adding an icon keeps its stable glyph value across rebuilds. The generated CSS maps `.di-<icon>` classes to glyphs via `::before { content: "\eNNN" }`, and `hook_page_attachments()` auto-attaches that CSS on the frontend (with a `?v=` cache-buster) only when the file exists.

Building can be triggered from the admin UI button (handy for local/dev) or via a Drush command (recommended for CI). Source SVGs are expected under `web/libraries/bootstrap-icons/icons` and `web/libraries/fontawesome/icons`. The generator command is stored in config (`generator_command`, default `npx fantasticon`) and executed with Symfony `Process` using an **argument array** (`preg_split` on whitespace) rather than a shell string, so there is no shell interpolation; the whole surface is gated behind the dedicated `administer custom bootstrap icon font` permission (`restrict access: TRUE`). A Twig extension provides helpers to render icon markup in templates.
---
- Select the exact Bootstrap Icons your theme needs and generate a slim font.
- Add Font Awesome Free icons to the same custom font by pasting their classes.
- Paste `<i class="bi bi-arrow-right-circle-fill"></i>` snippets to add icons by markup.
- Generate the WOFF2 font from the admin UI button during local development.
- Run the Drush build command in CI to regenerate the font on deploy.
- Keep stable glyph codepoints across rebuilds so cached CSS keeps working.
- Auto-attach the generated icon CSS on the frontend without theme edits.
- Render icons in Twig templates using the module's Twig helper functions.
- Configure the output font-family name (default `custom-bootstrap-icons`).
- Point the module at custom SVG source directories for icons.
- Change the generator command (e.g. a path to a local fantasticon binary).
- Preview available icons with pagination on the admin form.
- Cut page weight by shipping only used glyphs instead of a full icon library.
- Restrict font generation to trusted admins via the dedicated permission.
- Bust browser cache automatically via the incrementing `version` config value.
- Store selected icons per source (Bootstrap vs Font Awesome) separately.
- Reference generated `.di-<icon>` CSS classes in content and templates.
- Regenerate after adding new icons to extend the existing font set.