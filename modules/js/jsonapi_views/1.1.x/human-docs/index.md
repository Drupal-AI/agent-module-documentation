# JSON:API Views — manual setup guide

**JSON:API Views** (`jsonapi_views`) turns any Views display into a JSON:API
resource. Each enabled view display is exposed at
`/jsonapi/views/{viewId}/{displayId}`, so a decoupled front end — React, Vue,
Next.js, a mobile app — can consume a view's results over JSON:API, complete with
the view's filters, sorts, contextual arguments, and pagination. Instead of
hand-coding custom JSON:API queries, your site builders define the listing in
Views and the front end just reads it.

The client drives the view through query parameters: exposed filters via
`?views-filter[<id>]=<value>`, sorting via
`?views-sort[sort_by]=<id>&views-sort[sort_order]=DESC`, contextual filters via a
repeatable `?views-argument[]=<value>`, and pages via `?page=<n>`. The response is
a normal JSON:API collection document — typed entity resources, `prev`/`next`
pagination links, and a total `count` in its `meta`. Because it reuses the view
itself, you also inherit the view's caching and, importantly, its **access
control**: the resource enforces the view's own access check.

Every display is exposed **out of the box**. A Views **display extender** lets you
turn exposure off for a display that should stay internal — just uncheck "Expose
via JSON:API" on that display. A display that's disabled or access-denied returns
HTTP 403. There's **no module settings page**, no permission of its own, and no
Drush; it's a developer-facing tool configured entirely through Views. It depends
on core's **Views** module and the contributed **JSON:API Resources**
(`jsonapi_resources`) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including
   JSON:API Resources) and enable the module.

## Where it lives in the admin menu

There is no dedicated settings page. Two places matter, both under Views:

- **Structure → Views → Settings**
  (`/admin/structure/views/settings`) — enable the JSON:API Views **display
  extender** so its per-display checkbox appears.
- The **individual view display** — where you turn exposure on or off.

## How to use it

By default, once the module is enabled, every view display is already available at
`/jsonapi/views/{viewId}/{displayId}` (the `/jsonapi` part is your site's JSON:API
base path). To consume one:

- **Filter**: `?views-filter[field_category]=news`
- **Sort**: `?views-sort[sort_by]=created&views-sort[sort_order]=DESC`
- **Argument** (contextual filter, repeatable):
  `?views-argument[]=a&views-argument[]=b`
- **Paginate**: `?page=2`, and follow the `next` / `prev` links in the response;
  read the total from `meta.count`.

A handy shortcut: while **editing a view**, the live JSON:API URL for the current
display — reflecting your current filters, sorts, and arguments — is shown in the
Views **preview** panel, ready to copy.

### Turning exposure off for a display

Because every display is exposed by default, you only need to act when you want to
*keep one internal*:

1. Go to **Structure → Views → Settings** and, under **Display extenders**, tick
   **JSON:API Views**, then save. (Display extenders only show their settings once
   enabled site-wide.)
2. Edit the view. In the display's settings, open the **JSON:API → Expose via
   JSON:API** section and **uncheck** it to disable exposure for that display.
3. Save the view. That display now returns 403 instead of data.

You can expose several displays of one view (page, block, attachment) as separate
resources, and toggle each independently.
