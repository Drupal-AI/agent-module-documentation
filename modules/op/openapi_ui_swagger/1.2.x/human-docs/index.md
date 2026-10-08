# Swagger UI for OpenAPI UI — manual setup guide

**Swagger UI for OpenAPI UI** (`openapi_ui_swagger`) renders an
OpenAPI/Swagger specification as the familiar, interactive **Swagger UI**
documentation explorer — the page where developers can browse your API's
endpoints, expand each one to see its parameters and responses, and use the
"Try it out" button to fire real requests against a live endpoint. It is the
piece that turns a machine-readable API spec into a human-friendly, browsable
reference.

The module is a thin bridge. It plugs a **Swagger UI** renderer into the
OpenAPI UI plugin system provided by the separate [OpenAPI UI](https://www.drupal.org/project/openapi_ui)
module, and it relies on the third-party **swagger-ui** JavaScript library to do
the actual rendering in the browser. On its own it produces nothing visible —
you also need a *generator* module (such as OpenAPI JSON:API) to produce a spec,
and the OpenAPI module to expose the docs pages. Because it is just one of
several possible renderers, you can switch between Swagger UI and ReDoc simply by
changing one word in the docs URL.

There is **nothing to configure** in this module: it has no settings form, no
permissions of its own and no config. Setup is entirely a matter of installing
the pieces (this module, its dependencies and the swagger-ui library) and
knowing which URL to open.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, its dependencies
   and the swagger-ui library, and find the docs page.

## Where it lives in the admin menu

This module adds no menu items of its own. The browsable docs pages come from
the **OpenAPI** module and live under **Configuration → Web services → OpenAPI**
(`/admin/config/services/openapi`). That page lists the available documentation;
each entry opens at a URL of the form
`/admin/config/services/openapi/swagger/{generator}` — for example
`/admin/config/services/openapi/swagger/jsonapi` to view your JSON:API spec
rendered as Swagger UI. Access is controlled by the OpenAPI module's **Access
OpenAPI api docs** permission.

## How to use it

Once everything is installed and a generator (such as OpenAPI JSON:API) is
enabled, go to **Configuration → Web services → OpenAPI**, then open the Swagger
UI version of the spec you want. You can now browse every endpoint, read its
schema, and use **Try it out** to send authenticated requests by hand — handy
for front-end developers exploring your API, QA testers firing calls, or partner
integrators onboarding against a stable contract.

To switch the same page to ReDoc instead (if you have the ReDoc renderer
installed), just replace `swagger` with `redoc` in the URL — nothing in
configuration records a "current" renderer. Developers can also embed the
explorer inside a custom admin page by rendering an `openapi_ui` element with
`#openapi_ui_plugin` set to `swagger`; see the sibling
[`agent/`](../agent/start.md) docs for the render-element details.
