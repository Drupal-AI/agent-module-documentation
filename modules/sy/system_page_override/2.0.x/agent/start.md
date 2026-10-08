# System Page Override (system_page_override) — agent index

Uses ordinary nodes as the site's **front page**, **403** (access denied) and **404**
(page not found) pages, choosable **per language**. No Drush, no plugin types, no
config entities beyond one settings object. `configure` = null (no `configure:` key in
info.yml). Provides 3 permissions and config schema.

- **Admin routes, forms, config keys, State keys, node-form checkbox, permissions** →
  [configure/settings.md](configure/settings.md)
- **How the override is actually applied (config.factory.override + State)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Two admin routes under `/admin/config/system/system-page-override`:
  - `.../settings` (`SettingsForm`) — pick which node bundles may serve each system page;
    saved to config `system_page_override.settings` keys `enabled_node_bundles_front`,
    `enabled_node_bundles_403`, `enabled_node_bundles_404` (arrays of bundle IDs).
  - `.../` (`OverviewForm`) — free-text path field per system page per language.
- Enabled bundles get a **"Systempage settings"** details group on the node edit form
  (`hook_form_node_form_alter`), with a per-language checkbox per applicable system page.
- Targets are stored in **Drupal State**, not config, as
  `system_page_override:<page>:<langcode>` (`<page>` = `front` | `403` | `404`), value `/node/<id>`.
- `SystemPageConfigOverride` (tagged `config.factory.override`) injects those State values
  into `system.site` `page.front` / `page.403` / `page.404` for the current language, so core's
  normal front-page and 403/404 handling serves the node (target keeps its own access checks).
- Permissions: `administer system page override settings`, `administer system page overrides`,
  `administer node as system page`.
- Monolingual sites: one target per page; multilingual: independent target per language.
