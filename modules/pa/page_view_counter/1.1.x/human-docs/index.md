# Page View Counter — manual setup guide

**Page View Counter** (`page_view_counter`) shows how many times a page has been
viewed and keeps that number ticking upward in near real time. Rather than logging
every request through Drupal, it counts views with a small JavaScript call from the
visitor's browser to a lightweight JSON endpoint, and it uses per‑visitor cookies so
that a reader reloading the same page doesn't inflate the total. The current count
is then displayed on the page through a **Counter block** you place in your theme.

It's a simple way to add a "1,234 views" figure to articles, product pages, or any
content where a bit of social proof or popularity signalling is useful — without
reaching for a full analytics stack or a third‑party tracker. The module also ships
a small dashboard so you can see the recorded counts for all your pages in one
place, at **Content → Page View Counters**.

Counts and per‑counter settings are modelled as entities, so administration is kept
behind a dedicated, restricted permission. The public counting endpoint itself is
available to anonymous visitors (it runs under the *access content* permission), which
is what lets the count go up for every reader.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the Counter block and set its
   options (max time, CSS class, prefix and suffix), plus where the admin settings
   and dashboard live.

## Where it lives in the admin menu

- The **counter dashboard** — a list of all recorded page counts — is at
  **Content → Page View Counters**.
- The **counter settings** are at **Structure → Page View Counter**
  (`/admin/structure/page-view-counter-entity`, route
  `entity.page_view_counter_entity.settings`), behind the restricted
  **Administer page_view_counter_entity** permission.
- The **Counter block** itself is placed from **Structure → Block layout**.

## How to use it

The short version: enable the module, place the **Counter block** where you want the
figure to appear, and configure the block's options. Once the block is on a page, the
count increments automatically each time a new visitor loads that page, and the
displayed number updates in near real time via the module's JSON endpoint. See
[Configuration](configuration/index.md) for the block options in detail.
