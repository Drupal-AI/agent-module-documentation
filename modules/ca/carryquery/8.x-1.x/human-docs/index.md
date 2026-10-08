# Query carry — manual setup guide

**Query carry** (`carryquery`) preserves selected URL query-string parameters as
visitors move around your site, and exposes their values through tokens. If a visitor
arrives with, say, campaign or UTM parameters on the URL, Query carry can keep those
values available across the internal links they follow next — without you writing any
JavaScript or jQuery to append parameters to buttons and links by hand. It is handy
for tracking and attribution continuity through a browsing session.

You tell the module which query-parameter keys to carry forward on its settings page,
and it makes those values available as tokens. Because it builds on the **Token** and
**Token Filter** modules, you can emit carried values anywhere tokens are supported,
including inside filtered text formats. There are no external services or network
calls, and the only endpoint it adds is the admin settings form.

One thing to know: links added directly in the CKEditor WYSIWYG are **not** processed
automatically. To place a link that Query carry can process, use its link tokens —
for example `[link:route:system.admin]` or `[link:path:admin/content]` — which the
module renders into an HTML anchor with the carried parameters appended.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Token and Token Filter.
2. [Configuration](configuration/index.md) — choose the parameters to carry, and use
   the link tokens.

## Where it lives in the admin menu

The settings form is at `admin/config/carryquery` (route `carryquery.config`),
protected by the core **Administer site configuration** permission. See
[Configuration](configuration/index.md) for how to add the parameters you want to
carry and how to use the link tokens.
