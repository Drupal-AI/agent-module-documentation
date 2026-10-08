# Header and Footer Scripts — manual setup guide

**Header and Footer Scripts** (`header_and_footer_scripts`) lets administrators
paste snippets of CSS and JavaScript — inline blocks or `<link>`/`<script>` tags —
into three site-wide regions of every page, straight from admin forms. It's the
no-deployment way to add Google Analytics, Google Tag Manager, a Facebook Pixel, a
cookie-consent banner, a chat widget, verification meta tags, or a bit of global
CSS, without editing theme files or building a subtheme.

There are three forms, one for each region:

- **Header** — output into the document `<head>`. Use it for analytics/tag snippets,
  a cookie-consent script that must run early, verification tags, JSON-LD, fonts, or
  global `<style>`.
- **Body** — printed right after the opening `<body>` tag. This is the correct spot
  for the Google Tag Manager `<noscript>` fallback.
- **Footer** — printed near the end of the page. Good for heavy analytics or
  third-party widgets you don't want to block initial render, or CSS that must win
  over the theme.

Each form has a **Styles** textarea and a **Scripts** textarea; the module parses
whatever markup you paste, rebuilds each `<style>`/`<link>`/`<script>`/`<noscript>`
tag, and injects it in the right place on every page. It's simple, has no
dependencies, and requires no Drush.

> **Trust implication — read this.** Anything pasted here runs on every page for
> every visitor, with the full power of arbitrary JavaScript and CSS. A bad or
> malicious snippet can break the site, leak data, or hijack sessions. Access is
> therefore gated by a single, **restricted** permission — grant "Add Scripts all
> over the site" only to administrators you fully trust, never to untrusted
> content authors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the three forms, what goes where, and
   the permission.

## Where it lives in the admin menu

The three forms live under **Configuration → Development → Header Footer Scripts**
(`/admin/config/development/header-and-footer-scripts/header`, `/body`, and
`/footer`). All three require the **"Add Scripts all over the site"**
(`header_and_footer_scripts_settings`) permission, which is marked restricted.
