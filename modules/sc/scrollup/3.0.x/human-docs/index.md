# Scrollup — manual setup guide

**Scrollup** (`scrollup`) adds the familiar floating "back to top" button that
appears once a visitor has scrolled down a long page. Clicking it smoothly returns
them to the top. It is a small usability convention with a real purpose on long
pages — and especially on mobile, where there is no keyboard Home key and the only
alternative is a lot of swiping.

Unlike a button you would hand-code into a theme, Scrollup supplies it
**configurably**: a settings form lets you control where the button sits, how fast
it scrolls, how far the visitor must scroll before it appears, which themes it
shows on, and its background and hover colours — all without editing theme code. It
uses vanilla JavaScript for the smooth scrolling and depends on nothing beyond
Drupal core.

Note the core requirement is `^10.3 || ^11.0` — an unusually narrow range that
**excludes earlier Drupal 10 minors**, so confirm your site is on 10.3+ before
installing. Three things are worth getting right when you configure the button, all
about accessibility rather than looks: it should be **keyboard reachable and
focusable** (a pointer-only control excludes the very people who benefit most from
not having to scroll), it needs an **accessible name** (an icon-only button
announces nothing useful to a screen reader), and the scroll should **respect
`prefers-reduced-motion`**, since an animated jump to the top is exactly the kind of
motion that can affect people with vestibular disorders.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form for the button's
   position, speed, trigger point, themes, and colours.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Scrollup**
(`/admin/config/system/scrollup`), reachable by any user with the **Administer site
configuration** permission.
