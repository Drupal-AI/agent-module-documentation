# event subscriber: DefaultContentSubscriber — post-import Search API re-index

Service `commerce_kickstart_demo_assets.event_subscriber` →
`Drupal\commerce_kickstart_demo_assets\EventSubscriber\DefaultContentSubscriber`
(constructor arg `@entity_type.manager`; tags `event_subscriber` and `needs_destruction`).

Purpose: after the recipe imports default content (products, etc.), the Search API `products` index
must be populated. The subscriber defers indexing until the import is committed rather than indexing
mid-import.

Subscribed events (`getSubscribedEvents()`):
| Event | Method | Effect |
|---|---|---|
| `Drupal\Core\DefaultContent\PreImportEvent` | `onDefaultContentImport()` | sets internal `$import = TRUE` flag |
| `Drupal\Core\Recipe\RecipeAppliedEvent` | `destruct()` | runs the re-index |

`destruct()` (also invoked at end of request via the `needs_destruction` tag) checks the flag and, if
an import happened, loads the `search_api_index` entity with id `products` and calls
`$index->indexItems()`, then clears the flag to avoid re-running. Binding `destruct` to
`RecipeAppliedEvent` as well covers the case where the recipe is applied outside a kernel scope, so
destruction still fires and the index is rebuilt.

Undeclared runtime dependency: `search_api`, plus a Search API index whose id is `products` (provided
by the demo recipe/environment).
