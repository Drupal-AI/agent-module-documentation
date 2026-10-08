# AGLS — manual setup guide

**AGLS** (`agls`) adds AGLS metadata tags to your pages. AGLS — the Australian
Government Locator Service — is a metadata standard that many Australian government
websites are required to follow. It describes each resource with tags such as its
creator, publisher, jurisdiction, and availability, so the content is properly
catalogued and discoverable.

The module is built on top of the [Metatag](https://www.drupal.org/project/metatag)
module: it does not invent its own settings screens but instead adds a set of AGLS
meta tags to Metatag's existing system. That means you configure AGLS tags exactly
the way you already configure other meta tags in Drupal — as site-wide defaults and,
where you want to override them, per individual piece of content.

It is an SEO/metadata feature that emits meta tags into your pages' HTML; it has no
access-control role. The one thing to stay on top of is accuracy — the metadata you
emit should genuinely match the content it describes.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Metatag.

## How to use it

AGLS has no settings page of its own — you configure everything through Metatag:

1. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`).
2. Edit the **global** or a bundle-specific defaults record and fill in the AGLS
   tags (creator, publisher, jurisdiction, availability, rights, and so on) that
   the module has added to Metatag. These become your site-wide AGLS defaults.
3. To override any AGLS tag on a specific node or entity, use the Metatag field on
   that content — the same field you use for other meta tags — and set the AGLS
   values there.

Because AGLS tags flow through Metatag, they support tokens and per-entity
overrides just like the rest of your meta tags. Keep the emitted values accurate to
each resource so your site stays AGLS-compliant.
