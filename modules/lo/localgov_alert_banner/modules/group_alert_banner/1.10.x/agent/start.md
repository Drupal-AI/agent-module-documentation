<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Alert banner (group_alert_banner) — agent index

Submodule of **localgov_alert_banner**. Integrates alert banners with the contrib **Group** module
so banners can belong to a group/microsite. Dependencies: `group:group`,
`localgov_alert_banner:localgov_alert_banner`.

- **Install, relation plugin, routes, permissions** → [configure/setup.md](configure/setup.md)
- Parent module → [../../../1.10.x/agent/start.md](../../../1.10.x/agent/start.md)

Key facts:
- **Group relation plugin** `group_localgov_alert_banner`
  (`src/Plugin/Group/Relation/GroupAlertBanner.php`, `@GroupRelationType`,
  `entity_type_id = localgov_alert_banner`, `entity_access = TRUE`). `defaultConfiguration()` forces
  `entity_cardinality = 1` and `buildConfigurationForm()` disables that field in the UI.
- `GroupAlertBannerDeriver` derives one relation definition per alert-banner bundle
  (`AlertBannerEntityType::loadMultiple()`), labelled *Group Alert banner (<type>)*.
- `Routing\RouteSubscriber` clones `entity.group_relationship.create_page` /
  `.add_page` into `entity.group_relationship.group_alert_banner_create_banner` (path
  `group/{group}/alert-banner/create`) and `..._add_banner` (`group/{group}/alert-banner/add`),
  both defaulting `base_plugin_id = group_localgov_alert_banner`.
- **Group permission** `access localgov_alert_banner overview`
  (`group_alert_banner.group.permissions.yml`) — "Access Alert banner listing page".
- Config in `config/optional`: `views.view.group_alert_banners` (per-group banner listing),
  `block.block.localgov_alert_banner_microsites_base` and a microsite group relationship type.
- Hook classes (`src/Hook/`): `BlockHooks`, `EntityHooks`, `FormHooks`,
  `LocalgovMicrositesHooks` (autowired in `group_alert_banner.services.yml`).
- Provides no config schema of its own and no Drush commands.
