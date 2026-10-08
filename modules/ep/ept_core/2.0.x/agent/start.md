<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Core — agent index

Base/toolkit module for the Extra Paragraph Types (EPT) family. Provides the reusable
`ept_settings` design-options field, three shared paragraph fields, the CSS/JS generators that
render per-paragraph design options, and global settings. It is a **dependency layer** — on its
own it adds no usable paragraph type (use an `ept_*` module or the Starterkit to create one).
Depends on Paragraphs, Media, Field Group, Media Library Form Element. Configure route:
`ept_core.settings` (`/admin/config/content/ept-core`). No permissions of its own (settings form
uses `administer site configuration`); no Drush (the Starterkit submodule adds a generator).

- **Global settings: colours, breakpoints, container widths** →
  [configure/settings.md](configure/settings.md)
- **The `ept_settings` field type, widgets, formatter, shared fields** →
  [plugins/fields.md](plugins/fields.md)
- **Services & OOP hooks (GenerateCSS/GenerateJS, render pipeline)** →
  [api/services.md](api/services.md)

Key facts:
- Field type id `ept_settings` (default widget `ept_settings_default`, simple widget
  `ept_settings_simple`, formatter `ept_settings_default`).
- Shared field storages: `field_ept_settings`, `field_ept_text`, `field_ept_title`
  (entity type `paragraph`).
- Global config object: `ept_core.settings` (colours, `*_breakpoint`, `*_width`).
- Submodule: [ept_core_starterkit](../../modules/ept_core_starterkit/2.0.x/agent/start.md)
  — Drush generator `ept:module` for scaffolding new EPT paragraph modules.
