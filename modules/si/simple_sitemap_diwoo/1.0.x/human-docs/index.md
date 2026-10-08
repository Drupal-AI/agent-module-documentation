# Simple Sitemap DiWoo — manual setup guide

**Simple Sitemap DiWoo** (`simple_sitemap_diwoo`) extends the Simple XML Sitemap
module to produce a specialised sitemap for **DiWoo** — the digital-publication
side of the Netherlands' *Wet open overheid* (Open Government Act). Dutch public
sector organisations are required to expose their open-government documents in a
machine-readable, DiWoo-compliant form so those files can be indexed and
harvested. This module generates exactly that: a dedicated XML sitemap of media
file URLs, each enriched with metadata based on the official DiWoo XSD
definitions.

To do this it introduces a custom field type for DiWoo metadata, which you add to
the media entity types you want to publish, and it plugs into Simple XML Sitemap's
own configuration UI by providing a DiWoo sitemap generator and a DiWoo media URL
generator. It supports token replacement and default metadata values, so you can
set sensible defaults once rather than filling in every field by hand.

This is a compliance-focused add-on with no content or access role of its own. It
depends on **Simple XML Sitemap** (`simple_sitemap`) and core **Token** (`token`),
and the core **Media** module is expected as well if it isn't already enabled. It
works on Drupal 10 and 11. Because it exposes media files to indexers, only publish
material that is genuinely meant to be public.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up the field, the sitemap type,
   the variant, and the optional default settings.

## How to use it

After enabling, the setup is a short sequence: add the DiWoo metadata field to
your media types, tell the module which file-reference field to read, create a new
sitemap type using the DiWoo generators, and create a sitemap variant linked to
it. Optional default values and token behaviour are configured on the module's own
settings page. The [Configuration](configuration/index.md) page walks through each
step.
