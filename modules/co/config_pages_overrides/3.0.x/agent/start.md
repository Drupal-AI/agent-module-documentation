<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Pages Overrides (config_pages_overrides) — agent index

**Turns Config Pages field values into simple-config overrides, no custom override service needed.**

- **Version:** 3.0.x  **Core:** ^11.1
- **Depends:** config_pages
- **Service:** `config_pages_overrides.config_overrider` (`ConfigOverrides`, tagged `config.factory.override`) reading `third_party_settings.config_pages_overrides` off each `config_pages.type.*`.
- **Routes:** `entity.config_pages_type.config_overrides_form` and `..._add_form` under `/admin/structure/config_pages/types/manage/{config_pages_type}/overrides[-add]`, both `_entity_access: config_pages_type.update`.
- **Casting:** target schema type → bool/int; supports prefix/suffix and per-delta/multi-value.
- **Security:** only admin entity-form routes, gated by `config_pages_type.update` access; no anonymous/mutating endpoints, no raw SQL, no external I/O, no untrusted `unserialize()`.

See [configure/overrides.md](configure/overrides.md).
