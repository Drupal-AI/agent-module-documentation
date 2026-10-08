# Event subscribers — variant selection & route override (API)

Two `event_subscriber`-tagged services carry the whole mechanism. Neither exposes an integrator API;
this file documents *how* the page shell is applied so you can reason about it.

## 1. Page display variant selection

Service `panels_everywhere.page_display_variant_subscriber` (priority `1000`), class
`EventSubscriber\PanelsEverywherePageDisplayVariantSubscriber` (arg `@entity_type.manager`, keeps the
`page` entity storage). Subscribes to **`RenderEvents::SELECT_PAGE_DISPLAY_VARIANT`** via
`onSelectPageDisplayVariant()`.

Flow (`onSelectPageDisplayVariant`):

1. Get the current route object from the event's route match.
2. **If the route has option `_admin_route`, return immediately** — admin pages keep the normal theme
   page, Panels Everywhere never applies to them.
3. `getVariantPlugin($route)` looks for an applicable `panels_everywhere_variant`. If found, it sets
   the event's plugin id, plugin configuration and contexts to that variant and calls
   `stopPropagation()` — so core renders the page through this variant instead of `block_page`.

`getPagesFor($route)` decides which page(s) apply, in order:

- **pass 1** — if the route has a `page_id` default (the route subscriber sets this, below) and that
  `page` entity is loaded and `status` (enabled), use it.
- **pass 2** — additionally include the global **`site_template`** page if it exists and is enabled.

`getVariantPlugin()` then walks each page's variants, skips ones failing `checkVariantAccess()`
(`$variant->access('view')`, treating a `ContextException` as denied — copied from Page Manager's
`VariantRouteFilter`), and returns the first variant whose plugin id is `panels_everywhere_variant`
(after `setContexts()`). Returns NULL when nothing matches, leaving the default page variant in place.

## 2. Route subscriber (strip Page Manager's override)

Service `panels_everywhere.route_subscriber` (priority `-200`), class
`Routing\PanelsEverywhereRouteSubscriber` **extends `Drupal\page_manager\Routing\PageManagerRoutes`**
(args `@entity_type.manager`, `@cache_tags.invalidator`). Overrides `alterRoutes(RouteCollection)`.

Why it exists: Page Manager, for each variant, normally **adds a route that overrides** the target
path — which would replace the original route and stop its content from rendering. Panels Everywhere
wants the original route to keep running (so it can supply the "Main Page Content"), so it *removes*
that override unless the variant opted in with `route_override_enabled`.

`alterRoutes()` per enabled page with variants:

- For each `panels_everywhere_variant` variant, call `getRouteAndCleanup($page, $variant, $collection)`
  and, on the returned route, `setDefault('page_id', $page->id())` — this is the `page_id` the
  selection subscriber reads in pass 1.
- Only if at least one `panels_everywhere_variant` is present, also stamp `page_id` onto the routes of
  the page's **other** (non-panels-everywhere) variants via `getRouteFor()`.

`getRouteAndCleanup()` (route name `page_manager.page_view_{page_id}_{variant_id}`):

- If the variant route is missing → return NULL.
- If `$variant->getVariantPlugin()->isRouteOverrideEnabled()` is **TRUE** → return the variant route
  as-is (keep the override; Page Manager owns the path).
- Otherwise (**default**) → read the override's `overridden_route_name`, **`$collection->remove()`**
  the Page Manager route, and return the *original* route (so the real controller runs and
  `page_id` gets stamped onto it).

`getSubscribedEvents()` is inherited from `PageManagerRoutes` (reacts on `RoutingEvents`), so route
changes take effect on the next router rebuild (`\Drupal::service('router.builder')->rebuild()`).

## Net effect

For a non-admin request, if an enabled page (a matching one, else `site_template`) has an accessible
`panels_everywhere_variant`, core renders the page through the Panels variant; the variant's
"Main Page Content" block still receives the original route's output because the route override was
removed. Admin routes and routes with no applicable variant are untouched.
