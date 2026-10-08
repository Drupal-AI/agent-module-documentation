<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Accessibility (web_accessibility) — agent index

Adds a collapsible **"Web Accessibility Services"** section to every already-saved node's
edit form (`hook_form_node_form_alter`). The section is a set of button links that open
external accessibility / markup / broken-link validators against that node's public
canonical URL in a new browser tab. Ships three default validators (W3C link checker,
W3C markup check, WAVE) and lets an admin add or delete more. The module makes **no HTTP
calls of its own** — the editor's browser is what opens the validator. No module
dependencies; core `^8 || ^9 || ^10 || ^11`.

Configure at `/admin/config/system/web_accessibility` (route `web_accessibility.settings`).
Defines one permission; no drush commands, no plugin types, and no config schema — services
are rows in the `web_accessibility_services` database table, not config entities.

- **Add / delete validator services** → [configure/services.md](configure/services.md)
- **The section injected into the node edit form (and hook_help)** → [hooks/node_form.md](hooks/node_form.md)
- **Manage services from PHP (the service + interface)** → [api/service_manager.md](api/service_manager.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Service id `web_accessibility.service_manager` → `Drupal\web_accessibility\WebServiceManager`
  (implements `Drupal\web_accessibility\WebServiceInterface`), constructed with `@database`;
  tagged `backend_overridable`.
- Storage: DB table `web_accessibility_services`, columns `id` (serial PK), `name`, `url`
  (both varchar 255). Defined in `web_accessibility.install` (`hook_schema`); seeded on
  install with the three default validators.
- URL placeholder constant `WebServiceInterface::URL_TOKEN` = `<URL>` — replaced with the
  node's absolute canonical URL when the node-form links are built.
- Permission: `administer_web_accessibility` (spelled with underscores).
- Routes: `web_accessibility.settings` → `/admin/config/system/web_accessibility` (AdminForm);
  `web_accessibility.delete_service` → `/admin/config/system/web_accessibility/delete/{service_id}`
  (DeleteServiceForm). Both require `administer_web_accessibility`.
- Menu link `web_accessibility.admin_page` under `system.admin_config_system`.
- `.info.yml`: legacy packaging string `version: '8.x-1.4'`; `package: Web services`;
  `configure: web_accessibility.settings`.
