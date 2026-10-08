# LocalGov News — manual setup guide

**LocalGov News** (`localgov_news`) provides a ready-made council newsroom for LocalGov
Drupal sites. It ships a **news article** content type, one or more **newsroom** landing
pages that list and feature articles, and the search and facet blocks that let visitors
filter the archive by date and category. It is the standard way to publish categorised
press releases on a LocalGov site.

Two node types do the work. A **news article** carries its own publication date, a category
taxonomy reference, a hero media image, related-article links, a body, and a required
reference to the newsroom it belongs to. A **newsroom** is the landing page; it can feature
up to three hand-picked articles, and the featured block automatically backfills any empty
slots with the latest promoted articles so the page never looks half-empty. You can run
several newsrooms on one site — for example one per service area.

The module also smooths the editorial experience: when only one newsroom exists it is
selected automatically (and it warns, with a create link, when none exist); the featured-
article picker is limited to articles in that newsroom; articles gain a "promote to
newsroom" checkbox; an RSS feed and XML sitemap entries are handled for you; and category
names are kept intact in generated URL aliases.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — create a newsroom, understand the fields, place
   the newsroom components, and promote articles.

## Where it lives in the admin menu

LocalGov News has no single settings page. You create newsrooms and articles from **Content
→ Add content** (Newsroom / News article), and you arrange a newsroom's listing, search, and
facet components under **Structure → Content types → Newsroom → Manage display** — these are
pseudo-fields on the newsroom's display, not blocks placed in Block layout.
