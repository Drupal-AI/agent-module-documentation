<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CloudFilt (cloudfilt) — agent index

A **traffic-protection integration** for the third-party **CloudFilt** service. It works in two
independent ways at once: (1) a **client-side script** (`analyz.js`) injected into every HTML page
via `hook_page_attachments`, and (2) a **server-side HTTP stack middleware** that, on every request,
POSTs the visitor's IP + request URI + (filtered) request body to the CloudFilt API and, if CloudFilt
does not answer `OK`, issues a **307 redirect** to a CloudFilt "stop" page. Aimed at bots, scraping,
Tor, spam, fraud and DDoS. No config schema, no permissions of its own, no submodules. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed **1.0.6** (version dir `1.0.x`).

## Dependencies

- Drupal modules: none beyond core (`user` is used implicitly via `User::load`). `.info.yml` declares
  no `dependencies`.
- PHP libraries: none (no `composer.json` ships). Uses core's `http_client` (Guzzle).

## What it provides (from source)

- **Config form** `cloudfilt.config` → route `/admin/config/services/cloudfilt`
  (`src/Form/CloudfiltConfigForm.php`, extends `ConfigFormBase`). Fields: `key_front` (Public Key),
  `key_back` (Private Key), `roles_exclude` (checkbox), `roles` (checkboxes). On validate/submit it
  POSTs the key pair to `https://api.cloudfilt.com/checkcms/drupal.php`; the JSON response's `site`
  value is stored as `key_site`. Route requirement: `_permission: 'access administration pages'`.
  Admin menu link `cloudfilt.config` under `system.admin_config_services`
  (`cloudfilt.links.menu.yml`).
- **HTTP middleware** service `cloudfilt.stack_middleware`
  (`src/StackMiddleware/CloudfiltStackMiddleware.php`), tagged `http_middleware` `priority: 280`,
  `responder: true` (`cloudfilt.services.yml`). Runs after the kernel produces a response; if
  `key_site` is set and the current user's roles are not in the excluded set, it calls
  `https://api{key_site}.cloudfilt.com/phpcurl` and may replace the response with a 307 redirect to
  `https://cloudfilt.com/stop-{ip}-{key_front}`.
- **Page attachment** `hook_page_attachments` (`cloudfilt.module`) injects an async
  `<script src="https://srv{key_site}.cloudfilt.com/analyz.js?render={key_front}">` into `html_head`,
  subject to the same role-exclusion logic.
- **Runtime requirement** `hook_requirements` (`cloudfilt.module`): OK when `key_site` is set,
  otherwise a WARNING linking to the config form.
- **Config object** `cloudfilt.config` with keys `key_front`, `key_back`, `key_site`, `roles_exclude`,
  `roles`. No config `schema/` file ships (schema-less config).

## Solution docs

- **Config form, keys, key validation call, role exclusion** → [config/settings.md](config/settings.md)
- **Stack middleware request filter + injected client script (runtime flow)** →
  [runtime/request-filter.md](runtime/request-filter.md)
