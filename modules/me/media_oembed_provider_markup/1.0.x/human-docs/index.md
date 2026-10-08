# Media oEmbed Provider Markup — manual setup guide

**Media oEmbed Provider Markup** (`media_oembed_provider_markup`) changes how
Drupal renders remote oEmbed media (YouTube, Vimeo, and the like). Instead of
wrapping the embed in Drupal's own proxy iframe, it renders the HTML markup that
the oEmbed **provider** actually returned.

By default, core renders remote media through an intermediary: the media entity's
oEmbed URL is proxied by Drupal, and the page ends up with an iframe pointing at
`/media/oembed?url=…`, which in turn contains the provider's embed. That
indirection exists for good reasons — it isolates third‑party markup and gives
core a place to enforce its own rules — but it produces a double iframe (a common
cause of sizing and responsiveness trouble), breaks provider JavaScript that
expects to live in the host document, and adds a request through Drupal for every
embed on the page. It also changes the URL, which is why Consent Management
Platforms (CMPs) often fail to recognise and block the external source.

This module removes that layer and renders the provider's markup directly. Common
reasons to want it: a video that won't go full‑bleed because the outer iframe has
its own fixed dimensions; a provider whose responsive or lazy‑loading script never
fires; a player‑API feature that only works when the embed is a first‑class part
of the page; giving your CMP the original source so it can manage consent; or
simply cutting a proxied request per embed.

The trade‑off is exactly the reason core does it the other way. Provider markup
rendered into your page runs in **your** origin's context, so you are trusting the
oEmbed providers on your allow‑list rather than containing them. As the module's
own notes warn, embedding provider markup can introduce malicious code and can
raise data‑protection concerns if embedding isn't handled lawfully — so keep the
provider list tight and deliberate, review it whenever someone adds to it, and
expect that a Content Security Policy tuned for the iframe arrangement will need
revisiting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** for this module. You turn its behaviour on
per field, in the display settings of your oEmbed fields — described under "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. Its single option lives on the **Manage
display** screen of any entity that renders an oEmbed field.

## How to use it

After the module is enabled, edit the **Manage display** for the entity that shows
your remote media — for example your media type's display, or the content type
that renders the media. Find the oEmbed field (the "Video" / oEmbed content
formatter), open its formatter settings (the gear icon), and enable **Use
provider's markup for oEmbed field**. Save the display.

From then on, that field renders the provider's own HTML directly instead of the
proxied `/media/oembed` iframe. Review which oEmbed providers your site allows
before switching this on, and re‑check your CSP and consent handling afterwards.
