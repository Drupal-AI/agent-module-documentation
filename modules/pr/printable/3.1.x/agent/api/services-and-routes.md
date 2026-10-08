# Services, routes, block, stream wrapper

## Routes

- **Per-entity printable page** (dynamic, added by `RouteSubscriber` for each type in
  `printable_entities`): `printable.show_format.{entity_type}` at
  `/{entity_type}/{entity}/printable/{printable_format}`, controller
  `PrintableController::showFormat`, guarded by `_entity_access: entity.view` **and**
  permission `view printer friendly versions`. So `/node/12/printable/print`,
  `/node/12/printable/pdf`, `/user/3/printable/print`, etc.
- **Config forms**: see [configure/settings.md](../configure/settings.md).

Because the routes are generated from config, run `drush cr` after changing
`printable_entities`.

## Services

| Service id | Class | Purpose |
|---|---|---|
| `printable.entity_manager` | `PrintableEntityManager` | Which entity types/bundles are printable; `getPrintableEntities()`, `isPrintableEntity()` |
| `printable.link_builder` | `PrintableLinkBuilder` | `buildLinks($entity, $viewMode)` → the Print/PDF link render array |
| `printable.format_plugin_manager` | `PrintableFormatPluginManager` | Discover/instantiate `PrintableFormat` plugins |
| `printable.link_extractor_plugin_manager` | `PrintableLinkExtractorPluginManager` | Discover `PrintableLinkExtractor` plugins |
| `printable.css_include` | `PrintableCssInclude` | Resolve the extra CSS include path |
| `printable.link_extractor` | `InlineLinkExtractor` | Rewrite links in HTML (uses `wa72/htmlpagedom`) |
| `printable.subscriber.route` | `Routing\RouteSubscriber` | Builds the per-entity printable routes |
| `stream_wrapper.printable` | `StreamWrapper\PrintableStream` | The `printable://` scheme |

## The links block

`hook_entity_view()` injects a `printable_navigation` links element (weight 100) into printable
entities, honoring `printable_print_link_locations` / `printable_pdf_link_locations`. You can
also place the **"Printable Links Block"** (`printable_links_block`, a derivative-based block,
category "Printable") in any region to show the current entity's Print/PDF links.

## The `printable://` stream wrapper

During PDF generation, `printable_file_url_alter()` / `printable_link_alter()` rewrite file
and link URLs to absolute paths under the `printable://` scheme so the PDF toolkit can read
local assets (images, CSS) directly rather than over HTTP. `printable_preparing_pdf()` /
`printable_preparing_content()` detect when these are active.

## Programmatic use

```php
$em = \Drupal::service('printable.entity_manager');
$printable = $em->isPrintableEntity($node);            // bool

$links = \Drupal::service('printable.link_builder')
  ->buildLinks($node, 'full');                          // ['print' => [...], 'pdf' => [...]]

// Direct URL:
$url = \Drupal\Core\Url::fromRoute('printable.show_format.node', [
  'entity' => $node->id(), 'printable_format' => 'print',
])->toString();
```
