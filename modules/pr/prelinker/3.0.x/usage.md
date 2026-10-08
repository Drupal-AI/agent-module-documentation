<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prelinker manages `preload` and `preconnect` resource hints as configuration, emitting them either as `Link:` response headers or as `<link>` elements in the head. Both preconnect domains and preload files are their own configuration entities, and each can be gated by Drupal condition (visibility) plugins.

---

Resource hints tell the browser to start work it would otherwise only discover later. `preconnect` opens the DNS/TCP/TLS connection to a host — a font provider, an image CDN, an analytics endpoint — before anything on it is requested, saving handshake round trips that otherwise sit in the critical path. `preload` fetches a specific file early. Both normally live in a theme's `html.html.twig` or in a `hook_page_attachments()`, meaning a deploy to add or change one. Prelinker makes them **configuration**: preconnect domains (`domain`) and preload files (`file`, `as` type, optional `fetchpriority` of `high`/`low`/`auto`) are each stored as their own **configuration entities** — listable, exportable, drag-orderable by `weight`, and individually editable. Every entry carries **visibility conditions** built on Drupal's condition plugin system (request path, content type, language, theme, and so on), so a hint can be scoped — for example, preload a hero image only on the front page. Delivery is chosen per hint type with checkboxes on the settings form (`/admin/config/system/prelinker`): emit into the `<head>` as `<link>` elements (`hook_page_attachments()`), or as `Link:` response headers (a decorator on core's `html_response.attachments_processor`). The header option is the more interesting: a header can be acted on by an intermediary and, over HTTP/2 or 3, is available before the HTML body arrives — earlier than a tag in the head. The header processor can also **scan the rendered HTML** and lift hints in automatically: elements carrying `data-preload-image="..."` (preloaded as images), existing `<link rel="preload">` and `<link rel="preconnect">` tags, `<link rel="stylesheet">` files, and CSS `@import` URLs — each toggled independently. Nothing is emitted on admin routes. Version **3.0.0**, core requirement **`^11`** — Drupal 11 only. Two cautions apply to resource hints generally. **They are a budget, not a bonus** — every preconnect holds a connection open and every preload competes for bandwidth with the resources that decide when the page becomes usable, so four or five hints is the useful range and twenty is a regression. And the admin routes are guarded by `_permission: 'administer'`, which is **not** a permission any core module defines, so in practice only user 1 reaches them unless another module declares that exact name — worth knowing before reporting the pages as broken.

---

- Preconnect to a font host to cut TLS handshake latency.
- Preconnect to an image CDN before its assets are requested.
- Preconnect to an analytics or tag-manager endpoint.
- Preconnect to a payment provider's domain.
- Preload a critical stylesheet so CSS arrives sooner.
- Preload a web font and get the `crossorigin` attribute added automatically.
- Preload and prioritise a hero / LCP image with `fetchpriority="high"`.
- Add or change resource hints without a code deploy.
- Deliver hints as early `Link:` response headers over HTTP/2 or HTTP/3.
- Deliver hints as `<link>` elements in the `<head>` instead.
- Scope a preload to only the front page via a request-path condition.
- Scope a hint to a single content type, language, or theme.
- Order overlapping hints deterministically by weight.
- Auto-preload images by tagging markup with `data-preload-image="..."`.
- Auto-lift a page's existing `<link rel="preload">` tags into `Link:` headers.
- Auto-lift existing `<link rel="preconnect">` tags into `Link:` headers.
- Push a page's stylesheet `<link>`s as `Link: rel=preload; as=style` headers.
- Preload CSS files referenced by `@import` in inline styles.
- Improve Largest Contentful Paint and Lighthouse scores.
- Speed up third-party asset loading during a performance sprint.
- Export the hint configuration between environments.
- Audit which hosts a page reaches out to early.
- Keep hints off admin pages automatically.
