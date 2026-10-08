# How Current Page Crumb works (the breadcrumb builder)

The entire module is one service class, `Drupal\current_page_crumb\BreadcrumbBuilder`, plus a
service definition. No config, no schema, no forms, no hooks.

## Service registration

`current_page_crumb.services.yml`:

```yaml
services:
  current_page_crumb.breadcrumb:
    class: Drupal\current_page_crumb\BreadcrumbBuilder
    parent: system.breadcrumb.default          # reuses core PathBasedBreadcrumbBuilder deps
    tags:
      - { name: breadcrumb_builder, priority: 1003 }
```

- `parent: system.breadcrumb.default` means it inherits the constructor arguments of core's
  path-based breadcrumb builder (title resolver, path matcher, request context, etc.).
- `priority: 1003` puts it **above** core's default builder in the `breadcrumb` chain, so on a
  normal front-end route this builder's result is the one used.

The class extends `Drupal\system\PathBasedBreadcrumbBuilder`, so it does **not** override
`applies()` — it applies wherever the path-based builder would, and its high priority makes it
win.

## What `build()` does

1. `$breadcrumbs = parent::build($route_match);` — get the normal path-based trail
   (`Home › …` from the URL segments).
2. Read the current route object from the request (`RouteObjectInterface::ROUTE_OBJECT`).
3. **Only if** the route exists **and** it is **not** an admin route
   (`!$route->getOption('_admin_route')`) **and** it is **not** the front page
   (`!$this->pathMatcher->isFrontPage()`):
   - `$title = $this->titleResolver->getTitle($request, $route);`
   - If `$title` is empty, fall back to the last URL path segment, with `-`/`_` replaced by
     spaces and the first letter upper-cased (`Unicode::ucfirst`).
   - Append it: `$breadcrumbs->addLink(Link::createFromRoute($title, '<none>'));`
     The `<none>` route ⇒ the crumb is rendered as **plain text, not a link**.
4. Cacheability:
   - For a `view_id` route parameter, adds cache tag `config:views.view.<view_id>`.
   - Any route parameter implementing `CacheableDependencyInterface` is added as a cacheable
     dependency.
   - Adds cache contexts `['route', 'url.path', 'languages']`.

So the last crumb is always the current page's title (or a path-derived fallback), unlinked,
except on admin pages and the front page, where the trail is left exactly as the parent built it.

## Consequences an agent should know

- **Nothing to configure.** `configure` is `null`; there is no settings form and no config
  object. Enabling the module is the whole setup.
- **Prerequisite: the Breadcrumb block must be placed.** current_page_crumb only changes what
  the breadcrumb *contains*; it does not render anything itself. If no breadcrumbs show up,
  the theme is missing a `system_breadcrumb_block` placement — place the "Breadcrumb" block in
  the active theme (e.g. Olivero's `breadcrumb` region).
- **Admin routes and the front page are intentionally skipped** — do not expect the extra
  crumb there.
- **The last crumb is unlinked** (`<none>`), by design — clicking it does nothing.

## Overriding / disabling behaviour

- **Disable it:** `drush pmu current_page_crumb -y`. Breadcrumbs revert to core's default
  path-based trail (no title crumb).
- **Change which builder wins:** breadcrumb builders are chosen by tag priority. To supersede
  current_page_crumb, register your own `breadcrumb_builder` service with a priority **above
  1003**; to let core win again, you would need a builder above 1003 (core's default is far
  lower), so simply uninstalling is the practical route.
- **Subclass it:** because it is an ordinary service extending `PathBasedBreadcrumbBuilder`,
  you can register a service `parent: current_page_crumb.breadcrumb` (or extend the class) and
  override `build()` to tweak the title/fallback logic.
