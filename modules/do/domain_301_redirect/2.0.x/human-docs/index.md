# Domain 301 Redirect — manual setup guide

**Domain 301 Redirect** (`domain_301_redirect`) forces every request to your site onto a
single canonical domain by issuing a **301 (permanent) redirect**. If your site answers on
several hostnames — `example.com` and `www.example.com`, a handful of parked marketing
domains, or an old domain you've migrated away from — this module sends visitors (and search
engines) to the one "main" domain you choose, keeping the rest of the URL path intact
(`/user/1` stays `/user/1`). It's a code-only way to consolidate duplicate content and tidy
up your SEO without touching your web server's virtual-host configuration.

The redirect also normalizes the **scheme**, so you can point `http://` visitors at your
`https://` main domain, and the target may even include a port. You get fine-grained control
over which paths are affected: redirect the whole site *except* a list of paths (for example
excluding `/api/*` or a health-check endpoint), or redirect *only* on a listed set of paths.
Path matching is alias-aware and supports `*` wildcards.

Under the hood it runs as an early response subscriber on every request and returns a
`TrustedRedirectResponse` with an `X-Redirect-ID` header (the same header the Redirect module
uses, which edge caches like Varnish recognize). Before you can switch redirection on, the
module **verifies the target domain actually resolves back to this same site** by making a
token-protected check request — a safety net against accidentally redirecting your site into
a black hole. It depends only on core's **Path Alias** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form (main domain, enable toggle,
   page list, include/exclude mode) and the two permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → Search and metadata → Domain 301 Redirect**
(`/admin/config/search/domain-301-redirect`). You need the *Administer domain 301 redirect*
permission to reach it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and enter your **main domain**, including the scheme — for example
   `https://www.example.com`.
3. Decide whether the redirect should apply everywhere except a list of paths, or only on a
   listed set of paths, and fill in the page list accordingly.
4. Tick **Enabled** and save. The module first checks that the domain you entered points back
   to this site; if the check passes, redirection turns on and any request arriving on a
   different host or scheme is permanently redirected to your main domain.

Every setting is explained in detail on the [Configuration](configuration/index.md) page.
