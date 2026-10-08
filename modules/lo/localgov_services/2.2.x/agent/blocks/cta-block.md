# Services call-to-action block

The only block plugin this (top-level) module defines.

| Item | Value |
|---|---|
| Plugin id | `localgov_service_cta_block` |
| Class | `Drupal\localgov_services\Plugin\Block\ServicesCtaBlock` |
| Base class | `Drupal\localgov_services\Plugin\Block\ServicesBlockBase` (abstract) |
| Admin label | "Services call to action" |
| Theme hook | `services_cta_block` (registered by `localgov_services_theme()`; template `services-cta-block.html.twig`) |
| Default placement | `config/optional` block `localgov_servicescalltoaction_base` / `_scarfolk`, region `content_top` |

## What it does

`ServicesBlockBase` (the shared base) reads the current node from the route (`current_route_match`,
loading it via `entity_type.manager` if only an id is present). Its default `blockAccess()` allows the
block only when a node is present on the route; it adds cache tag `node:<nid>` and the `route` cache context.

`ServicesCtaBlock` overrides `blockAccess()` to also require the node to have a non-empty
`localgov_common_tasks` link field (returns `AccessResult::neutral()` otherwise, so the block is hidden
when there are no tasks). `build()` iterates `localgov_common_tasks` values and emits a `services_cta_block`
render array of buttons:

- Each item becomes `{ title, url: Url::fromUri(item.uri), type }`.
- `type` is `cta-action` when the link's stored `options.type === 'action'`, otherwise `cta-info`. That
  `options.type` value is set by the [`link_with_type`](../fields/link_with_type.md) widget.
- Cache: tag `node:<nid>`, context `url.path`.

The `localgov_common_tasks` field itself is provided by the landing/page/navigation submodules, not by
the top-level module; this block is bundle-agnostic and renders whatever node on the route carries that field.

## Reuse

To build another node-context block, extend `ServicesBlockBase` and implement `build()`; you inherit the
route-node resolution, the "node required" access check, and node cache tagging. Give it a `@Block`
annotation with a unique `id`.
