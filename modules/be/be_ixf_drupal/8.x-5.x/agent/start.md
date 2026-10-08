<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BrightEdge IX Foundation (be_ixf_drupal) — agent index

BrightEdge Instant eXperience Framework (IXF) integration. A bundled PHP SDK
(`brightedge/be_ixf_php_sdk`, vendored under `vendor/brightedge/`) fetches vendor-managed
"capsules" over cURL at render time and injects the returned SEO markup, meta tags, and
redirects into node pages. Configure at `/admin/config/services/brightedge`.
Release **8.x-5.10**, branch `8.x-5.x`. Core `^8 || ^9 || ^10 || ^11`. No `permissions.yml`,
no Drush commands, no config schema.

## Mechanism (verified from source)

1. `be_ixf_drupal.services.yml` wires `brightedge.request` via `BrightEdgeFactory::createRequest`,
   which reads `be_ixf_drupal.settings` and builds a `BrightEdge\BEIXFClient` (with
   `defer.redirect = true`).
2. On construction the SDK (`vendor/brightedge/be_ixf_php_sdk/src/be_ixf_client.php`) builds the
   capsule URL from the API endpoint (default `https://ixfd-api.bc0a.com`), the account ID, and a
   page hash of the current URL (`$_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']`), then makes a
   blocking `curl_exec` call and deserializes the JSON capsule.
3. Injection points:
   - `be_ixf_drupal.module` `hook_page_attachments()` → attaches `$client->getHeadOpen()` to
     `html_head` via `Markup::create()` (raw), plus a `be:drupal` meta tag.
   - `Plugin/Block/IXFContentBlock` `build()` → emits `getBodyOpen()` / `getBodyString($fg)` through
     the `ixf_block` theme hook; `templates/ixf-block.html.twig` prints it with `{{ body_string|raw }}`.
   - `EventSubscriber/RedirectHTTPHeaders::onRespond()` (kernel RESPONSE) → for node routes, applies a
     capsule redirect (`hasRedirectNode()` / `getRedirectNodeInfo()`), cached per node under
     `be_ixf:redirect:node:<nid>` for `block_cache_max_age` seconds.

## Classes

- `Factory/BrightEdgeFactory` — builds the SDK client from config; static per-URL client cache.
- `Form/AdminForm` (`ConfigFormBase`) — the settings form (`be_ixf_drupal.settings`).
- `Plugin/Block/IXFContentBlock` — block plugin emitting body-level capsule content.
- `EventSubscriber/RedirectHTTPHeaders` — applies capsule redirects on the response.
- `Service/BrightEdgeService` — thin service holding config/db/language handles (namespaced
  `Drupal\brightedge\Service`, **not** registered in `services.yml`; effectively unused/dead code).

## Settings (`be_ixf_drupal.settings`, via `/admin/config/services/brightedge`)

`capsule_mode` (`REMOTE_PROD_CAPSULE_MODE` | `REMOTE_PROD_GLOBAL_CAPSULE_MODE`), `account_id`
(required, `f000000ZZZ`), `enable_storage_capsule` (bool), `api_endpoint` (optional, must be an
`*-api.bc0a.com` host), `block_cache_max_age` (int seconds), `canonical_host` (optional),
`protocol` (`http`/`https`, used for canonical-URL construction — not the API-fetch scheme).

See `config/settings.md` for the config surface in detail.

## Gotchas to flag

- **`_permission: 'administer'` is not a real Drupal permission.** Verified absent from the
  permission system. It fails closed: `hasPermission('administer')` is TRUE only for `is_admin`
  roles (and uid 1), so the settings form is administrator-only *by accident* and cannot be
  delegated to an SEO role. This is a broken delegation model, not an exposure.
- **Bundled default config never imports.** `config/install/be_ixf_drupal.settings.xml` is YAML
  content with a `.xml` extension; Drupal's config installer only reads `*.yml`, so no defaults are
  seeded and the account ID must be entered manually after install (confirmed: `drush cget
  be_ixf_drupal.settings` returns nothing on the running site).
- **Vendor is in the render path.** SDK cURL timeouts are clamped to ~1000ms and it fails soft, but
  it is still a synchronous outbound call on node responses.
- **Injected capsule content is trusted, raw markup** (`Markup::create` / Twig `|raw`) and can also
  force a redirect. The BrightEdge account's publishers are inside your trust boundary.
