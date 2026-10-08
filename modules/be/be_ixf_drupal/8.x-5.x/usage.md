<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BrightEdge IX Foundation connects a Drupal site to the BrightEdge (bc0a.com) SEO platform: a bundled PHP SDK fetches vendor-managed "capsules" server-side at render time and injects the returned meta tags, markup, and redirects into node pages, so an SEO team can change on-page content from BrightEdge instead of in Drupal.

---

The IXF model puts a third-party service in the page render path. On each node request the module's factory builds a `BEIXFClient` (bundled `brightedge/be_ixf_php_sdk`), which constructs a capsule URL from the configured account ID (`f000000ZZZ` form), the default API endpoint `https://ixfd-api.bc0a.com`, and an MD5-style hash of the current page URL, then makes a blocking cURL call to that endpoint. The JSON "capsule" it returns drives three injection points: `hook_page_attachments()` in `be_ixf_drupal.module` attaches the capsule's head string to `html_head` (wrapped in `Markup::create`, i.e. raw); the `IXFContentBlock` block plugin emits body-level capsule content through the `ixf_block` theme template, which prints it with Twig's `| raw` filter; and the `RedirectHTTPHeaders` kernel RESPONSE subscriber applies a capsule-defined 301/302 redirect (cached per node under `be_ixf:redirect:node:<nid>`). All settings live in `be_ixf_drupal.settings` and are edited at `/admin/config/services/brightedge` via `AdminForm`: capsule mode (Production / Production Global), account ID, optional API endpoint, canonical host, canonical protocol, storage-capsule toggle, and block cache max-age.

Two operational facts matter before deploying. First, the vendor is a live dependency inside rendering — the SDK caps its cURL connect/socket timeouts at ~1000ms and fails soft (a missing capsule just injects nothing), but it is still a synchronous outbound call on cacheable node responses. Second, the settings route is guarded by `_permission: 'administer'`, which is not a real Drupal permission; it therefore fails closed and the form is reachable only by roles flagged `is_admin` (and user 1), so the settings cannot be delegated to a non-admin SEO role. The bundled default config ships as `config/install/be_ixf_drupal.settings.xml` (a `.xml` extension on YAML content), which Drupal's config installer ignores, so the account ID must be entered by hand after install. The capsule fetch uses cURL with TLS verification left at its secure default and targets a fixed `*-api.bc0a.com` endpoint.

The trust boundary is worth stating plainly: whatever BrightEdge returns is rendered under your domain as trusted markup, so anyone able to publish a capsule in the BrightEdge account can publish HTML — and redirects — on your site.

---

- Inject BrightEdge-managed SEO content into node pages server-side.
- Let an SEO team change on-page meta and content without a Drupal deploy.
- Add BrightEdge "Autopilot" managed internal links to templates.
- Place a BrightEdge capsule as a block via the IXFContentBlock plugin.
- Serve SEO content to crawlers server-side rather than through JavaScript.
- Apply BrightEdge-defined 301/302 redirects to node URLs.
- Connect a Drupal site to a BrightEdge account by account ID.
- Configure the IXF connector (endpoint, canonical host/protocol) from the admin form.
- Switch between Production and Production Global (page-independent) capsule modes.
- Enable the SCP 2.0 storage-capsule mode.
- Tune how long capsule blocks are cached (block cache max-age).
- Control which pages carry capsules using block visibility conditions.
- Route the capsule fetch through an outbound proxy (SDK-level config).
- Audit an inherited site's BrightEdge configuration and endpoint.
- Review what markup a vendor is injecting into your pages during a security audit.
- Confirm the capsule fetch is TLS-verified and points at a bc0a.com endpoint.
- Check the SDK's render-path timeout before a high-traffic rollout.
- Plan for graceful degradation when BrightEdge is slow or unreachable.
- Understand why the settings page cannot be delegated to a non-admin role.
- Diagnose why bundled default config did not import after install.
- Decide whether server-side third-party injection fits your risk model.
- Verify the BrightEdge account's own publishing controls, since they are now in your trust boundary.
