<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Name Field — agent index

Provides a compound **`name`** field type storing six components (title, given, middle,
family, generational, credentials) with a `name_default` widget and `name_default`
formatter. Output is driven by **`name_format`** config entities whose `pattern` uses
single-letter tokens. Depends only on core `field`. Configure route: `name.settings`
(`/admin/config/regional/name/settings`); format admin at `/admin/config/regional/name`.
No custom permissions (admin UI gated by core `administer site configuration`), no Drush.

- **Name formats, pattern token syntax, the settings form & separators, `name_list_format`** →
  [configure/name-formats.md](configure/name-formats.md)
- **The `name` field type, `name_default` widget & formatter, per-field settings** →
  [plugins/field-type.md](plugins/field-type.md)
- **Format names in code: `name.formatter`, `name.format_parser`, `name.generator`** →
  [api/services.md](api/services.md)
- **Add custom widget layouts** → [hooks/widget-layouts.md](hooks/widget-layouts.md)
- **Templates & theme hooks (`name_item`, `name_item_list`, `name`)** →
  [theming/templates.md](theming/templates.md)

Key facts:
- Field storage columns: `title, given, middle, family, generational, credentials` (all `varchar`).
- Default plugins: widget `name_default`, formatter `name_default`.
- Default format entity id `default`, pattern `((((t+ig)+im)+if)+is)+jc` → e.g. `Mr. John Peter Smith Jr., PhD`.
- Ships formats: `default`, `full`, `family`, `given`, `formal`, `short_full` (+ `name_list_format` `default`).
