# TagClouds — manual setup guide

**TagClouds** (`tagclouds`) builds weighted "tag cloud" blocks and pages from your
taxonomy terms — the classic layout where the most‑used tags appear largest and rarely
used ones appear smallest, giving visitors an at‑a‑glance map of what a site is about.
It's a lightweight, out‑of‑the‑box fork of the old Tagadelic module, and it keeps no
database tables of its own.

The module reads how often each term is used and assigns it a **size level** (a CSS
class `level1` … `levelN`), so popular terms render bigger. You get a couple of ready‑made
pages — a term list and a cloud, per vocabulary — plus a **block** you can place for any
vocabulary. A single settings form controls the global behaviour: how tags are sorted,
how many size levels there are, whether to show usage counts, how many tags fit on a
page, and (on multilingual sites) whether to separate tags by language. Individual blocks
can override some of those choices.

TagClouds depends only on core's **Taxonomy** module. The look of a cloud is driven by
CSS classes and two Twig templates, so you (or your theme) can style each size level
however you like. Access to the settings form is controlled by a dedicated *administer
tagclouds settings* permission; the cloud pages themselves are visible to anyone with
*access content*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the global settings form, the per‑vocabulary
   block, the cloud pages, and the permission.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → TagClouds**
(`/admin/config/content/tagclouds`), guarded by the *administer tagclouds settings*
permission. Cloud blocks are placed from **Structure → Block Layout**
(`/admin/structure/block`).

## How to use it

1. Enable the module.
2. Optionally adjust the global settings (sort order, number of size levels, etc.).
3. Place a **Tags in {vocabulary}** block in a region, or link visitors to the
   ready‑made cloud pages at `/tagclouds/chunk/{vocabulary}` (the cloud) and
   `/tagclouds/list/{vocabulary}` (a term list with descriptions).

See [Configuration](configuration/index.md) for the full walkthrough.
