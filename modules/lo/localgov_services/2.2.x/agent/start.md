<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Services: Core (localgov_services) — agent index

Foundation of the LocalGov Drupal service model. Installs the `localgov_services_landing` and
`localgov_services_sublanding` node types, a dedicated `localgov-services-menu`, and the pathauto
patterns that make service URLs mirror the section tree. Also ships one block plugin (services
call-to-action), one link field widget, and the shared config the service submodules build on.
Requires [`localgov_core`](../../../localgov_core/3.3.x/agent/start.md) plus core `field`/`link`/`node`
and `pathauto`. No settings page (`configure` null), no permissions, no Drush. Provides config schema
for its field widget only.

- **Content types, menu, pathauto patterns and optional block placements it installs** → [configure/content-model.md](configure/content-model.md)
- **The services call-to-action block (`localgov_service_cta_block`)** → [blocks/cta-block.md](blocks/cta-block.md)
- **The `link_with_type` link field widget** → [fields/link_with_type.md](fields/link_with_type.md)
- **How service pages are linked into a tree (the service-navigation mechanism)** → [api/navigation.md](api/navigation.md)

Submodules (shipped under `modules/`; out of scope of these docs — enable the ones you need):

| Submodule | Purpose |
|---|---|
| `localgov_services_landing` | Adds the fields, form/view displays and `services` view to the `localgov_services_landing` top-level node type |
| `localgov_services_sublanding` | Second-level sub-landing pages (topic-list paragraphs, links to child pages) |
| `localgov_services_page` | The `localgov_services_page` ordinary content-page node type placed inside a service, plus its related-links/related-topics blocks |
| `localgov_services_navigation` | The shared navigation mechanism: the `localgov_services_parent` reference field, the `localgov_services` selection handler, hierarchy pathauto, and the child-reorder UI |
| `localgov_services_status` | Optional `localgov_services_status` node type for service-status updates/messages (e.g. "collections delayed") |

Key facts:
- `config/install` ships: `node.type.localgov_services_landing`, `node.type.localgov_services_sublanding`,
  `system.menu.localgov-services-menu`, `pathauto.pattern.localgov_services_landing` (pattern `[node:title]`)
  and `pathauto.pattern.localgov_services_hierarchy` (pattern `[node:localgov_services_parent:entity:url:path]/[node:title]`,
  applied to the `localgov_services_page` + `localgov_services_sublanding` bundles).
- Block plugin id `localgov_service_cta_block` (class `ServicesCtaBlock`, abstract base `ServicesBlockBase`);
  `hook_theme` registers the `services_cta_block` theme hook.
- Field widget id `link_with_type` (class `LinkWithType`), config-schema key `field.widget.settings.link_with_type`.
- `config/optional` places blocks on the `localgov_base` and `scarfolk` themes (services menu, CTA,
  service-page related links/topics) and defines admin-toolbar menu group `localgov_menu_link_group_services`.
- `test_dependencies`: `localgov_search`, `localgov_base` — searchable services need `localgov_search` enabled separately.
- Update hooks: `localgov_services_update_10001` (renames the old `localgov_services_menu` menu to
  `localgov-services-menu`); `localgov_services_post_update_pathauto_parent` (migrates the hierarchy pattern token).
