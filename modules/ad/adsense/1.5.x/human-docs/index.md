# AdSense — manual setup guide

**AdSense** (`adsense`) displays Google AdSense ad units on your Drupal site so
you can earn advertising revenue. It supports the modern "managed" content ads,
Google's page-level Auto ads, and custom-search ad units, and it lets you place
them three different ways: as blocks in a region, as inline tags inside body text,
or automatically across the whole site.

Everything keys off your **AdSense publisher ID** — the `ca-pub-…` code Google
gives you when you sign up for an AdSense account. You enter it once on the
module's settings form and every ad unit reuses it. You will need a working Google
AdSense account and at least one approved ad unit (which gives you an *ad slot*
ID) before real ads will show; the module does not create the account for you, it
only renders the ad code on your pages.

Two things make the module pleasant to work with while you build the site. A
global **placeholder** mode draws a labelled grey box where each ad would appear,
and a **test mode** flags ad requests as tests — both let you lay out and preview
ads without making live calls to Google or racking up invalid impressions. There
is also a master off switch to suppress all ads at once, and per-role permissions
to hide ads from certain users (for example logged-in editors).

Two optional submodules round it out: **AdSense ads.txt** (`adsense_adstxt`)
auto-generates the `/ads.txt` file Google recommends, and **AdSense old code**
(`adsense_oldcode`) supports pre-2007 legacy ad code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enter your publisher ID, the global
   switches, Auto ads, and how to place ads as blocks or inline tags.

## Where it lives in the admin menu

The settings live under **Configuration → Web services → AdSense**
(`/admin/config/services/adsense`), with sub-pages for managed ads
(`/admin/config/services/adsense/managed`) and custom search
(`/admin/config/services/adsense/cse`). Reaching them requires the
*Administer adsense* permission. Ads themselves are placed either at **Structure →
Block layout** (`/admin/structure/block`) or inline via a text-format filter.
