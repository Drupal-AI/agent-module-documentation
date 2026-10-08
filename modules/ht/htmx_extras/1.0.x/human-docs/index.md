# HTMX Extras — manual setup guide

**HTMX Extras** (`htmx_extras`) adds a set of Drupal-flavored features built on the
HTMX library, with a focus on **lazy loading** — deferring the rendering of parts
of a page until they are actually needed, which improves perceived performance.
It is aimed at developers and site builders comfortable with render arrays and
Views, rather than being a one-click feature.

The module currently offers a few building blocks:

- **Lazy-load an entity** — a render helper that loads a rendered entity on demand
  via HTMX. Crucially, the endpoint checks `access('view')` on the entity before
  rendering, so it respects entity view access.
- **Lazy-load a route** — a render helper that loads the contents of a given route
  on demand.
- **Search API lazy-load row plugin** — renders Views rows lazily as they scroll
  into the viewport.
- **HTMX-powered views** — a newer feature that lets you build highly reactive
  Views (rivaling a JavaScript app) using mostly Drupal-core technologies, with a
  little AlpineJS for updating the browser URL history.

A note on access checks worth keeping in mind: the entity lazy-load endpoint
accepts an optional revision ID and checks only the default `view` access on the
loaded revision, not revision-specific view access. For **published** entities this
means a historical revision could be rendered to a user who lacks the
`view revisions` permission — a low-impact information exposure. (Publish-status
access still applies to unpublished revisions.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no single settings form** for this module. The lazy-load helpers are
used from code, and HTMX views are built through the workflow described below.

## Where it lives in the admin menu

HTMX views are managed at **`/admin/structure/htmx-view`**, where you create and
configure each HTMX view. Managing HTMX views is gated by the
`administer htmx_view` permission, so grant that only to trusted administrators.

## How to use it

**Lazy-load an entity or route (from code):**

```php
use Drupal\htmx_extras\Render\HtmxEntityPartial;

$build = HtmxEntityPartial::fromEntity($entity)
  ->setViewMode('teaser')
  ->setHtmxParameter('trigger', 'load')
  ->render();
```

`HtmxRoutePartial::fromRoute('my_module.route_name', $params, $options)` works the
same way for lazy-loading a route's contents. Use `setHtmxParameter('trigger',
'intersect once')` to load only when the element scrolls into view.

**Set up an HTMX view:**

1. Add a **REST Export** display to your View.
2. Use the **Facets serializer** display format, and turn on "Display pager and
   results." (For the pager to work correctly you currently need the patch from
   [facets issue #3008615](https://www.drupal.org/project/facets/issues/3008615).)
3. Use **fields**, add only the Search API **Item ID** field, and give it an alias
   such as `id` in its format settings.
4. Use the **Full** pager and set your items-per-page.
5. Configure the rest of the view (filters, sorts) as needed, using normal facets
   (the new Views exposed facets from Facets 3.x are not yet supported).
6. Go to **`/admin/structure/htmx-view`**, create a new HTMX view, and configure
   it — remember to use the `id` alias in the "Item ID" field mapping.
