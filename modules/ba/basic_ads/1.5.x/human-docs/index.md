# Basic Ads — manual setup guide

**Basic Ads** (`basic_ads`) is a lightweight way to run your own on‑site ad
campaigns without signing up for a third‑party ad server. You create ads —
image banners or simple text/link ads — decide where they appear (placements),
and optionally schedule them to run between certain dates. It is aimed at sites
that just want to rotate a few house banners or promotions, not at replacing a
full advertising platform.

The ads themselves are ordinary content managed by your editors, and the module
leans on core building blocks you already have: Node, Taxonomy, Datetime, Image,
Text, Link, Views and Block. It adds its own permissions so you can control who
is allowed to manage ads.

One thing worth understanding up front: an ad is essentially trusted markup and
links that get rendered on your pages. Because of that, **keep ad creation to
people you trust** — anyone who can create an ad can put content in front of
your visitors. Treat the "manage ads" permission the way you would treat any
content‑publishing right.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, Basic Ads adds its ad management to the admin UI (it registers
under the **Advertisement** package). You manage the ads, their placements and
their schedule from there, and you place ads on the page using core's Block
Layout and Views like any other content.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Grant the Basic Ads permission only to trusted editors — remember ads render
   as markup and links on your pages.
3. Create your ads (image/banner or text/link), set where they should appear
   (their placement), and, if you want them to run only for a period, set the
   schedule (start/end dates).
4. Display them on your pages through the block/Views the module provides.

There is no external ad network and no credentials involved — everything is
served from your own site.
