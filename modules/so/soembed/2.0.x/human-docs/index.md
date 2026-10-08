# Simple oEmbed — manual setup guide

**Simple oEmbed** (`soembed`) turns a bare media URL in your content into an
embedded player or card, using the oEmbed protocol — paste a YouTube link on its
own line and it becomes a video, paste a social post link and it becomes an
embed. It depends on core's **Media** module and runs on Drupal 9.5, 10 and 11.

oEmbed is the standard by which a provider answers "given this URL, give me embed
markup" — it is what makes pasting a link "just work" on most modern platforms.
Drupal already supports oEmbed through the media system, which is the right
architecture for assets an editor manages deliberately, but heavier than needed
when all you want is for a pasted link to render. Simple oEmbed takes the lighter
path: it is a **text-format filter** that finds URLs and replaces them with the
provider's embed markup. Because it works at render time, it applies to all
content in that text format — including content that predates the filter and
content arriving through an API — without an editor having to create a media
entity for each one.

Two things are worth weighing before you turn it loose, as with any embed
mechanism. First, **privacy and consent**: embedding runs a third party's markup,
and usually their JavaScript, in the visitor's browser, so on a site with a
consent manager the embeds should be gated behind consent. Second,
**availability**: oEmbed needs the provider reachable at render time, so an
unavailable provider or a network-restricted environment changes what visitors
see. And because the filter delegates rendering to whatever domain an author
pastes, **which providers you permit is the important configuration** — an
unrestricted oEmbed filter is effectively trusting any pasted domain. This
release is a beta (8.x-2.0-beta14), so test it before relying on it in production.

This guide is written for a **human** setting the filter up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enabling and positioning the filter
   on a text format, and limiting the providers.

## Where it lives in the admin menu

Simple oEmbed has no settings page of its own. You enable it as a filter on a text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on whichever format your content uses.
