<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Administration Language Negotiation — agent index

Adds an **interface** language negotiation method that forces admin pages into each user's
preferred admin language. Depends on core `locale`.

- **Enable/order the method, the settings (paths, admin_routes, use_default_lang), the
  configure route, the user field** → [configure/setup.md](configure/setup.md)
- **The condition plugin type and its two plugins** → [plugins/conditions.md](plugins/conditions.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Negotiation method id `administration-language-negotiation` (label "Administration
  language", weight -4, interface type). Enable + order it at *Config → Regional and
  language → Languages → Detection and selection* — must come **before** other methods.
- Config object `administration_language_negotiation.negotiation`: `paths` (sequence of glob
  patterns, default `/admin`, `/admin/*`, `/admin*`, `/node/add/*`, `/node/*/edit`,
  `/node/*/translations`, `/node`), `admin_routes` (bool, default false), `use_default_lang`
  (bool, default false).
- Configure route: `administration_language_negotiation.negotiation_administration_language`
  (`/admin/config/regional/language/detection/administration_language`, perm `administer
  languages`).
- Permission: `use administration language negotiation`. Returns the user's
  `preferred_admin_langcode` on matching admin locations.
- Plugin type `administration_language_negotiation_condition` (manager
  `plugin.manager.administration_language_negotiation_condition`); plugins `paths`,
  `admin_routes`.
