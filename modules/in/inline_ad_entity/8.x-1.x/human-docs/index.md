# Inline Ad Entity — manual setup guide

**Inline Ad Entity** (`inline_ad_entity`) lets you place ads *inside* your article
text — between paragraphs — instead of only around it, which is how in-article
("in-content") advertising is usually done. It extends the
[Advertising Entity](https://www.drupal.org/project/ad_entity) (ad_entity) module
with a field formatter, so publishers can weave ads through body copy without
manually editing the HTML of each article.

The formatter is called **Content with Inline Ads** and works on Drupal's text
fields (`text`, `text_long`, and `text_with_summary` — the usual body/summary
field types). When rendering, it parses the field's HTML, splits it on paragraph
(`<p>`) boundaries, and inserts a chosen ad display after every *N* paragraphs
(the "ad frequency", three by default). It never adds an ad after the very last
paragraph, and it skips empty chunks, so placement stays tidy.

Because it builds on Advertising Entity, the ads themselves — the creative, the
targeting, the provider — are all defined there as **ad display** entities. Inline
Ad Entity only decides *where* the ads go. This means ad safety and policy are
governed by ad_entity's configuration; this module adds no ads of its own, no
admin pages, and no permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Advertising
   Entity dependency with Composer, and enable it.

There is **no configuration page** for this module — it has no settings form. It
is configured per field on **Manage display**; see "How to use it" below.

## Where it lives in the admin menu

Inline Ad Entity adds no admin page of its own. You configure it on a field's
**Manage display** tab (for example **Structure → Content types → *(type)* →
Manage display**), and you manage the ads it inserts in the Advertising Entity
module.

## How to use it

Prerequisite: the **Advertising Entity** module is installed and you have created
at least one **Ad display** (`ad_display`) entity for it to render.

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the entity's **Manage display**, for example
   `/admin/structure/types/manage/article/display`. Tip: apply the formatter in a
   view mode used for the full article (such as *Full content*) and leave teaser
   view modes on the default format so lists stay ad-free.
3. For a text field (`text`, `text_long`, or `text_with_summary`), set the
   **Format** to **Content with Inline Ads**.
4. Open the formatter settings (the gear icon) and set:
   - **Ad Frequency** — insert an ad after every *N* paragraphs (default `3`).
   - **Ad Display** — the `ad_display` entity to render inline. At least one must
     already exist in Advertising Entity.
5. Save the display, then view a node to confirm ads appear between paragraphs at
   the frequency you chose (and never after the final paragraph). To turn inline
   ads off again, switch the field's format back to the default.
