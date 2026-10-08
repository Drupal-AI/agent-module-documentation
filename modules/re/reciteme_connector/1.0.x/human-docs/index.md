# Recite Me Connector — manual setup guide

**Recite Me Connector** (`reciteme_connector`) wires your Drupal site up to
[Recite Me](https://reciteme.com/), a hosted assistive-toolbar service. Recite Me
is a client-side widget that gives visitors text-to-speech, on-page translation,
dyslexia-friendly styling, and other reading aids — a common way to meet
accessibility and WCAG programme requirements without building those tools
yourself.

The module's job is small and self-contained: it stores the Recite Me **service
URL** and **service key** that Recite Me issues you, exposes them to the browser
through `drupalSettings`, and loads the Recite Me JavaScript so the toolbar
appears for your visitors. You control where and whether the toolbar shows —
either by placing a **ReciteMe block** in a theme region, or by flipping a
single site-wide toggle that loads the widget everywhere.

A note on the "service key": this is a **public, client-side** integration value.
The widget runs entirely in the visitor's browser, so the key is intended to be
visible in the page's JavaScript — it is not a secret in the way a server API
token is. The module makes no server-side HTTP calls, so there is no TLS or
certificate setting to worry about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your Recite Me service URL and
   key, choose how the widget loads, and customise the launcher.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at
`/admin/config/reciteme_connector/recitemeconfig` (route
`reciteme_connector.reciteme_config`), reachable by any user with the **access
administration pages** permission. To show the widget by placing a block, use
the standard **Structure → Block layout** page and add the **ReciteMe block** to
a region.
