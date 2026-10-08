<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Views exposes every Views display as a JSON:API resource at `/jsonapi/views/{viewId}/{displayId}`, so a decoupled front end can consume a view's results (with its filters, sorts, arguments and pagination) over JSON:API.

---

The module registers a dynamic route per enabled view + display (`Routing\Routes::routes()`), each backed by a single `jsonapi_resources` resource (`Resource\ViewsResource`) that previews the view and returns its result rows as a JSON:API collection document, including `prev`/`next` pagination links and a `count` meta. Exposed filters, sorts and contextual arguments are passed as query parameters: `?views-filter[<id>]=<value>`, `?views-sort[sort_by]=<id>` / `?views-sort[sort_order]=<ASC|DESC>`, `?views-argument[]=<value>` (repeatable), and `?page=<n>` for pagination. A Views **display extender** (`jsonapi_views`, option `enabled`, default TRUE) controls exposure: every display is exposed out of the box, and you disable one by editing the view and unchecking "Expose via JSON:API" (persisted at `display_options.display_extenders.jsonapi_views.enabled`). A disabled or access-denied resource returns 403. While editing a view, `hook_views_preview_info_alter()` shows the live JSON:API URL (with current filters/sorts/args) in the preview panel. There is no admin settings page, permission, or Drush; access is the view's own access check. It depends on core Views and the contrib `jsonapi_resources` module.

---

- Fetch a Views listing (e.g. a "Latest articles" view) from a React/Vue/Next.js front end.
- Reuse existing site-builder Views as read APIs instead of hand-coding JSON:API filters.
- Pass exposed filter values from the client via `?views-filter[field]=value`.
- Sort results from the client via `?views-sort[sort_by]=…&views-sort[sort_order]=DESC`.
- Feed a view's contextual filter (argument) via `?views-argument[]=…`.
- Paginate a decoupled listing with `?page=2` using the returned `next`/`prev` links.
- Read the total result count from the response's `meta.count`.
- Expose a curated, access-controlled content feed without writing a custom resource.
- Disable JSON:API exposure for a specific view display that should stay internal.
- Keep a view internal by unchecking "Expose via JSON:API" on its display.
- Combine multiple contextual arguments (`?views-argument[]=a&views-argument[]=b`).
- Serve a filtered product/event list to a mobile app via JSON:API.
- Leverage the view's caching and access control for the API response automatically.
- Copy the exact JSON:API URL for a display straight from the Views preview panel.
- Build a headless search results page powered by an exposed-filter view.
- Provide a stable, versionable API surface defined entirely in Views config.
- Migrate a REST-export view to JSON:API consumption with minimal changes.
- Return entity resources (JSON:API typed) rather than raw rendered rows.
- Let editors change what the API returns by editing the underlying view.
- Expose several displays of one view (page, block, attachment) as separate resources.
