# Query carry — manual setup guide

**Query carry** (`carryquery`) preserves selected URL query-string parameters as
visitors move around your site. If a visitor arrives with, say, campaign or UTM
parameters on the URL, Query carry can keep those values available across the internal
links they follow next — without you writing any JavaScript or jQuery to append
parameters to buttons and links by hand. It is handy for tracking and attribution
continuity through a browsing session.

You tell the module which query-parameter keys to carry forward on its settings page.
By default it carries them **server-side**: an outbound path processor appends the
configured parameters to the internal URLs Drupal generates, and GET-method forms get
the parameters added as hidden fields. You can instead switch to a **JavaScript** mode
that appends the parameters to same-site links after the page renders.

Because it builds on the **Token** and **Token Filter** modules, it also gives you link
tokens you can use anywhere tokens are supported, including inside filtered text
formats. There are no external services or network calls, and the only endpoint it adds
is the admin settings form.

One thing to know: links added directly in the CKEditor WYSIWYG are **not** rewritten
by the server-side processor. To place a link that Query carry can process there, use
its link tokens — for example `[link:route:system.admin]` or
`[link:path:admin/content]` — which the module renders into an HTML anchor.

## What's new in 2.0.x

This is a **major** release that adds **Drupal 11** support
(`core_version_requirement: ^8 || ^9 || ^10 || ^11`) and modernizes the internal
service wiring — the path-processor-manager decorator is now autowired with PHP
attributes so the outbound processor reliably sees the current request. The
configuration UI and behaviour are otherwise the same as the 8.x-1.x branch.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Token and Token Filter.
2. [Configuration](configuration/index.md) — choose the parameters to carry, pick
   server-side or JavaScript mode, and use the link tokens.

## Where it lives in the admin menu

The settings form is at `admin/config/carryquery` (route `carryquery.config`),
protected by the core **Administer site configuration** permission. See
[Configuration](configuration/index.md) for how to add the parameters you want to
carry and how to use the link tokens.
