<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varbase API provides a JSON:API-based web-services layer with authentication and authorization for the Varbase distribution, for content ingestion by other applications.

---

Varbase API is the web-services layer of the Varbase Drupal distribution. It provides a JSON:API
implementation with authentication and authorization configured so that other applications can ingest
content from a Varbase site. Rather than exposing JSON:API raw, it packages the API access controls
(who may read/write which resources, and how requests authenticate) appropriate for a decoupled or
integrated consumer, and offers a settings form (`varbase_api.settings`) to manage that surface.

Use it on a Varbase site that needs to serve content to external applications or a decoupled front
end. The security-relevant aspects are the authentication/authorization configuration it manages —
which entities and operations are exposed over the API and which credentials/roles are required — so
review those settings and the underlying JSON:API/OAuth configuration before exposing the API
publicly. It provides its own permissions for administering the API configuration and expects the
Varbase ecosystem.

---

- Serve Varbase content over JSON:API.
- Authenticate and authorize API access.
- Let external apps ingest content.
- Configure API access at varbase_api.settings.
- Expose selected entities over the API.
- Control which operations the API allows.
- Secure the API with authentication.
- Administer API config via permissions.
- Support a decoupled Varbase front end.
- Package JSON:API access controls.
- Require credentials/roles for API requests.
- Review exposed resources before going public.
- Integrate content ingestion for other apps.
- Build a decoupled site on Varbase.
- Manage read/write access per resource.
- Expect the Varbase distribution ecosystem.
- Layer auth/authz over JSON:API.
- Expose menus/content to consumers.
- Govern API surface via settings.
- Protect write operations behind auth.
