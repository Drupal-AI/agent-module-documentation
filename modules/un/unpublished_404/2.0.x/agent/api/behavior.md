<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behavior: 403 → 404 for unpublished nodes

The whole module is one exception subscriber. There is nothing to configure.

## The subscriber

`Drupal\unpublished_404\EventSubscriber\NotFound` extends
`Drupal\Core\EventSubscriber\HttpExceptionSubscriberBase`:

- `getHandledFormats()` → `['html']` (only HTML responses; JSON/API 403s are untouched).
- `getPriority()` → `1000` (runs early, before core's default 403 handling).
- `on403(ExceptionEvent $event)` contains the logic.

Registered as service `unpublished_404.not_found` with `@current_user`, tagged
`event_subscriber`.

## The condition (all three must hold)

```php
public function on403(ExceptionEvent $event) {
  if ($this->account && !$this->account->hasPermission('view own unpublished content')) {
    $request = $event->getRequest();
    if ($node = $request->attributes->get('node')) {
      if (!$node->isPublished()) {
        $event->setThrowable(new NotFoundHttpException());   // -> 404
      }
    }
  }
}
```

1. The current user does **not** have the `view own unpublished content` permission.
2. The request resolved a `node` route parameter (i.e. it's a node page, e.g. `/node/{node}`).
3. That node is **unpublished** (`->isPublished() === FALSE`).

When all hold, the original 403 is replaced with a `NotFoundHttpException` (404). If any fails —
published node, privileged user, or a non-node 403 — the response is left as the standard 403.

## Consequences to know

- The check is `view own unpublished content`, a **core** permission. Any role granted it (or a more
  powerful bypass) still gets the normal 403/redirect, not a 404.
- Only nodes are affected. 403s for other entity types or arbitrary routes are not converted.
- No allowlist/denylist or per-bundle setting exists; the behavior is global once enabled.
