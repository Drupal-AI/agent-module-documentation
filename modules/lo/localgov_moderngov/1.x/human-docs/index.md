# LocalGov Modern.Gov — manual setup guide

**LocalGov Modern.Gov** (`localgov_moderngov`) helps a LocalGov Drupal council site
integrate with **Modern.Gov**, the committee and democratic-services system used by
many UK councils. Modern.Gov works by fetching a *template page* from your website at
regular intervals and using it to generate its own instance of your site's look and
feel. This module serves exactly that template page, so your Modern.Gov pages match the
rest of your council site.

By default the module serves the Modern.Gov template at the path
**`/moderngov-template`** (if you need a different path, add a URL alias to it). The
template contains Modern.Gov placeholder tokens that Modern.Gov replaces with real
content: `{pagetitle}` for the page title, `{breadcrumb}` for the breadcrumb,
`{content}` for the page content, and `{sidenav}` for the second sidebar. All links and
asset URLs in the template are rendered as absolute URLs, which Modern.Gov requires.

The module also serves a few related template variants at the same path with query
strings: an empty template (`?nocontent`), a header-only template (`?header`), and a
footer-only template (`?footer`). BigPipe is turned off for these templates because
they are served to anonymous users. The page template shipped with the module is meant
as an **example** of where to place Modern.Gov tokens — most sites will want to
customise a Modern.Gov page template for their own theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

There is **no admin settings form** for this module — it works by serving template
pages at a known path, and customisation is done in your theme's page template. Its
behaviour is described under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own (`configure` is `null`). Its output
is the template page served at **`/moderngov-template`** (plus the `?nocontent`,
`?header` and `?footer` variants). If you need it on a different path, add a URL alias
to `/moderngov-template`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Visit `/moderngov-template` to see the example template with the Modern.Gov tokens
   in place.
3. For most sites, create a customised Modern.Gov page template in your theme, placing
   the `{pagetitle}`, `{breadcrumb}`, `{content}` and `{sidenav}` tokens where your
   theme needs them. The module's shipped template is a starting-point example.
4. Give Modern.Gov the template page URL so it can fetch and regenerate your site's
   appearance.

**Good to know:** relative URLs inside inline JavaScript or `<script>` tags are *not*
converted to absolute URLs — keep that in mind when customising the template. The
Modern.Gov test URL sits behind HTTP authentication; because this integration exchanges
data with an external Modern.Gov service, validate the external data before display and
keep any integration credentials stored securely (never hard-coded or committed).
