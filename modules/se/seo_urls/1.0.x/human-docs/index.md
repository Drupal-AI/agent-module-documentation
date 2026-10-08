# SEO Urls — manual setup guide

**SEO Urls** (`seo_urls`) lets you define a clean, human-readable URL as an
alternative to an existing canonical URL — typically one weighed down with query
parameters — and surfaces that pretty URL through a `seo-url` token you can put
in your metatags.

The problem it solves is familiar: a view or faceted listing with filters often
produces a long, parameter-heavy address like
`/catalog?color=red&type=shoes`, which is ugly and poor for SEO. SEO Urls lets
you map that canonical path to something readable such as `/products/red-shoes`.
It stores each mapping as a `seo_url` entity pairing a canonical URI with a nicer
SEO URI. Behind the scenes an inbound path processor rewrites a requested SEO path
back to the real internal path (re-adding the canonical query parameters) so
routing keeps working, and an outbound processor can render the SEO form of a
canonical path. The mappings are exposed through an `[entity:seo-url]` token, so
you can point your canonical metatag at the SEO URL.

This is a configuration-driven module: after enabling it you must choose which
entity types are eligible, then create your mappings. It depends on core's
**Link** field and the **Metatag** module, requires PHP 8.1, and runs on Drupal
10 or 11. An optional submodule, **`seo_urls_views`**, extends the same mechanism
to view page paths. Note that the token name changed from `seo_url` to `seo-url`
in this release.

On security: URL resolution is driven entirely by the mappings that admins and
editors create (stored as `internal:` link fields), never by arbitrary request
input, so there is no open-redirect or path-injection surface. The outbound
processor even collapses a leading `//` to a single slash to prevent
protocol-relative external URLs, and inbound resolution only ever returns an
internal path. All routes are gated by a full set of CRUD permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Link and Metatag.
2. [Configuration](configuration/index.md) — choose eligible entity types, create
   your SEO URL mappings, and wire up the token.

## Where it lives in the admin menu

Two places matter:

- **Settings** — choose which entity types can have SEO URLs at
  **`/admin/structure/seo_url`** (route `seo_url.settings`), behind the restricted
  `administer seo_url entities` permission.
- **Manage mappings** — create, list, and delete SEO URL entities at
  **`/admin/content/seo_url`**.

## How to use it

After configuring eligible types and adding mappings, put the
`[<entity_type>:seo-url]` token into your canonical metatag. When a page matches a
mapping, the token resolves to the clean SEO URL; otherwise it falls back to the
normal canonical. There is also a **Create SEO URL** toolbar action that
pre-fills the canonical field from the current page's redirect destination, so you
can make a mapping directly from the page you are looking at.
