# Sites Simple Sitemap — manual setup guide

**Sites Simple Sitemap** (`sites_simple_sitemap`) gives each site in a multi-site
setup its own XML sitemap. It builds on the popular
[Simple XML Sitemap](https://www.drupal.org/project/simple_sitemap) module,
generating a distinct sitemap per site (dynamically, based on the default
sitemap) so that every site surfaces its *own* URLs to search engines rather than
sharing one combined sitemap.

This is purely an SEO helper. It carries no access-control role of its own — the
contents of each sitemap follow Simple XML Sitemap's normal inclusion
configuration, which already respects entity access. If a page is not visible to
anonymous visitors, it does not leak into the sitemap here either.

The module works alongside Simple XML Sitemap and the Sites module, and it can
only be used once you have the Sites module in place for Drupal 10/11. It has no
settings page of its own — you manage what goes into the sitemaps through Simple
XML Sitemap's own configuration, per site.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Simple XML Sitemap.

## How to use it

Once enabled, each site gets its own generated sitemap based on the default
sitemap. You control which content types and entities are included the same way
you always do with Simple XML Sitemap — through its settings under
**Configuration → Search and metadata → Simple XML Sitemap** — and Sites Simple
Sitemap takes care of producing a per-site sitemap from that configuration.
