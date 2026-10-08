<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# URLs: Pathauto patterns, path processor, menu link

## Pathauto patterns (`pathauto.pattern.*.yml`)
- **product** — `products/[node:title]` for `product` nodes.
- **release** — `products/[node:field_product]/releases/[node:title]` for `release` nodes.

So a product aliases to `/products/<title>` and a release to
`/products/<product>/releases/<title>`.

## Menu link (`recipes/default/content/menu_link_content/…yml`)
A "Products" link in the `main` menu (weight 5) pointing at `internal:/products` (the products View
page).

## The product path processor
`src/PathProcessor/WebReleasesProductPathProcessor.php` — service
`webreleases.product_path_processor`, implements both `InboundPathProcessorInterface` and
`OutboundPathProcessorInterface`, constructed with `@path_alias.manager` and `@database`. Tagged
inbound priority 100 and outbound priority 200 (after the core alias processor at 300).

The `releases` View page is registered at the numeric path `products/%node/releases`. This processor
lets editors and links use the product's *pretty* slug instead of a raw node ID.

**`processInbound($path, $request)`** — only acts on paths matching
`^/products/([^/]+)/releases$`. If the slug is already numeric it is returned unchanged. Otherwise
it resolves the slug to a product node ID, case-insensitively, in this order:
1. Path-alias lookup: `/products/<slug>` → `/node/<nid>`.
2. Exact `node.title` match where `type = 'product'`.
3. Title match with `-`/`_` treated as spaces.
On a match it rewrites the path to `/products/<nid>/releases`; otherwise it returns the path
unchanged (the View then renders its "no result" page). The DB lookup uses the parameterized query
builder (`node_field_data`, `condition('n.title', $variants, 'IN')`) — a bounded read, no raw SQL.
The rewrite only substitutes an internal numeric route path; access to the resulting page is still
enforced by the View's `access content` permission and its published-only filter.

**`processOutbound($path, &$options, …)`** — the reverse: when a link is generated for
`/products/<nid>/releases` (and `options['alias']` is not already set), it looks up the product's
alias and, if that alias is under `/products/<something>`, returns `<alias>/releases`. This is what
makes breadcrumbs and generated links use the pretty releases URL. If the product has no
`/products/...` alias it returns the numeric path unchanged.

Net effect: `/products/drupal-cms/releases`, `/products/webship-js/releases` and
`/products/webship_js/releases` all resolve to the same product's releases page served by the one
View, without relying on a Views string contextual filter.
