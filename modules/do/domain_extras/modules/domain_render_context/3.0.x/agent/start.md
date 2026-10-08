<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Render Context (domain_render_context) 3.0.x

Developer-API service that runs a callback as if the request had come from a chosen
domain, so out-of-band output (email, PDF, queue item) gets that domain's links,
per-domain config, path prefixes and theme. Part of **domain_extras**; no route, UI,
permission, config or hook.

## Facts

- **Dependency:** `domain:domain` (info.yml). No other module deps.
- **Service:** `domain_render_context.renderer` — class
  `Drupal\domain_render_context\DomainRenderContext`
  (`src/DomainRenderContext.php`), implementing
  `Drupal\domain_render_context\DomainRenderContextInterface`
  (`src/DomainRenderContextInterface.php`). Autowired; the interface name is also
  registered as an alias, so type-hinting `DomainRenderContextInterface` injects it
  (`domain_render_context.services.yml`).
- **Constructor deps:** `@domain.negotiation_context`, `@domain.negotiator`,
  `@router.request_context`, `@entity_type.manager`, `@config.factory`,
  `@theme.manager`, `@theme.initialization`, logger channel
  `domain_render_context`.
- **No** routes, controllers, forms, permissions, plugins, config schema, or hooks.

## API

Two methods on `DomainRenderContextInterface`:

- `inDomain(DomainInterface|string $domain, callable $callback): mixed`
  — enters the domain context, runs `$callback` (no args), returns its value, and
  always restores in a `finally`. Use this for anything that fits one callback.
- `enter(DomainInterface|string $domain): \Closure`
  — lower-level: enters the context and returns a no-arg restore closure the caller
  must call (do it in `finally`). Idempotent (only the first call restores). Nested
  `enter()` calls restore correctly when closures are called in reverse order.

`$domain` is a loaded `DomainInterface` or a domain machine name (string). An unknown
machine name is logged as a warning and the current context is left unchanged (returns
a no-op restore closure) — a deleted domain never fatals a notification.

### What it switches (and nothing else)

1. `domain.negotiation_context` — active domain (pinned via `setNegotiated(TRUE)`);
   drives per-domain config overrides, path prefix, that domain's language
   negotiation config.
2. `router.request_context` — scheme, host, http/https port and complete base URL
   (origin swapped, install subdirectory kept); this is where absolute-URL host
   comes from.
3. Active theme — read from the render domain's own `system.theme:default` via config
   overrides; a theme that fails to init is logged and the current one kept.

Does **not** touch interface language, session or current user, and does not push a
request onto the request stack.

### How to use

```php
// By service id, or inject DomainRenderContextInterface.
$ctx = \Drupal::service('domain_render_context.renderer');

// One-shot: render as the order's domain.
$body = $ctx->inDomain($order->getDomainId(), function () use ($order) {
  return [
    'site' => \Drupal::config('system.site')->get('name'),
    'link' => Url::fromRoute('my_module.cancel', ['order' => $order->id()], ['absolute' => TRUE])->toString(),
  ];
});

// Spanning work (e.g. a whole queue processItem()): use enter()/restore.
$restore = $ctx->enter($domain_id);
try {
  // ... build and send the message ...
}
finally {
  $restore();
}
```

Outbound only — never call while a page is being routed/rendered for the browser.
Unrouted `base:`/non-routed `internal:` URIs keep the current host; routed URLs
(`Url::fromRoute()`, `$entity->toUrl()`, `[site:url]`) follow the switch. For a single
link, Domain core's `Url::fromRoute(..., ['domain' => $domain])` needs no context
switch.
