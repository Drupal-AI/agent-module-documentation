# Resource Hints — manual setup guide

**Resource Hints** (`resource_hints`) lets you add
[W3C resource-hint](https://www.w3.org/TR/resource-hints/) directives to every page
of your site, so browsers can do performance work ahead of time — resolving DNS,
opening connections, or pre-fetching and pre-rendering third-party resources before
they're actually needed. It's a set-and-forget performance-tuning tool: you list the
domains and URLs you care about on one admin form, and the module emits the right
hints on all pages.

It supports the four standard hint types:

- **`dns-prefetch`** — resolve a third-party domain's DNS early (good for fonts,
  CDNs, analytics).
- **`preconnect`** — go further and open the TCP/TLS connection ahead of time (great
  for render-critical origins like a font provider, to help Core Web Vitals / LCP).
- **`prefetch`** — download a resource the user will likely need on their next
  navigation.
- **`prerender`** — render a likely next page in the background.

For each type you can choose *how* the hint is delivered: as an HTTP **`Link`
header** (which works even when you can't edit the page's `<head>`) or as an HTML
**`<link>` element**. There's also a dedicated **DNS-Prefetch Control** toggle that
emits the `X-DNS-Prefetch-Control` header/meta — useful because browsers disable DNS
prefetching over HTTPS by default, so turning it on can re-enable it (or you can
explicitly disable prefetching site-wide).

The module has no dependencies beyond Drupal core (10.1 or 11), no Drush commands,
and one permission of its own. URLs you enter are sanitized on output (dangerous
protocols like `javascript:` are stripped), and hints apply globally rather than
per-page, which is why this is a site-wide tuning tool rather than a per-entity
feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they list every config key and the
exact attach logic.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form sits under Performance at **Configuration → Development →
Performance → Resource Hints**
(`/admin/config/development/performance/resources-hints`) — a tab on the core
Performance settings page. Access requires the **Administer resource hints**
permission (a performance-tuning capability, not a security boundary).

## How to use it

Open the settings form and you'll find four collapsible sections — **DNS Prefetch**,
**Preconnect**, **Prefetch**, and **Prerender**. Each one offers the same two
controls:

- **Resources** — a text box where you list the URLs/domains for that hint type,
  **one per line**.
- **Output type** — a select choosing how the hints are delivered: **Link Header**
  (the HTTP `Link:` header) or **Link Element** (an HTML `<link>` tag).

The **DNS Prefetch** section has one extra control, **DNS Prefetch Control**, set to
**Enabled** or **Disabled**:

- **Enabled** emits `X-DNS-Prefetch-Control` telling the browser DNS prefetching is
  allowed (helpful over HTTPS, where browsers otherwise turn it off).
- **Disabled** suppresses the `dns-prefetch` links entirely and signals the browser
  not to prefetch DNS.

Fill in the domains you want warmed up — for example your font provider
(`fonts.gstatic.com`), a CDN, an analytics or tag-manager host, or a payment/API
origin used later in a checkout flow — pick an output mode, and **Save
configuration**. The hints are then attached to every page automatically. You can
list several resources per type, one per line.

Prefer the command line? The settings live in the `resource_hints.settings` config
object, so you can adjust the output modes with `drush config:set` and edit the URL
lists with `drush config:edit resource_hints.settings` (the resource lists are
sequences), or manage them through your normal config import/export workflow.
