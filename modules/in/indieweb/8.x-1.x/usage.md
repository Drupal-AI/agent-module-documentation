<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IndieWeb is the main module containing services, permissions and more for IndieWeb building blocks.

---

IndieWeb brings the **IndieWeb** building blocks to Drupal — via submodules for **IndieAuth**
(authentication/token endpoints), **Micropub** (create posts via a token-authenticated API), **Webmention**
(receive/send cross-site mentions), **Microsub**, **WebSub**, microformats, contact and feeds — so a Drupal
site can act as an IndieWeb identity that owns its content and interoperates with the open social web. It
provides its own permissions, an admin dashboard (`indieweb.admin.dashboard`), in the IndieWeb package.

Use it to make a site IndieWeb-capable. It touches authentication and public endpoints, and the endpoints are
**correctly gated**: the Micropub endpoint (`/indieweb/micropub`, deliberately public so it can receive
tokens) **validates the IndieAuth bearer token and scope on every branch** — returning 401 when the
`Authorization` header is missing/invalid and 403 when the token's scope is insufficient, before creating any
content (verified). Security notes when adopting: IndieAuth turns the site into an identity/token authority —
keep it and its tokens well-configured and served over **HTTPS**; the Webmention endpoint accepts inbound
cross-site input (treat received mentions as untrusted content — moderate/verify sources). It grants access
only through its permissions and token scopes. Configure the endpoints you need.

---

- Provide IndieWeb building blocks.
- Offer IndieAuth token endpoints.
- Offer a Micropub posting API.
- Receive/send Webmentions.
- Provide Microsub/WebSub/microformats.
- Act as an IndieWeb identity.
- Validate the IndieAuth token + scope on Micropub (401/403).
- Serve token endpoints over HTTPS.
- Treat inbound Webmentions as untrusted.
- Grant access via permissions + token scopes.
- Provide an admin dashboard.
- Configure the endpoints.
- Handle IndieWeb.
- Own your content.
- Configure IndieAuth.
- Handle Micropub.
- Interoperate with the open web.
- Handle Webmentions.
- Provide its own permissions.
- Configure IndieWeb endpoints.
