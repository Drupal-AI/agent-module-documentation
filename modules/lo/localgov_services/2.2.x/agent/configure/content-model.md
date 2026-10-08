# Content model & config installed by localgov_services

There is **no settings form** (`configure` is null). Everything this module "configures" is shipped as
config in `config/install` (installed unconditionally) and `config/optional` (installed only when the
referenced theme/module is present). Enable it with:

```bash
drush en localgov_services -y
```

## Node types (config/install)

| Type machine name | Label | Notes |
|---|---|---|
| `localgov_services_landing` | Service landing page | Top-level section page for a service. `new_revision: true`, `display_submitted: false`, `preview_mode: 0`. Its fields/displays are added by the `localgov_services_landing` submodule. |
| `localgov_services_sublanding` | Service sub-landing page | Detail/links page within a service. Same base settings. Fields/displays added by the `localgov_services_sublanding` submodule. |

The `localgov_services_page` and `localgov_services_status` node types are installed by their own
submodules, not here.

## Menu (config/install)

- `system.menu.localgov-services-menu` — id `localgov-services-menu`, label "Services menu",
  `locked: false`. Placed as a `system_menu_block` by the optional block config below.

## Pathauto patterns (config/install)

| Pattern id | Applies to bundles | Pattern | Weight |
|---|---|---|---|
| `localgov_services_landing` | `localgov_services_landing` | `[node:title]` | -5 |
| `localgov_services_hierarchy` | `localgov_services_page`, `localgov_services_sublanding` | `[node:localgov_services_parent:entity:url:path]/[node:title]` | -5 |

The hierarchy pattern is what makes a page/sub-landing URL nest under its parent service's URL. The
parent is resolved through the `localgov_services_parent` field — see [../api/navigation.md](../api/navigation.md).
`localgov_services_post_update_pathauto_parent()` migrated an older `…:url:relative` token to `…:url:path`.

Inspect at runtime:

```bash
drush cget pathauto.pattern.localgov_services_hierarchy pattern
```

## Optional block placements (config/optional)

Installed only if the theme is present. Two theme variants ship for each: `localgov_base` (suffix
`_base`) and `scarfolk` (suffix `_scarfolk`).

| Block id (base) | Plugin | Region | Provider |
|---|---|---|---|
| `localgov_servicesmenu_base` | `system_menu_block:localgov-services-menu` | `secondary_menu` | system |
| `localgov_servicescalltoaction_base` | `localgov_service_cta_block` | `content_top` | localgov_services (see [../blocks/cta-block.md](../blocks/cta-block.md)) |
| `localgov_servicepagerelatedlinks_base` | `localgov_services_related_links_block` | `sidebar_second` | localgov_services_page |
| `localgov_servicepagerelatedtopics_base` | `localgov_services_related_topics_block` | `sidebar_second` | localgov_services_page |

## Admin-toolbar menu group (config/optional)

- `localgov_menu_link_group.localgov_menu_link_group.localgov_menu_link_group_services` — id
  `localgov_menu_link_group_services`, label "Services". Requires `localgov_menu_link_group`. Groups the
  four `node.add.*` admin-toolbar links (`localgov_services_landing`, `localgov_services_page`,
  `localgov_services_status`, `localgov_services_sublanding`) under a single "Services" parent in the
  toolbar's "Add content" menu.

## Config schema

`config/schema/localgov_services.schema.yml` declares one key — `field.widget.settings.link_with_type`
(inherits `field.widget.settings.link_default`) — for the `link_with_type` widget. No settings/config
object of the module's own.
