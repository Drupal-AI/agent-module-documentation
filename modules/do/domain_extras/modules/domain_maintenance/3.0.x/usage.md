Domain Maintenance Mode lets you switch Drupal's maintenance mode on or off independently for each domain in a Domain Access network instead of only site-wide.

---

Domain Maintenance Mode is a small submodule of the domain_extras suite that adds per-domain maintenance mode to a Domain Access site. It overrides core's `maintenance_mode` service with `Drupal\domain_maintenance\Service\DomainMaintenanceMode` (registered in `domain_maintenance.services.yml`), a subclass of `Drupal\Core\Site\MaintenanceMode` that also receives the `DomainNegotiationContext`. Its `applies()` method first honors the global `system.maintenance_mode` state (site-wide maintenance still affects every domain); when the global flag is off it resolves the current domain via `DomainNegotiationContext::getDomainId()` and reports maintenance only if that domain has its own per-domain flag set — otherwise the page loads normally. The per-domain flag is kept in Drupal **state** under the key `domain.{domain_id}.system.maintenance_mode` (see `DomainMaintenanceMode::getStateName()`), not in the domain's stored config. The toggle is surfaced through domain_config_ui: `DomainMaintenanceHooks::formSystemSiteMaintenanceModeAlter()` (attribute hook, legacy-bridged in the `.module`) alters the core maintenance-mode form when a domain is selected in the domain_config_ui context and `system.maintenance` is a registered per-domain configuration, seeding the checkbox from the domain's state value and adding a note that the setting is overridden by the Domain module. Its validate handler stashes the submitted value as `domain_maintenance_mode` and restores the site-wide `maintenance_mode` value so the global toggle is untouched; the submit handler writes the per-domain value into state. `DomainMaintenanceHooks::domainDelete()` (hook_domain_delete) and `hook_uninstall` in `domain_maintenance.install` clean up the per-domain state entries. The module defines no routes, permissions, plugins, or config schema of its own; it depends on `domain:domain_config_ui`.

---

- Turn maintenance mode on for one domain while the rest of the network stays online.
- Take an affiliate site down for a rollout without affecting sibling domains.
- Edit a domain's maintenance flag from the standard Maintenance mode form after selecting that domain in the domain_config_ui switcher.
- Read a domain's current flag from state key `domain.{domain_id}.system.maintenance_mode`.
- Compute that state key in code with `DomainMaintenanceMode::getStateName($domain_id)`.
- Keep the site-wide maintenance switch working as before — global maintenance still applies to every domain.
- Let core's per-request gate decide access via the overridden `maintenance_mode` service's `applies()`.
- Rely on `DomainNegotiationContext` to determine which domain the current request belongs to.
- Leave a domain's flag unset to keep that domain serving pages normally.
- Have per-domain flags removed automatically when a domain entity is deleted.
- Have all per-domain flags cleaned up on module uninstall.
- Pair with domain_config_ui so `system.maintenance` is a per-domain-editable configuration.
- Preserve the standard maintenance-page routing and `_maintenance_access` route option behavior from core.
- Use it as part of the domain_extras add-on suite alongside other Domain Access tools.
- Confirm the override is active by checking that the `maintenance_mode` service is `DomainMaintenanceMode`.
