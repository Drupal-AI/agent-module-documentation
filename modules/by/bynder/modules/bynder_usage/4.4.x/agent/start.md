# Bynder Usage — agent index

Reports Drupal asset placements back to Bynder by subscribing to Entity Usage events and calling the Bynder
asset-usage API. Depends on `bynder` + `entity_usage` (>= 2.x). No config, no permissions, no schema — it
is a single event subscriber.

## What it does (`src/EventSubscriber/UsageEventSubscriber.php`)

Subscribes to (`bynder_usage.services.yml`, service `bynder_usage_subscriber`, args `@bynder_api`,
`@entity_type.manager`, `@request_stack`):

| Event (`entity_usage` `Events::*`) | Handler | Effect |
|---|---|---|
| `USAGE_REGISTER` | `onUsageRegister` | If target is a Bynder media and count > 0: `BynderApi::addAssetUsage(mediaId, url, now, "Added asset by user <name>.")` — only if no remote usage already exists for that URI. If count == 0: `removeAssetUsage(mediaId, url)`. |
| `DELETE_BY_SOURCE_ENTITY` | `onDeleteBySourceEntity` | Host entity deleted → loop its referenced Bynder media and `removeAssetUsage()` for the host URL. |
| `DELETE_BY_TARGET_ENTITY` | `onDeleteByTargetEntity` | Bynder media deleted → `getAssetUsages()` then `removeAssetUsage()` for every usage whose URI starts with this site's base URL. |

Details:
- Remote asset ID = `Bynder` source plugin `getSourceFieldValue($media)`.
- Canonical URL resolved via `getEntityUrl()`, walking Paragraph parents up to a linkable entity.
- Duplicate guard: `hasRemoteUsageByUri()` checks existing Bynder usages before adding.
- All Bynder API calls are wrapped in try/catch; `RequestException`s are logged to the `bynder` channel and
  surfaced via `UnableToAddUsageException` / `UnableToDeleteUsageException`.

There is nothing to configure — enabling the module (with Entity Usage tracking active) is enough.
