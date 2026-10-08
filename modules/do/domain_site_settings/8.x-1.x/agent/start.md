<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Site Settings (domain_site_settings) — agent index

Per-domain overrides of core `system.site` for **Domain**-module multisites: each domain gets its own
site name, slogan, email, default front page, and 403/404 pages. An admin edits values per domain; a
config override swaps them into `system.site` for the active domain at request time.
Version **8.x-1.6**. Depends on `domain:domain` and `domain:domain_config`.
Note: upstream marks this project obsolete in favor of `domain_config` / `domain_config_ui`.

`configure` route: `domain_site_settings.list` (`admin/config/domain/domain_site_settings`).
No drush, no plugin types, no config schema, no `.module`/hooks.

- **The domains list, the per-domain settings form, the stored config keys, and how they override `system.site` at runtime** → [configure/settings.md](configure/settings.md)
- **The single access permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object: `domain_site_settings.domainconfigsettings`. Keys are namespaced by domain id:
  `<domain_id>.site_name`, `.site_slogan`, `.site_mail`, `.site_frontpage`, `.site_403`, `.site_404`.
- Routes (both require permission `domain site settings`):
  `domain_site_settings.list` → `DomainSiteSettingsController::domainList` (table of domains);
  `domain_site_settings.config_form` (`.../{domain}/edit`) → form `DomainConfigSettingsForm`.
- Runtime override: service `domain_site_settings.overrider`
  (`Configuration\DomainConfigOverride`), tagged `config.factory.override` priority 5. Overrides
  `system.site` (name, slogan, mail, page.403/404/front) for the active domain from
  `domain.negotiator::getActiveDomain()`.
- Permission: `domain site settings`.
