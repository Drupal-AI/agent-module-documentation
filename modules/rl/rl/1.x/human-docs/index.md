# Relaunch (A/B Testing) — manual setup guide

**Relaunch** (`rl`) is an **A/B and multivariate testing** framework for Drupal
that works differently from the fixed-window tools you may be used to. Instead of
splitting traffic 50/50 for two weeks and then picking a winner by hand, Relaunch
treats every visitor click as feedback (an RLHF-style loop): each page view is a
trial, each conversion is a reward, and a **multi-armed bandit** (Thompson
Sampling) continuously shifts traffic toward whichever variant is winning. Tests
never have to "end", and a variant you add today is in play on the very next
render.

Because it uses a bandit rather than a fixed split, you can run anything from two
variants to thousands **simultaneously** — that is what makes it genuinely
multivariate. All of the data stays in your own Drupal database (no cloud, no
third-party SaaS), and tracking is deliberately privacy-conscious: it records only
anonymous interaction counts, with no user IDs and no cookies. Relaunch is part of
the DXPR marketing CMS stack and ships in DXPR CMS.

Out of the box you get a core API you can call from any module, View, or block,
plus a fast JSON REST endpoint for tracking and decisions, and admin **reports**
showing per-experiment performance, traffic, and confidence. The bundled
submodules give you ready-made things to test: **page titles**, **menu link
labels**, and the **order of items in a View**.

Two things to plan for. Serving different content to different visitors interacts
with **caching and SEO** — set experiments up carefully so variant serving doesn't
break page caching or confuse crawlers. And although tracking is anonymous, deciding
what to record and whether you need consent is still your call.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and verify direct access to `rl.php`.

## How to use it

1. Enable the base module and the submodule for whatever you want to test — for
   example `rl_page_title` (page titles), `rl_menu_link` (menu link labels), or
   `rl_sorting` (order of items in a View). The `rl_example` /
   `rl_example_frontend` submodules provide a working demonstration you can learn
   from.
2. Define your variants (they can be hand-written, AI-generated, or both — Relaunch
   doesn't care about authorship). A newly added variant needs no manual setup; it
   simply enters the rotation on the next render.
3. Let visitor traffic flow. The bandit shifts traffic toward the leading variant
   as evidence accumulates, and updates the model on every page.
4. Watch the **admin reports** for per-experiment performance, traffic, and
   confidence.

> **Verify the tracking endpoint.** Relaunch ships an `.htaccess` file that allows
> direct access to `rl.php` (the same pattern Drupal core uses for
> `statistics.php`). Confirm it works after installation — see the
> [installation guide](installation/index.md) — otherwise tracking and decisions
> won't reach the model.

> **Mind caching and SEO.** Because variants change page content per visitor, plan
> how each experiment interacts with your page cache and with search-engine
> crawlers before running it on high-traffic pages.
