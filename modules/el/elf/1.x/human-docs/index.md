# External Links Filter — manual setup guide

**External Links Filter** (`elf`) is a text‑format filter that automatically
marks **external** and **mailto** links in your content — adding a CSS class so
your theme can flag them (for example with a small outbound‑arrow icon or a
"leaving this site" cue), and optionally adding a `rel="nofollow"` attribute.
Wikipedia's little external‑link icon is the classic example of this technique.
Because it runs as part of the text format pipeline, it applies to all filtered
content automatically, without editors having to tag links by hand.

It can also, optionally, route external clicks through a **signed redirect** page.
This is worth understanding because redirect endpoints are where open‑redirect
vulnerabilities usually appear — and this one is built correctly. The redirect
route refuses to send a visitor anywhere unless the request carries a valid
**HMAC** of the target URL computed with the site's private key, so only URLs the
site itself signed will ever redirect. It is not an open redirect.

As a filter, this module is **display‑only**: it changes how links render, not the
stored content. It depends on Drupal core's **Editor** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — adjust the module settings and turn
   the filter on for your text formats.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Content authoring →
External Links Filter** (`/admin/config/content/elf`), and you enable the filter
itself per text format at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). Both require the **Administer site
configuration** permission.
