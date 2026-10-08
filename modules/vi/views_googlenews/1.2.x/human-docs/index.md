# Views Google News — manual setup guide

**Views Google News** (`views_googlenews`) lets you publish a Google News
sitemap feed straight from a View. It adds a Views **display style** called
"Google News Feed" and a matching **row plugin** called "Google News fields"
that together render your articles as a `news:` XML sitemap conforming to
Google's News publisher requirements — the format Google Publisher Center
expects — so you never have to hand-write the XML.

The module is Views-only: it has no settings page, no permission and no Drush
command. Everything you configure lives inside the View itself. You build a
normal View of your news content, add a **Feed** display, set its format to
"Google News Feed" and its row style to "Google News fields", then map each
Google News tag (the article URL, title, publication date, keywords, and so on)
to one of the View's fields. Two Twig templates emit the final XML and set the
`text/xml` content type; the publication name defaults to your site name and the
language to the site default when you don't map a field for them. It depends only
on core's **Views** module and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page for this module — it does not add anything under
Configuration. You work entirely inside the Views UI at **Structure → Views**
(`/admin/structure/views`).

## How to use it

Because all configuration lives in a View, here is the whole workflow:

1. Go to **Structure → Views → Add view** (`/admin/structure/views/add`) and
   create a View of your articles that shows **fields**.
2. Add a **Feed** display ("+ Add" → *Feed*) and give it a **Path**, for example
   `news.xml`.
3. Under **Format**, set the display style to **"Google News Feed"**.
4. Set the row style to **"Google News fields"**.
5. Add the View fields you need — a link/URL field, the title, the authored-on
   date, a keywords field, and so on — then open the row settings and map each
   Google News tag to one of those fields. The three required mappings are the
   article URL (`<loc>`), the title (`<news:title>`) and the publication date
   (`<news:publication_date>`); the rest are optional.
6. Google recommends limiting the feed to the last two days. Add a filter on
   **Content: Authored on**, operator *is greater than or equal to*, with an
   offset value of `now -2 days`.
7. Save the View and visit its path (e.g. `/news.xml`). The feed is served as
   `text/xml; charset=utf-8`.

The publication name defaults to your site name and the language to the site's
default language whenever you leave those mappings empty, so a minimal feed only
needs the URL, title and date. You can build several feeds (for example one per
section) as separate Feed displays or separate Views, and developers can adjust
each item with `hook_views_googlenews_item_alter()` or override the two XML
templates in a theme — see the [`agent/`](../agent/start.md) docs for those
details.
