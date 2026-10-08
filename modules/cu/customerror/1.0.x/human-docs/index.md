# Custom Error — manual setup guide

**Custom Error** (`customerror`) lets you replace Drupal's plain default error
screens with your own branded **403 (access denied)** and **404 (page not
found)** pages — each with a custom title and HTML body — and it can apply
regex‑based redirects for 404 URLs. You get all this without creating nodes: the
error pages are rendered straight from configuration, so they never appear in
content listings or search results.

You set the wording and markup for each error code on a single admin form. The
403 page can optionally embed the core **login form**, so an anonymous visitor who
hits an access‑denied page can log in right there and be sent back to the page
they were trying to reach. For 404s you can define a list of "match this URL,
redirect to that destination" rules — useful for pointing old, removed URLs at
new pages or at the front page.

There is one required wiring step: after you write your error content, you point
Drupal's core error‑page settings at this module's paths (`/customerror/403` and
`/customerror/404`). The module then serves your page with the correct HTTP status
code, so search engines still see a proper 403/404.

The module builds on Drupal core (it depends on the core **Path Alias** module)
and needs nothing else. Access to its settings form is governed by the core
**Administer site configuration / access site administration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the two required wiring steps, the
   settings form field by field, redirects, and the login form.

## Where it lives in the admin menu

- The settings form is at **Configuration → System → Custom error**
  (`/admin/config/system/customerror`).
- The required core wiring is at **Configuration → System → Basic site settings**
  (`/admin/config/system/site-information`), under **Error pages**.

## How to use it

Write your 403 and 404 content on the Custom Error settings form, then point the
core error‑page settings at `/customerror/403` and `/customerror/404`. You can
preview your pages any time by visiting those two paths directly. See
[Configuration](configuration/index.md) for each option.
