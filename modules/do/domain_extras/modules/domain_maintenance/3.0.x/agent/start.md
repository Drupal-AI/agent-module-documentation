<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Maintenance Mode (domain_maintenance) 3.0.x

Per-domain maintenance mode for a Domain Access network: each domain can be put into
maintenance independently, on top of Drupal's site-wide switch.

## Facts
- **Part of** `domain_extras`. **Depends on** `domain:domain_config_ui`.
- **No routes, permissions, plugins, or config schema** of its own. `configure:` unset.
- **Service override** (`domain_maintenance.services.yml`): replaces core's
  `maintenance_mode` service with
  `Drupal\domain_maintenance\Service\DomainMaintenanceMode` (extends
  `Drupal\Core\Site\MaintenanceMode`); also autowires the hook service with
  `@domain_config_ui.manager` and `@state`.
- **Where the toggle is stored:** Drupal **state**, key
  `domain.{domain_id}.system.maintenance_mode` (built by
  `DomainMaintenanceMode::getStateName($domain_id)`). Not stored in the domain's config.
- **Access gate** — `DomainMaintenanceMode::applies(RouteMatchInterface)`
  (`src/Service/DomainMaintenanceMode.php`):
  1. If global `system.maintenance_mode` state is set → falls through (site-wide
     maintenance applies to every domain).
  2. Else it resolves the active domain via
     `DomainNegotiationContext::getDomainId()`; returns `FALSE` (not in maintenance) when
     there is no domain or the domain's per-domain state key is empty.
  3. Same as core: routes with the `_maintenance_access` option return `FALSE`.
  Only `applies()` is overridden; `exempt()` is inherited from core, so the
  `access site in maintenance mode` permission is still what lets a user through.
- **UI wiring** — `src/Hook/DomainMaintenanceHooks.php` (attribute hooks, legacy-bridged
  from `domain_maintenance.module`):
  - `formSystemSiteMaintenanceModeAlter` (`hook_form_system_site_maintenance_mode_alter`):
    when a domain is active in the domain_config_ui context and `system.maintenance` is a
    registered configuration, seeds `maintenance_mode` checkbox from the domain's state
    value, appends a "overridden by the Domain module" note, and adds `validateForm` /
    `submitForm` handlers.
  - `validateForm` (static): moves the submitted checkbox into `domain_maintenance_mode`
    and resets `maintenance_mode` to the current site-wide value, so saving a domain does
    not change the global flag.
  - `submitForm` (static): writes `domain_maintenance_mode` into the domain's state key.
  - `domainDelete` (`hook_domain_delete`): deletes the domain's state key.
- **Uninstall** (`domain_maintenance.install`): `hook_uninstall` deletes the per-domain
  state key for every domain.

## How to use
1. Enable `domain_maintenance` (pulls in `domain_config_ui`).
2. In domain_config_ui, ensure `system.maintenance` is a registered per-domain
   configuration and select the target domain in the domain switcher.
3. Go to the standard **Maintenance mode** form; the checkbox now reflects and edits that
   domain's flag (with the override note shown). Save to store it in state.
4. The site-wide Maintenance mode switch is unchanged and, when on, still affects all
   domains.
