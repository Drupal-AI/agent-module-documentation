<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & inspect preview links programmatically

## The `preview_link` entity

Content entity type `preview_link` (base table `preview_link`), storage
`Drupal\preview_link\PreviewLinkStorage`. Base fields:

- `token` — string, required. A random **UUID** (not derived from the entity; not
  cryptographic, just unique). Auto-generated on `create()`.
- `entities` — `dynamic_entity_reference`, required, unlimited cardinality. The entities the
  link unlocks. Constraint `PreviewLinkEntitiesUniqueConstraint` prevents overlapping links.
- `generated_timestamp` — timestamp, set on create.
- `expiry` — timestamp, required; default = request time + configured lifetime
  (`preview_link.link_expiry`→`getLifetime()`, from `expiry_seconds`).

## Create a link for an entity

`PreviewLinkStorage::create()` auto-fills `token` and `generated_timestamp`, so you only set
the referenced entities:

```php
$node = \Drupal\node\Entity\Node::load(123);
$storage = \Drupal::entityTypeManager()->getStorage('preview_link');
$previewLink = $storage->create([]);
$previewLink->setEntities([$node]);   // or ->addEntity($node)
$previewLink->save();

$token = $previewLink->getToken();                 // UUID string
$url   = $previewLink->getUrl($node)->toString();  // /preview-link/<type>/<id>/<token>-style URL
```

`getUrl($entity)` returns `Url::fromRoute("entity.{$type}.preview_link", [ $type => id,
'preview_token' => token ])`. Regenerate (revoke old URL) with
`$previewLink->regenerateToken(TRUE); $previewLink->save();` — storage issues a new UUID on
save when the regenerate flag is set. `setExpiry(\DateTimeInterface)` / `getExpiry()` manage
the lifetime.

## Query links for an entity — `preview_link.host`

Service **`preview_link.host`** (`PreviewLinkHost`, interface `PreviewLinkHostInterface`):

```php
$host = \Drupal::service('preview_link.host');
$host->hasPreviewLinks($entity);   // bool: any UNEXPIRED link (expiry > now)
$host->getPreviewLinks($entity);   // PreviewLink[] referencing this entity
$host->isToken($entity, [$token]); // bool: is one of these tokens valid for the entity
```

## How preview access is granted

- `hook_entity_type_alter()` adds a `PreviewLinkRouteProvider` and the
  `preview-link-generate` link template (`<canonical>/generate-preview-link`) to every
  supported entity type, and a local-task tab (`PreviewLinkTasks` deriver).
- `hook_entity_access()` (via `PreviewLinkEntityHooks`) grants `view` when the request
  carries a valid token for the entity — even if unpublished.
- Access checks: `_access_preview_link`, `_access_preview_enabled`,
  `_access_preview_link_canonical_rerouter`, `_access_preview_session_exists`;
  `PreviewLinkRouteEventSubscriber` reroutes/records the token, optionally into the session
  (`preview_link.session_tokens.remove` clears session tokens).
- `hook_cron()` → `PreviewLinkExpiry` deletes expired links.

There are **no Drush commands**; use the entity storage and `preview_link.host` service.
