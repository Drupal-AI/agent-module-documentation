<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swiper formatter — agent index

Integrates the Swiper slider library. A **`swiper_formatter` config entity** ("Swiper
template") holds all slider options; **8 field formatters** + **1 Views style** render
content as slides using those templates. Depends on `token`.

- **Swiper template config entity, its options, admin route, library sources** →
  [configure/swiper-templates.md](configure/swiper-templates.md)
- **The 8 field formatters + the Views style (ids, field types, settings)** →
  [plugins/formatters-and-style.md](plugins/formatters-and-style.md)
- **Services & public API (`swiper_formatter.base`, entity static methods)** →
  [api/services.md](api/services.md)
- **`hook_swiper_formatter_settings_alter()`** →
  [hooks/settings-alter.md](hooks/settings-alter.md)
- **Theme hooks / Twig templates** → [theming/templates.md](theming/templates.md)
- **Permission `administer swiper_formatter`** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entity type id **`swiper_formatter`**, `config_prefix: swiper_formatter`, so entities
  are `swiper_formatter.swiper_formatter.<id>`; a **`default`** template ships and seeds new ones.
- Manage templates at **`/admin/config/content/swiper-formatter`** (route
  `entity.swiper_formatter.collection`); no `configure` route is declared in info.yml.
- Submodule **`swiper_formatter_ckeditor`** is a placeholder for a CKEditor 5 button (no code yet).
