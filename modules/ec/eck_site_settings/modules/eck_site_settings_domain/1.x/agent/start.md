<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECK Site Settings per Domain (eck_site_settings_domain) — agent index

Submodule of **eck_site_settings**. Makes a settings bundle hold **different field values per
Domain-module domain** by scoping every settings load/create to the active domain. Package
`User interface`. Deps: **`domain:domain`** and **`eck_site_settings:eck_site_settings`**. Core
`^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Part of project `eck_site_settings` (version 1.3.6,
doc dir `1.x`). No routes, no permissions, no Drush.

- **How per-domain scoping and the auto-installed field work** → [config/per-domain.md](config/per-domain.md)
- **Parent module (repository/service, entity types, routes)** → `../../../../1.x/agent/start.md`

## What it actually provides

- **Bundle opt-in**: `EckBundleFormAlter` (service `eck_site_settings_domain.bundle_form_alter`,
  wired from `hook_form_alter` for ECK bundle forms) adds an **"Allow different settings per domain"**
  checkbox, stored as bundle third-party setting `eck_site_settings_domain.enabled`. Schema:
  `config/schema/eck_site_settings_domain.schema.yml` (`enabled: boolean`).
- **Field auto-install**: `hook_entity_insert` / `hook_entity_update` on an ECK bundle whose option
  is enabled call `FieldInstaller` (service `eck_site_settings_domain.field_installer`) to create a
  required `field_domain_access` **entity_reference → domain** field (storage cardinality 1) on the
  bundle's entity type.
- **Per-domain load/create** (`.module` alter hooks):
  - `hook_eck_site_setting_context_alter` sets `context['domain_id']` from `domain.negotiator`'s
    active domain (unless already set).
  - `hook_eck_site_setting_values_alter` sets `values['field_domain_access'] = context['domain_id']`
    when the bundle is domain-enabled — so the parent repository query loads/creates that domain's
    own settings entity.
- Helper `_eck_site_settings_domain_is_enabled($entityTypeId, $bundle)` reads the bundle's
  `eck_site_settings_domain.enabled` third-party setting.

## Access note (not a vuln)

The submodule adds **data separation**, not an access boundary: settings edit rights stay ECK's
site-wide `edit any <type> entities`. A user with edit permission edits whichever domain's variant
their active domain resolves to; the module does not (and does not claim to) restrict editing one
domain's settings from another. Loads use `accessCheck(FALSE)` in the parent repository, as for all
settings.
