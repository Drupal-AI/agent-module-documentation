# Media Taxonomy Filter — manual setup guide

**Media Taxonomy Filter** (`media_taxonomy_filter`) fills a gap in Drupal core:
Views ships a handy **"Content has taxonomy term ID (with depth)"** filter, but it
only works for **nodes**. This lightweight module provides the equivalent for
**media** entities — a new **"Media has taxonomy term ID (with depth)"** filter —
so you can filter a media View (for example the media library listing) by taxonomy
term, including that term's children down the hierarchy.

Rather than relying on a relationship table like core's `taxonomy_index`, it runs a
direct SQL query against your existing tables. Because of that, the filter needs to
know the **machine name of the media field that references your taxonomy** — you
supply that in the filter's settings.

It is a media-management convenience with no security surface of its own: it only
narrows what a media View already shows, and results still respect normal media
access. Much of the code is adapted from the *Commerce Product taxonomy filter*
project. The module requires no other modules beyond core, and supports Drupal 9,
10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings page of its own**. You configure the filter inside the
Views UI, as described under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from the **Views UI**
(**Structure → Views**, `/admin/structure/views`) when editing a media View.

## How to use it

1. Edit (or create) a **media** View at **Structure → Views**.
2. Under **Advanced → Contextual filters**, click **Add** and choose **Media has
   taxonomy term ID (with depth)**. (Depending on your needs you can add it as a
   regular filter or a contextual filter.)
3. In the filter settings, fill in the **Reference field** — the machine name of the
   field on your media entity type that references the taxonomy vocabulary you want
   to filter by.
4. Set the **depth** to suit your vocabulary: a positive depth includes child terms
   that many levels down, `0` matches only the exact term. Confirm the depth value
   makes sense for how deeply your vocabulary is nested.
5. Save the View. It now filters media by taxonomy term, honoring the chosen depth.
