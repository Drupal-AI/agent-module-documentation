<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lb_plus — install, config, permissions, admin routes

## Enable
`drush en lb_plus` pulls in `layout_builder`, `block`, `tempstore_plus`, `navigation_plus`. To get the
LB+ UI on a bundle: enable Layout Builder + "allow each content item to customize" on the display
(`/admin/structure/types/manage/<bundle>/display`), configure a default section, and promote some
blocks. Nested layouts require a `Layout Block` block-content type whose display also uses Layout
Builder (see README).

## Config objects & schema (`config/schema/lb_plus.schema.yml`)
- **`lb_plus.settings`** (config_object, installed by `config/install/lb_plus.settings.yml`):
  - `contextual_links` (boolean, default `0`) — show core block contextual links alongside LB+ tools.
  - Note: `colors` used to live here; `lb_plus_update_10000` migrated it to `navigation_plus.settings`,
    which is why `configure` (info.yml) points at `navigation_plus.settings`.
- **`entity_view_display.third_party.lb_plus.preserved_fields`** (sequence of field names) — fields to
  keep when editing. `lb_plus_update_10003` migrated these from the old `edit_plus_lb` namespace.
- **`layout_builder.section.third_party.lb_plus.uuid`** — stable per-section UUID LB+ assigns so the
  nested tree can address sections (`getThirdPartySetting('lb_plus','uuid')`).
- **`lb_plus.promoted_blocks`** (sequence) and **`lb_plus.block_config`** (per-view-mode) — promoted
  block ids and per-block icon paths, stored as `entity_view_display` third-party settings.

## Permissions (`lb_plus.permissions.yml`)
- `administer layout builder + configuration` — gates the default-section form.
- `promote layout builder + blocks` — gates the promoted-blocks form.

## Admin routes & forms (`lb_plus.routing.yml`, `lb_plus.links.task.yml`)
| Route | Path | Form | Requirement |
|---|---|---|---|
| `lb_plus.settings.configure_default_section` | `…/manage/{entity}/default-layout-section` | `Form\ConfigureDefaultSectionForm` | `_permission: administer layout builder + configuration` |
| `lb_plus.settings.promoted_blocks` | `…/manage/{entity}/promoted-blocks` | `Form\PromotedBlocksForm` | `_permission: promote layout builder + blocks` |

`{entity}` is an `entity_view_display`. Both appear as local tasks on the display edit page.
Other forms: `Form\EntityViewDisplayForm` (alters the display edit form, via
`hook_form_entity_view_display_edit_form_alter`), `Form\OverridesEntityForm` (alters overrides forms),
`Form\MediaBlockFileAssociationForm`, `Form\ConfigureDefaultSectionForm`.

## Other install hooks (`lb_plus.install`)
- `_10000` move colors to navigation_plus · `_10001` re-duplicate blocks to fix duplicate-UUID data
  across live/workspace/tempstore · `_10002` enable `tempstore_plus` · `_10003` migrate
  `preserved_fields` from `edit_plus_lb` to `lb_plus`.

## UI-shaping services
- `Config\NoHelpBlock` — a `config.factory.override` that hides the core help block on LB+ pages.
- `lb_plus.route_subscriber` (`Routing\LayoutBuilderRouteSubscriber`) and
  `lb_plus.route_enhancer.nested` (`Routing\NestedRouteEnhancer`, priority `-10`, runs after core's
  tempstore enhancer) wire the nested-storage parameters onto Layout Builder routes.
- `lb_plus.icons.yml` registers the SVG tool icons (icon pack `lb_plus`).
