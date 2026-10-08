<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Juicebox (4.0.x) — agent index

Renders image/file/media fields (or Views rows) as a responsive Juicebox HTML5 gallery.
Two plugins do the work: a **field formatter** and a **Views style**. Needs the external
Juicebox JS library placed under `/libraries/juicebox/` for a *live* gallery; all
configuration below works without it.

- **Set up a gallery display, global settings, image styles** → [configure/juicebox.md](configure/juicebox.md)
- **The plugins (`juicebox_formatter` formatter + `juicebox` Views style) and their settings keys** → [plugins/juicebox.md](plugins/juicebox.md)

Quick facts:
- Field formatter id: `juicebox_formatter` (label "Juicebox Gallery"), field types: `image`, `file`, `entity_reference`.
- Views style id: `juicebox` (title "Juicebox Gallery").
- Global config: object `juicebox.settings`; form `juicebox.admin_settings` at `/admin/config/media/juicebox` (permission: `administer site configuration`).
- Bundled image styles: `juicebox_small`, `juicebox_medium`, `juicebox_large`, `juicebox_square_thumb`.
- Module dependencies: `file`, `image`. No permissions, no Drush commands.
