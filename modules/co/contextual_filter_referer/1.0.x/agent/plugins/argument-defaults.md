<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views argument-default plugins (referer-derived)

## Install & enable

```bash
composer require drupal/contextual_filter_referer
drush en contextual_filter_referer -y
```

Only dependency is core **`views`**. No sub-modules, no permissions, no Drush commands, no
`.install`, no config objects or schema. Two `@ViewsArgumentDefault` plugins and two services are
all it ships.

## The problem it solves

A View rendered as a block (or supplying an entity-reference field's allowed values) derives its
contextual filter from the current URL. When the visitor paginates or submits an exposed filter,
Views reloads the display over its AJAX endpoint (`/views/ajax`); that request's URL is the AJAX
endpoint, not the page the View sits on, so a URL-based argument default resolves to nothing.
These plugins read the **`Referer` header** — which still points at the originating page — instead.

## Plugin 1 — `node_referer` ("Content ID from Referer")

`src/Plugin/views/argument_default/RefererNode.php`, class `RefererNode extends
ArgumentDefaultPluginBase implements CacheableDependencyInterface`.

- `create()` injects the `contextual_filter_referer.referer_route_match` service.
- `getArgument()`:
  ```php
  if (($node = $this->routeMatch->getParameter('node')) && $node instanceof NodeInterface) {
    return $node->id();
  }
  ```
  i.e. it asks the referer-derived route match for its `node` parameter and returns the node id
  (or nothing when the referring page is not a node route). This is the referer analogue of core's
  *"Content ID from URL"*. No plugin options.

## Plugin 2 — `referer_raw` ("Raw value from Referer URL")

`src/Plugin/views/argument_default/RefererRaw.php`, class `RefererRaw`.

- `create()` injects `path_alias.manager` and the `contextual_filter_referer.referer_path` service.
- `defineOptions()`:
  | Option | Default | Meaning |
  |---|---|---|
  | `index` | `''` | Which path component to return. **1-based** for humans (select built from `range(1,10)`); e.g. for `/admin/structure/types`, index `3` → `types`. |
  | `use_alias` | `FALSE` | Resolve the referring path through `aliasManager->getAliasByPath()` before splitting into components. |
- `buildOptionsForm()` renders `index` as a select and `use_alias` as a checkbox.
- `getArgument()` takes `refererPath->getRefererPath()`, right-trims the trailing slash, optionally
  aliases it, `explode('/')`s it, `array_shift()`s the empty leading element, and returns
  `$args[$this->options['index']]` when set. Referer analogue of core's *"Raw value from URL"*.

Both plugins set `getCacheMaxAge()` to `Cache::PERMANENT` and `getCacheContexts()` to `['url']`.

## Services (`contextual_filter_referer.services.yml`)

- **`contextual_filter_referer.referer_path`** → `RefererPathStack` (`src/RefererPathStack.php`,
  arg `@request_stack`). `getRefererPath()` reads the `Referer` header, strips
  `getSchemeAndHttpHost()` and the `?query`, and returns the path.
- **`contextual_filter_referer.referer_route_match`** → `Routing\RefererRouteMatch`
  (`src/Routing/RefererRouteMatch.php`, args `@request_stack`, `@router`). Implements
  `ResettableStackedRouteMatchInterface`. `getCurrentRouteMatch()` reads the `Referer` header,
  strips scheme+host and query, does `Request::create($path)`, `$router->matchRequest($request)`,
  and returns a `RouteMatch::createFromRequest()` (statically cached per request once a route is
  matched). The other interface methods delegate to this current route match. `matchRequest()` is
  internal Drupal routing — it does not perform an HTTP fetch.

## Wire it onto a View

1. Add a **contextual filter** to the View (e.g. *Content: ID* for `node_referer`, or the field
   your raw value targets for `referer_raw`).
2. Under *"When the filter value is NOT available"* choose **Provide default value**, then set
   **Type** to **Content ID from Referer** or **Raw value from Referer URL**.
3. For `referer_raw`, set **Path component** (1-based) and optionally **Use path alias**.

Config sketch (`views.view.*`, `display.*.display_options.arguments.<arg>`):

```yaml
default_argument_type: node_referer      # or: referer_raw
default_argument_options: {}             # node_referer has none
# for referer_raw:
# default_argument_type: referer_raw
# default_argument_options:
#   index: '3'
#   use_alias: false
```

Note: the module ships **no config schema** for the `referer_raw` options, so strict
config-schema tooling may warn on the view display; the options still save and work.

## Operating notes / caveats

- **`Referer` is client-supplied.** It can be absent (browser privacy settings, some proxies,
  direct navigation, HTTPS→HTTP transitions) or set to any value by the client. Give the contextual
  filter a sensible behaviour for the no-referer case (an argument with no default shows everything
  or nothing). Treat the derived value as *presentation context*, and keep real authorization in the
  View's own access settings and filters rather than in a referer-derived argument.
- Both the service and the route-match read the header via `$GLOBALS['request']->headers->get('referer')`
  (a legacy global) while using the injected `request_stack` for scheme/host; behaviour depends on
  that global being populated for the current request.
- `RefererRaw::getArgument()` uses `$this->options['index']` directly against the exploded path
  array; because the form is a `range(1,10)` select, valid indexes are 1–10 path components.
