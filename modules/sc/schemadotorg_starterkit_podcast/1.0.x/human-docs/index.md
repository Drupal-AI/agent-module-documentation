# Schema.org Blueprints Starter Kit: Podcast — manual setup guide

**Schema.org Blueprints Starter Kit: Podcast** (`schemadotorg_starterkit_podcast`)
scaffolds a complete content model for publishing a podcast. Enable it once and it
creates two Schema.org-mapped content types — **PodcastSeries** and
**PodcastEpisode** — along with Views listings and **RSS feeds** ready for
submission to podcast directories. Instead of modelling episodes and series by
hand, you get a working podcast section you can start filling in immediately.

It builds on the Schema.org Blueprints stack (`schemadotorg`,
`schemadotorg_node`) and pulls in the **Podcast** module plus EVA, EPP, Auto
Entity Label, Config Rewrite and Views to assemble the feeds and listings. As a
starter kit it installs configuration the moment you enable it, so run it on a
fresh or evaluation site. It has no settings form and no access-control role of
its own — it simply creates the content types and config.

One thing to keep in mind: this starter kit publishes **RSS feeds** of your
podcast content, which are designed to be **public** so podcast directories can
read them. Only publish content you intend to be public, and review the generated
content types and configuration before using them in production.

Please note that this project is **deprecated and no longer maintained**. The
maintainers recommend using **Drupal Recipes** instead of Starter Kits for new
builds. Existing installs keep working, but a Recipe-based approach is the current
recommendation. The module also carries **no official security-advisory
coverage**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the starter kit on a fresh site.

## How to use it

After you enable it on a fresh or evaluation site, look under **Structure →
Content types** for the new **PodcastSeries** and **PodcastEpisode** types. Create
a series, then add episodes under it; the bundled Views produce episode listings
and the RSS feed a directory (Apple Podcasts, Spotify, etc.) can subscribe to.
There is no configuration page of its own — review the generated types, Views and
feeds and adapt them to your needs.
