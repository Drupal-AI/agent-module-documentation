# Programmatic API — services, plugin types, event

## Services (`linkchecker.services.yml`)

| Service | Class | Purpose |
|---|---|---|
| `linkchecker.extractor` | `LinkExtractorService` | Extract links from an entity/field into `linkcheckerlink` entities |
| `linkchecker.extractor_batch` | `LinkExtractorBatch` | Bulk extraction across entities (cron / Drush) |
| `linkchecker.checker` | `LinkCheckerService` | Queue links for checking and run the HTTP check |
| `linkchecker.checker_batch` | `LinkCheckerBatch` | Bulk queue + check |
| `linkchecker.clean_up` | `LinkCleanUp` | Remove orphaned links / queue items for an entity |
| `linkchecker.response_codes` | `LinkCheckerResponseCodes` | HTTP response-code helpers |
| `plugin.manager.link_extractor` | `LinkExtractorManager` | Extractor plugin manager |
| `plugin.manager.link_status_handler` | `LinkStatusHandlerManager` | Status-handler plugin manager |

```php
/** @var \Drupal\linkchecker\LinkExtractorService $extractor */
$extractor = \Drupal::service('linkchecker.extractor');
$links = $extractor->extractFromEntity($node);   // FieldableEntityInterface
$extractor->saveLinkMultiple($links);
$extractor->updateEntityExtractIndex($node);

/** @var \Drupal\linkchecker\LinkCheckerService $checker */
$checker = \Drupal::service('linkchecker.checker');
$checker->queueLinks();          // queue links whose interval elapsed ($rebuild = TRUE to requeue all)
$checker->check($link);          // check one LinkCheckerLinkInterface now
```

Other extractor methods: `extractFromField()`, `getLinks()`, `isLinkExists()`, `saveLink()`.

## `linkcheckerlink` content entity

`Drupal\linkchecker\Entity\LinkCheckerLink` (`@ContentEntityType id = "linkcheckerlink"`,
base table `linkchecker_link`, id key `lid`, publishable). Custom storage
`LinkCheckerStorage`. Each record is one unique URL; `LinkCheckerLink::generateHash($uri)`
(base64 of the URI, stored in `urlhash`) deduplicates. Load via the entity type manager
(`\Drupal::entityTypeManager()->getStorage('linkcheckerlink')`).

## Plugin type: LinkExtractor

Annotation `@LinkExtractor` (`src/Annotation/LinkExtractor.php`), manager
`plugin.manager.link_extractor`, base `Plugin\LinkExtractorBase`, discovered in
`Plugin/LinkExtractor/`. Built-ins:

- `html_link_extractor` — pulls links from configured HTML tags in formatted text.
- `link_link_extractor` — pulls links from core Link fields.

Implement one to extract links from a custom field type; select it as a field's Extractor.

## Plugin type: LinkStatusHandler

Annotation `@LinkStatusHandler` (`status_codes` list), manager
`plugin.manager.link_status_handler`, base `Plugin\LinkStatusHandlerBase`, run by the
`linkchecker_status_handle` queue worker. Built-ins:

- `unpublish_404` — unpublishes entities after `error.action_status_code_404` failed 404 checks.
- `repair_301` — rewrites links that return 301 to their new destination.

Implement one to react to other response codes; declare which codes it handles in the
annotation's `status_codes`.

## Event

`LinkcheckerEvents::BUILD_HEADER` (`'linkchecker.build_header'`) dispatches a
`Drupal\linkchecker\Event\BuildHeader` event while building the HTTP request headers for a
link check. Subscribe and call `$event->setHeaders(...)` (with `getHeaders()` / `getContext()`)
to customise per-request headers.

## Drush (`drush.services.yml` → `LinkCheckerCommands`)

- `linkchecker:analyze` (`lca`) — re-extract from entities and re-check all links.
- `linkchecker:clear` (`lccl`) — clear all stored links.

There is no `linkchecker.api.php`; extension points are the two plugin types, the
`build_header` event, and the standard generic entity CRUD hooks that fire on the
`linkcheckerlink` entity.
