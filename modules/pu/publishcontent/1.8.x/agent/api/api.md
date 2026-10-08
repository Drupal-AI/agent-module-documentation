# API — routes, service, events, Views field

## Toggle routes (`publishcontent.routing.yml`)

| Route | Path | Notes |
|---|---|---|
| `entity.node.publish` | `/node/{node}/toggleStatus` | Toggles the node's published status, then redirects to `HTTP_REFERER` (or the node). |
| `entity.node.publish_translation` | `/node/{node}/toggleStatus/{langcode}` | Toggles a specific translation. |

Both require `_csrf_token: TRUE`, the `_publish_access_check` access checker, and the
`hasUiLocalTask` custom access (i.e. `ui_localtask` config must be on). Controller:
`PublishContentPublishEntity::toggleEntityStatus()`. On toggle it optionally creates a
revision / log entry per config, dispatches the publish or unpublish event, saves the node,
and adds a status message. Build the CSRF-valid URL from code with
`Url::fromRoute('entity.node.publish', ['node' => $nid])`.

## Access service `publishcontent.access`

Class `Drupal\publishcontent\Access\PublishContentAccess` (tagged `access_check`,
`applies_to: _publish_access_check`). Call directly:

```php
/** @var \Drupal\publishcontent\Access\PublishContentAccess $svc */
$svc = \Drupal::service('publishcontent.access');
$result = $svc->access(\Drupal::currentUser(), $node); // AccessResultInterface
if ($result->isAllowed()) { /* user may toggle this node */ }
```

It picks the action from the node's current state (published → checks unpublish perms,
else publish perms), forbids non-existing translations, then merges the access hooks (see
hooks doc) with a default `AccessResult::allowed()` via `orIf`.

## Events

Dispatched by the toggle controller after status change (event name = the class FQN):

- `Drupal\publishcontent\Event\PublishContentPublishEvent`
- `Drupal\publishcontent\Event\PublishContentUnpublishEvent`

Each exposes public `$node` (`NodeInterface`) and `$langcode` (string). Subscribe with a
normal `EventSubscriberInterface` keyed on the class name to react to publishing.

## Views field

With Views enabled, `hook_views_data_alter` adds a node field `Publish/Unpublish`
(handler id `publishcontent_node`, plugin `PublishContentNode`). It renders a per-row
toggle link (respecting `publishcontent.access`, translation-aware), or nothing when
access is forbidden. Add it to any node-based View as a field.
