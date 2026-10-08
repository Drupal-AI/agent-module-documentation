<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Access Logo (domain_access_logo) — agent index

Gives each Domain (from the Domain module) its own site logo on one Drupal
install. An admin uploads a per-domain image on one settings form; at render time
the module swaps the logo in the core **system_branding_block** to the file
configured for the active domain. No theme duplication, no CSS hacks.

- Dependencies: core `file`, `domain:domain` (composer `drupal/domain ^2.0 || ^3.0`). Core `^10.2 || ^11`.
- Configure route: `domain_access_logo.settings` → `/admin/config/domain/domain_access_logo` (a tab under the Domain admin area).
- Defines one permission; no drush; no plugin types; one config-schema object.

- **Upload / clear a logo per domain, the config object + schema, set it via drush/PHP** → [configure/logos.md](configure/logos.md)
- **The permission that gates the form** → [permissions/permissions.md](permissions/permissions.md)
- **The `domain_access_logo` service and `getActiveDomainLogo()`** → [api/service.md](api/service.md)
- **How the logo is swapped at render time (preprocess of system_branding_block)** → [theme/logo-swap.md](theme/logo-swap.md)

Key facts:
- Config object `domain_access_logo.settings`, single key `logos`: a map `logos.<domain_id>` → an array of one file id (the managed-file value). Schema `config/schema/domain_access_logo.schema.yml`.
- Service id `domain_access_logo` → `Drupal\domain_access_logo\DomainAccessLogo`; method `getActiveDomainLogo(): string` returns the active domain's logo as an absolute URL, or `''`.
- Runtime swap: `domain_access_logo_preprocess_block()` acts only on `base_plugin_id === 'system_branding_block'`, setting `$variables['content']['site_logo']['#uri']`.
- Permission string: `administer domains access logos` (its own permission, not `administer site configuration`).
- Form: `DomainAccessLogoSettingsForm` (form id `domain_logo_settings`), extends `ConfigFormBase`. Uploads restricted to `png gif jpg jpeg svg`, stored to `public://files`.
- `domain_access_logo.install` ships update `9001` that moved 1.x's top-level per-domain keys under the `logos` parent key — run `drush updatedb` when upgrading from 1.x.
