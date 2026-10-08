<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redoc Field Formatter renders an OpenAPI specification stored in a file or link field as browsable API documentation, using Redoc.

---

An organisation publishing an API has a specification file — `openapi.yaml` or `openapi.json` — and needs it presented as documentation rather than downloaded as YAML. Redoc is one of the two standard renderers for that (Swagger UI is the other), producing a three-column reference from the spec. This module wires it to Drupal fields: upload the spec to a file field, or point a link field at a hosted one, choose the **Redoc UI** formatter, and the node renders the documentation. Depends on core `file` and `link`; version **3.1.0** on `^9.3 || ^10 || ^11`. The implementation detail that matters operationally: the library is declared as an **external script from `cdn.jsdelivr.net`** (`redoc@2.0.0/bundles/redoc.standalone.js`, `type: external`), not shipped locally. That has three consequences worth deciding on before launch — the page depends on jsDelivr being reachable, which fails in restricted networks and in air-gapped environments; a **Content-Security-Policy** must allow that host or the documentation silently does not render; and there is **no subresource-integrity hash** on the declaration, so the site executes whatever that URL returns. Sites with a strict CSP or a privacy requirement normally vendor the library locally and override the library definition.

---

- Publish API documentation on a site.
- Render an OpenAPI spec as docs.
- Show a Swagger file as a reference.
- Upload a spec and display it.
- Link to a hosted OpenAPI file.
- Give developers browsable API docs.
- Version API documentation as content.
- Publish documentation per API.
- Show endpoint details on a page.
- Replace a separate docs site.
- Keep API docs behind site access control.
- Document an internal API.
- Show a spec alongside a description.
- Publish a partner integration guide.
- Render JSON or YAML specs.
- Add docs to a developer portal.
- Manage specs through Drupal.
- Keep API docs under editorial workflow.
