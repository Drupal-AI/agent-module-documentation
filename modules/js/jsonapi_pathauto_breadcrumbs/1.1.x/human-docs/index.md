# JSON:API Pathauto Breadcrumbs — manual setup guide

**JSON:API Pathauto Breadcrumbs** (`jsonapi_pathauto_breadcrumbs`) enriches
JSON:API responses with a ready-made breadcrumb trail, derived from the entity's
URL alias. In a decoupled or headless setup, a front end otherwise has to recompute
breadcrumbs itself from the URL structure; this module does that work on the server
and includes the result in the JSON:API output, so the front end can just render
it.

The breadcrumb is attached to the resource's `path` object. For an entity aliased
at `/projects/project-1`, the response's `path.breadcrumbs` becomes a list like
Home → Projects → Project 1, each entry carrying a `path` and a `label`:

```json
{
  "path": {
    "alias": "/projects/project-1",
    "breadcrumbs": [
      { "path": "/",                  "label": "Home" },
      { "path": "/projects",          "label": "Projects" },
      { "path": "/projects/project-1", "label": "Project 1" }
    ]
  }
}
```

The breadcrumb reflects the URL alias and routing structure — public information —
and the module has **no access-control role**: it does not change what JSON:API
exposes, and JSON:API's own access still applies to every response. It builds on
core JSON:API and the [JSON:API Extras](https://www.drupal.org/project/jsonapi_extras)
module, whose resource-override UI is where you turn the breadcrumb enhancer on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its JSON:API Extras dependency.

There is **no dedicated settings page** for this module — you enable it per
resource through JSON:API Extras, described below.

## Where it lives in the admin menu

You turn on the breadcrumbs through JSON:API Extras at **Configuration → Web
services → JSON:API → Resource types**
(`/admin/config/services/jsonapi/resource_types`).

## How to use it

1. Go to `/admin/config/services/jsonapi/resource_types` and **override** the
   resource you want breadcrumbs on.
2. Pathauto provides a **Path** field on the resource. On that field's **advanced**
   operation, select the **Breadcrumbs Field** enhancer.
3. Save. Fetch that resource over JSON:API and confirm the `path.breadcrumbs` list
   now appears in the response.
