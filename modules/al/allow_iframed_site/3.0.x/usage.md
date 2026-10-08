<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Allow site to be iframed lets you remove the `X-Frame-Options` response header on selected paths so those pages can be embedded in an `<iframe>` on another site — with an explicit clickjacking warning.

---

Drupal (and many hosts) send an `X-Frame-Options: SAMEORIGIN` header that stops pages from being framed by other origins. This module registers a response **event subscriber**
(`RemoveXFrameOptionsSubscriber`, priority -10 on `KernelEvents::RESPONSE`) that **removes** that
header on the paths you choose, allowing those pages to be iframed. You pick the paths on a settings
form (`allow_iframed_site.settings` at `/admin/config/system/allow_iframed_site`, permission
*administer site configuration*) that reuses core's **Request path** condition (`request_path`
plugin) — a list of paths (`pages`) plus a **negate** toggle, so you can either allow-list specific
paths or invert the selection. The subscriber evaluates that condition per response and only strips
the header when the current path matches; if no pages are configured and negate is off, it leaves
the header in place. Saving the form flushes all caches so the change takes effect. As the module's
own description warns, removing `X-Frame-Options` opens those pages to **clickjacking**, so scope it
tightly. Note it only manages the legacy `X-Frame-Options` header; it does **not** set or manage a
Content-Security-Policy `frame-ancestors` directive, which modern browsers also honour.

---

- Allow a public "widget" page to be embedded in a partner's website via iframe.
- Let a specific landing page be framed inside a third-party portal.
- Embed a Drupal-rendered form on an external marketing site through an iframe.
- Expose an oEmbed-style content page for framing by other sites.
- Allow a status/dashboard page to be iframed into an internal wiki.
- Permit a single node path to be embedded while keeping the rest of the site frame-protected.
- Allow framing of a `/embed/*` path pattern used for embeddable content.
- Let a documentation page be shown inside another product's help panel via iframe.
- Frame a pricing or comparison page inside a reseller's site.
- Allow a map or interactive page to be embedded on a tourism partner site.
- Use the negate option to allow framing everywhere except a few sensitive admin paths.
- Scope framing to marketing paths only, leaving login and admin frame-protected.
- Embed a campaign microsite section into a social or ad landing page.
- Permit an event schedule page to be iframed on a sponsor's website.
- Allow a survey or feedback page to be embedded in an external app.
- Let a booking widget page be framed by a hotel-aggregator site.
- Enable iframe embedding for a signage/kiosk display path.
- Allow a chart/report page to be embedded in a BI dashboard iframe.
- Temporarily allow a page to be framed for a demo, then remove it from the list.
- Provide an embeddable "terms" or "policy" page for framing in a checkout flow.
- Allow a specific multilingual landing path to be iframed by a regional partner.
- Manage exactly which paths drop X-Frame-Options from one settings screen.
