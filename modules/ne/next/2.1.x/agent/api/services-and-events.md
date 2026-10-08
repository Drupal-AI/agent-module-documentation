<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js — services, entity API, events, routes

## Services

| Service id | Class | Purpose |
|---|---|---|
| `next.settings.manager` | `NextSettingsManager` | read global `next.settings` + active previewer/generator plugins |
| `next.entity_type.manager` | `NextEntityTypeManager` | resolve `next_entity_type_config`, sites, resolver, revalidator for an entity |
| `next.preview_secret_generator` | `PreviewSecretGenerator` | HMAC preview secret from the site private key |
| `plugin.manager.next.site_resolver` / `.site_previewer` / `.preview_url_generator` / `.revalidator` | plugin managers | discover/instantiate the four plugin types |
| `next.main_content_renderer.html` | `HtmlRenderer` (decorates `main_content_renderer.html`) | swaps the entity page for the site previewer |
| `next.entity_action_event_dispatcher` | `EntityActionEventDispatcher` | collects entity actions and dispatches on destruct |
| `next.entity_action_event_revalidate_subscriber` | subscriber | runs the revalidator per entity action |
| `next.uninstall_validator` | `NextUninstallValidator` | blocks uninstall while plugins are in use |
| `logger.channel.next` | logger | the `next` log channel |

### `NextSettingsManagerInterface`

```php
$m = \Drupal::service('next.settings.manager');
$m->getConfig();                 // ImmutableConfig of next.settings
$m->all();                       // all settings
$m->get('debug');                // a single setting
$m->getSitePreviewer();          // SitePreviewerInterface|null (active)
$m->getPreviewUrlGenerator();    // PreviewUrlGeneratorInterface|null (active)
$m->isDebug();                   // bool
```

### `NextEntityTypeManagerInterface`

```php
$m = \Drupal::service('next.entity_type.manager');
$m->getConfigForEntityType($entity_type_id, $bundle); // ?NextEntityTypeConfigInterface
$m->getEntityFromRouteMatch($route_match);            // ?EntityInterface
$m->getConfigEntityTypeIds();                         // configured entity types
$m->isEntityRevisionable($entity);                    // bool
$m->getSitesForEntity($entity);                       // NextSiteInterface[]
$m->getSiteResolver($entity);                         // ?SiteResolverInterface
$m->getRevalidator($entity);                          // ?RevalidatorInterface
```

## Entity API

### `NextSiteInterface` (`next_site`)

`getBaseUrl/setBaseUrl`, `getPreviewUrl/setPreviewUrl`, `getPreviewSecret/setPreviewSecret`,
`getRevalidateUrl/setRevalidateUrl`, `getRevalidateSecret/setRevalidateSecret`,
`getPreviewUrlForEntity($entity): Url` (anonymous/role-less users get the live URL instead),
`getLiveUrlForEntity($entity): ?Url` (NULL if unpublished), `buildRevalidateUrl($query = []): ?Url`.

### `NextEntityTypeConfigInterface` (`next_entity_type_config`)

`getSiteResolver()/setSiteResolver($id)`, `isDraftEnabled()`, `getRevalidator()/setRevalidator($id)`,
`getConfiguration()/setConfiguration($config)`, `getSiteResolverConfiguration()`,
`setSiteResolverConfiguration($id, $config)`, `getRevalidatorConfiguration()`,
`setRevalidatorConfiguration($id, $config)`, `getRevalidatorPluginCollection()`,
`getPluginCollection()`.

## Events

`Drupal\next\Event\EntityEvents` constants; payload classes in `Drupal\next\Event`.

- **`EntityActionEvent`** — dispatched by `next.module` on `hook_entity_insert` (INSERT_ACTION),
  `hook_entity_update` (UPDATE_ACTION), `hook_entity_predelete` / `hook_entity_translation_delete`
  (DELETE_ACTION). Created via `EntityActionEvent::createFromEntity($entity, $action)`. Consumed by
  the revalidate subscriber (which invokes the entity type's revalidator).
- **`EntityRevalidatedEvent`** — fired after a successful revalidation; subscribe to it for
  logging/metrics.

Example subscriber:

```php
use Drupal\next\Event\EntityEvents;
use Drupal\next\Event\EntityRevalidatedEventInterface;

public static function getSubscribedEvents(): array {
  return [EntityEvents::ENTITY_REVALIDATED => 'onRevalidated'];
}
public function onRevalidated(EntityRevalidatedEventInterface $event): void { /* ... */ }
```

## Routes

| Route | Path | Notes |
|---|---|---|
| `next.settings` | `/admin/config/services/next/settings` | settings form (`administer site configuration`) |
| `entity.next_site.collection` | `/admin/config/services/next` | the `configure` route |
| `next.validate_draft_url` | `/next/draft-url` (POST, json) | validates a preview/draft request from the Next.js app |
| `next.validate_preview_url` | `/next/preview-url` (POST, json) | legacy alias (next-drupal 1.6.0; removed in next 3.x) |

Both validate routes are handled by `NextPreviewUrlController::validate` and are `_access: 'TRUE'`
(auth is enforced inside via the preview_url_generator's `validate()`).

## Preview secret generator

`next.preview_secret_generator` (`PreviewSecretGenerator`) builds/validates an HMAC of a value using
the site private key (`@private_key`) — used by the `simple_oauth` generator to sign preview requests.
