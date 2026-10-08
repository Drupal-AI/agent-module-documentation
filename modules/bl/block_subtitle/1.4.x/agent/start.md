<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Subtitle (block_subtitle) — agent index

Adds a "subtitle" (a second line of text) to **any block plugin's** configuration. Stored as a
third-party setting on the `block` config entity, so it works on system, views, menu, and custom
blocks alike — no custom block type or per-block template override needed. Depends on core `block`.
Core requirement `^8 || ^9 || ^10 || ^11`.

Whole module is one `.module` file plus a permission and a config-schema entry — no routes, no
`src/`, no settings page (`configure` is null). The subtitle is set on the standard block
configuration form and exposed to the block template for the theme to render.

- **Set / read a block's subtitle (form, drush, PHP)** → [configure/subtitle.md](configure/subtitle.md)
- **Render the subtitle in a theme** → [theme/subtitle.md](theme/subtitle.md)
- **Who may set subtitles** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission gating the form field: **`administer block subtitle`** (separate from core
  `administer blocks`, which is still required to reach the block form at all).
- Third-party setting: provider `block_subtitle`, key `subtitle`.
- Config-schema key: `block.block.*.third_party.block_subtitle` → `subtitle` (`type: text`).
- Form field on `block_form`: `settings.block_subtitle_text` (`#parents: [block_subtitle_text]`).
- Template variable exposed by `hook_preprocess_block`: `subtitle`.
- Hooks: `hook_form_block_form_alter`, `hook_block_presave`, `hook_preprocess_block`, `hook_help`.
- `.info.yml` reports the legacy `version: '8.x-1.4'` (branch `1.4.x`).
