<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Views — agent index

Exposes each Views display as a JSON:API resource at **`/jsonapi/views/{viewId}/{displayId}`**
(the `/jsonapi` prefix is the site's `jsonapi.base_path`). Depends on core `views` and contrib
`jsonapi_resources`. No configure route, no permission of its own, no Drush.

- **The resource: URL pattern, query params (filters/sorts/args/pagination), response shape** →
  [api/resource.md](api/resource.md)
- **Turn exposure on/off per display (the `jsonapi_views` display extender)** →
  [configure/exposure.md](configure/exposure.md)

Key facts:
- One route per enabled view+display is built dynamically by `Routing\Routes::routes()`.
- Exposure toggle: Views display extender id `jsonapi_views`, option `enabled` (default TRUE),
  stored at `display_options.display_extenders.jsonapi_views.enabled` in the view config.
- Query params: `?views-filter[<id>]=…`, `?views-sort[sort_by]=…&views-sort[sort_order]=…`,
  `?views-argument[]=…` (repeatable), `?page=<n>`.
- A not-exposed / access-denied resource returns HTTP 403.
