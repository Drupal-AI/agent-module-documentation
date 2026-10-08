# JSON:API Menu items — manual setup guide

**JSON:API Menu items** (`jsonapi_menu_items`) exposes each of your site's menus —
its full tree of links — as a JSON:API resource, so a decoupled or headless
front end (React, Vue, Next.js, a mobile app) can fetch your navigation over the
API instead of hard-coding it.

Core's own JSON:API can serve content entities but not menu *link trees*. This
module fills that gap by adding one read-only endpoint,
`/jsonapi/menu_items/{menu}`, where `{menu}` is a menu's machine name — for example
`/jsonapi/menu_items/main` for the Main navigation, or `/jsonapi/menu_items/footer`.
The response lists every enabled link in menu order, each with its title, resolved
URL, route, weight, parent, and more, so the client can rebuild the menu without
re-implementing Drupal's routing. Links the current user cannot access are dropped
automatically, and you can narrow a request with query filters such as
`?filter[max_depth]=2` or `?filter[parent]=system.admin`.

The module works the moment you enable it — there is no settings page, no
permissions, and nothing to configure. It depends on core's **Custom Menu Links**
(`menu_link_content`) and the contributed **JSON:API Resources**
(`jsonapi_resources`) module. It also picks up config-defined links when the
**Menu Link (Config)** module is present, and extra fields added by **Menu Item
Extras**. One optional submodule, **JSON:API Menu items — Hypermedia**
(`jsonapi_menu_items_hypermedia`), adds discoverable `menu_items` links to the
`/jsonapi` root document (it needs the JSON:API Hypermedia module).

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — the full endpoint, response fields,
and filters — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   JSON:API Resources dependency, and enable the module (plus the optional
   submodule).

## Where it lives in the admin menu

Nowhere — there is no admin page or settings form. The module's entire surface is
the JSON:API endpoint it registers.

## How to use it

Once the module is enabled, request any menu by its machine name:

```bash
# All enabled links in the main menu:
curl -s "https://example.com/jsonapi/menu_items/main" \
  | jq '.data[].attributes | {title, url, weight}'

# Only the top level of the main menu:
curl -s "https://example.com/jsonapi/menu_items/main?filter[max_depth]=1"

# Only the subtree under a given parent link:
curl -s "https://example.com/jsonapi/menu_items/main?filter[parent]=standard.front_page"
```

Each returned link includes `title`, `url`, `route` (name + parameters), `weight`,
`enabled`, `expanded`, `menu_name`, `parent`, `provider`, `options`, and
`description`. The tree is flattened into a single list — use each link's `parent`
and `weight` to rebuild the hierarchy on the client. The endpoint is read-only
(GET); there is no write support. For the full list of response attributes and
query filters, see the [`agent/` resource docs](../agent/api/resource.md).
