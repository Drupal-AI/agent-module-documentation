# NAVU — manual setup guide

**NAVU** (`navu`) integrates the [NAVU.co](https://navu.co) sidebar into your
Drupal site. NAVU's sidebar is an interactive, AI-powered on-page guide: it offers
visitors real-time answers to their questions without interrupting their browsing,
lets them toggle into a search mode to find documents on the site, and can feed
visitor-behavior insights back to NAVU. This Drupal module is the thin bridge that
embeds that widget — it does not reproduce NAVU's features, it simply places
NAVU's sidebar code on the pages you choose.

Because the widget is delivered as a **block**, you control exactly where it
appears: enable it site-wide, or place different NAVU blocks on different pages or
site sections. The module depends only on core's **Block** module and works on
Drupal 10, 11, and 12.

A couple of practical points. NAVU is a paid service — the module **requires a
subscription to navu.co** and a site code / embed credentials from your NAVU
account, which you paste into the block configuration. Those credentials should be
treated as configuration you manage securely (see Installation). This project is
community-maintained and **not affiliated with NAVU** in any way.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. Setup happens entirely
when you place the NAVU block, described in "How to use it" below.

## Where it lives in the admin menu

NAVU adds no admin settings page of its own. You configure it from the **Block
layout** screen at **Structure → Block layout**
(`/admin/structure/block`), where you place and configure the **NAVU** block.

## How to use it

1. Sign in to your **navu.co** account and obtain the site code / embed
   credentials for the site you are integrating.
2. In Drupal, go to **Structure → Block layout**
   (`/admin/structure/block`) and click **Place block** in the region where you
   want the sidebar to appear.
3. Find the **NAVU** block, place it, and paste your NAVU site code into its
   configuration.
4. Use the block's **Visibility** settings (pages, content types, roles) to
   control where the sidebar shows. To show different NAVU widgets in different
   places, place several NAVU blocks with different configurations and visibility
   rules.
5. Save the block. The NAVU sidebar now appears for visitors on the pages you
   targeted.
