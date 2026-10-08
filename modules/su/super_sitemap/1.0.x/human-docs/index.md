# Super Sitemap — manual setup guide

**Super Sitemap** (`super_sitemap`) adds taxonomy-oriented customizations on top of
the **Simple Sitemap** module, extending how your site's XML sitemap is generated —
particularly around taxonomy — for sites with specific sitemap requirements.

The motivation is scale. There are plenty of good sitemap options for Drupal, but
they can struggle on very large or enterprise installations and are usually tightly
coupled to Drupal's entity system, which makes it awkward to aggregate links from
other sources or to add custom links after the fact. Super Sitemap leans on
external systems to query for content and to produce standardized sitemap files —
including a sitemap-of-sitemaps for deep linking across very large link sets
(hundreds of thousands, even millions of links), the ability to aggregate links
from a variety of sources (Solr, files, the database, and so on), a UI for adding
custom links, and control of the build process through cron and event subscribers.
Because the build writes the sitemap out as files, search engines can fetch them
quickly.

This is an SEO feature that builds on Simple Sitemap, so a couple of things follow
from that. A sitemap lists your **public** content for search engines to discover —
it has no access-control role of its own, and inclusion is governed by Simple
Sitemap — so make sure only content that is meant to be public ends up in it. It
depends on **Simple Sitemap**, **Ultimate Cron**, and core **Views**. After
installing, the module requires an administrator to set up the sitemap structure —
it is not fully hands-off on enable.

This guide is written for a **human** setting the sitemap up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   dependencies, and enable the module.

## How to use it

Because Super Sitemap extends Simple Sitemap, you configure it alongside Simple
Sitemap's own sitemap settings. After enabling the module, an administrator sets up
the sitemap structure and the taxonomy-oriented customizations, then lets the build
process (driven by cron and event subscribers) generate the sitemap files. Keep
Simple Sitemap's inclusion rules in mind so that only public content is published
to the sitemap.
