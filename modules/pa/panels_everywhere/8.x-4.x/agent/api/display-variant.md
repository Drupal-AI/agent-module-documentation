# DisplayVariant plugin `panels_everywhere_variant` (API)

`Drupal\panels_everywhere\Plugin\DisplayVariant\PanelsEverywhereDisplayVariant`
(`src/Plugin/DisplayVariant/PanelsEverywhereDisplayVariant.php`).

```php
/**
 * @DisplayVariant(
 *   id = "panels_everywhere_variant",
 *   admin_label = @Translation("Panels Everywhere")
 * )
 */
class PanelsEverywhereDisplayVariant extends PanelsDisplayVariant implements PageVariantInterface
```

It **extends** `panels`' `PanelsDisplayVariant` (so it inherits all of Panels' region/block/layout
handling and the IPE) and **implements core `\Drupal\Core\Display\PageVariantInterface`** — the
interface core uses for the variant that renders a *whole page* (the same role as core's
`block_page` / `BlockPageVariant`). Implementing it is what lets a Panels display stand in for the
theme page.

## Methods that matter

- `create()` — parent create plus stores `@renderer` on `$instance->renderer`.
- `setTitle($title)` (from `PageVariantInterface`) — stores the page title; a render-array title is
  rendered to a string via `renderer->renderRoot()`. `build()` then calls `setPageTitle($this->title)`.
- `setMainContent(array $main_content)` (from `PageVariantInterface`) — stores the controller's main
  render array. In `build()` it is pushed into whichever placed block implements
  `MainContentBlockPluginInterface` (the "Main Page Content" block), via `$block->setMainContent(...)`.
- `build()` — iterates `getRegionAssignments()`, finds the main-content block, calls parent
  `build()`, then (copied from core `BlockPageVariant`) **unsets `#cache['keys']`** on the main
  content block so that pane is rendered as-is (not cached) while the surrounding placed blocks
  decorate it.
- `buildConfigurationForm()` / `submitConfigurationForm()` — add and save the one extra checkbox
  `route_override_enabled` (see [../configure/site-template.md](../configure/site-template.md)).
- `isRouteOverrideEnabled(): bool` — reads `$this->configuration['route_override_enabled']`
  (default FALSE). Read by the route subscriber to decide whether to strip Page Manager's route.

## Config schema

`config/schema/panels_everywhere.schema.yml`:

```yaml
display_variant.plugin.panels_everywhere_variant:
  type: display_variant.plugin.panels_variant     # inherits all Panels variant keys
  label: 'Panels Everywhere variant plugin'
  mapping:
    route_override_enabled:
      type: boolean
      label: 'Route override enabled'
```

So a stored variant carries all the Panels variant settings (`layout`, `layout_settings`,
`builder`, `blocks`, `page_title`, `storage_type`, `storage_id`, …) **plus** `route_override_enabled`.

## Storage hooks (`panels_everywhere.module`)

Two entity hooks make Panels treat a Page Manager variant as Panels-backed storage (needed so the IPE
is offered):

- `panels_everywhere_page_variant_create(PageVariantInterface $page_variant)` —
  `hook_ENTITY_TYPE_create` for `page_variant`. When the variant plugin id is
  `panels_everywhere_variant`, calls `$panels_display->setStorage('page_manager', $page_variant->id())`
  (id is usually still NULL here; setting the *type* is enough to signal IPE support).
- `panels_everywhere_page_variant_presave(PageVariantInterface $page_variant)` —
  `hook_ENTITY_TYPE_presave`. Calls `setStorage('page_manager', $page_variant->id())` again now that
  the id exists, then **re-copies** the plugin configuration back onto the entity
  (`$page_variant->set('variant_settings', $panels_display->getConfiguration())`) because
  `ConfigEntityBase::preSave()` already ran before `hook_entity_presave`.

Also present in `.module`: a global helper `array_splice_assoc()` (an `array_splice` variant that
keeps replacement keys) — a leftover utility, not part of any documented API and not called elsewhere
in the module.

## Update path

- `panels_everywhere_update_8400()` (`.install`) — for every `page_manager.page_variant` whose
  `variant` is `panels_everywhere_variant`, rewrites `variant_settings.layout` from old Panels layout
  ids to the layout_discovery equivalents via `panels_convert_plugin_ids_to_layout_discovery()`
  (throws if that Panels helper is absent — needs a recent Panels 4.x).
- `panels_everywhere_post_update_route_override()` (`.post_update.php`) — see the legacy note in
  [../configure/site-template.md](../configure/site-template.md).
