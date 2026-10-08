# Taxonomy Field Tracking — manual setup guide

**Taxonomy Field Tracking** (`taxonomy_field_tracking`) quietly watches which
taxonomy terms a visitor keeps running into as they browse, and uses that to
personalise a View. Each time a user visits a node page, the module bumps a
counter for every term ID in a chosen taxonomy field on that node. As the user
keeps browsing, those counts build up into a ranking of the terms they engage
with most — and the top term IDs from that ranking are then fed into the first
contextual argument of a View, so a listing (a "recommended" or "related for
you" block, say) adapts to what the visitor has been looking at.

In practice you tell the module three things per content type: which **bundle**
to track, which taxonomy **field** on it to count, and which **View** should
receive the resulting term IDs. You also choose **how many** of the top‑ranked
term IDs to pass along — set it to 1 and only the single most‑viewed term is
sent. It needs no modules outside Drupal core and works on Drupal 8, 9, 10 and
11.

A design note worth knowing before you build around it: the module is meant for
**simple cases**. It supports only one tracked field and one View per bundle,
and the target View should be a simple one — no exposed filters, and a single
contextual filter that receives the term IDs. If your recommendation logic is
more elaborate than that, this is probably not the right tool.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable tracking and map a bundle,
   field and View.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Taxonomy Field Tracking**.
That is where you turn tracking on and configure which bundle, field and View to
use.
