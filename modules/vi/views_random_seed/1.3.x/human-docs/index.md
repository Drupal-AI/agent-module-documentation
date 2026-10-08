# Views random seed — manual setup guide

**Views random seed** (`views_random_seed`) fixes a well-known annoyance with
random listings in Views. Core ships a **Global: Random** sort, but it reshuffles
the order on *every* database query — which means the moment a visitor clicks to
page 2 of a random listing, everything reshuffles and they see duplicates from
page 1 and miss other items entirely. Random plus a pager simply doesn't work with
core's sort.

This module adds a **Random seed** sort that solves the problem by remembering a
*seed*. It orders rows randomly, but it stores the seed used, so every page of the
pager draws from the same random order — no duplicates, no gaps. Under the hood it
uses a seeded random function in the database (`RAND(<seed>)` on MySQL/MariaDB,
`setseed()` + `RANDOM()` on PostgreSQL), and it also works with Search API views.

The seed's lifetime and scope are configurable right in the Views UI, which is
where the module really earns its place. You decide **how often** the order
reshuffles — never, hourly, every eight hours, daily, or a custom interval in
seconds — so you can rotate a "Featured" or "Related" block on a schedule. You
decide **who** sees which order — the same random order for everyone (cache
friendly) or a different order per user, optionally giving each anonymous visitor
their own order too. And you can even **reuse another view's seed**, so two
separate listings (say a view and its attached block) shuffle in exactly the same
order. When the seed regenerates, the module invalidates a matching cache tag so
caches stay in sync.

There is **no admin settings page, no permission, and no Drush command** — you
configure everything as options on the sort criterion inside the Views UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the sort plugin
id, the option keys, and the seed calculator service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Views random seed has **no page of its own**. You use it from the **Views UI**,
under **Structure → Views** (`/admin/structure/views`), by adding the **Random
seed** sort criterion to whichever view you want to randomize.

## How to use it

1. Edit the view you want to randomize
   (**Structure → Views → *(your view)* → Edit**).
2. In the **Sort criteria** section, click **Add**.
3. Search for **Random seed** (it's in the *Global* category, from the `views`
   table) and add it. The usual ascending/descending control is hidden — the
   order is random by design.
4. Set the options to suit your listing:

   - **Seed per user** — *Same for everyone* (one shared random order, the most
     cache-friendly choice) or *Different per user* (each user gets their own
     order).
   - **Anonymous session** — only relevant with *Different per user*. Turn it on
     to start a session for anonymous visitors so each gets a distinct order.
     Leave it off (the default) and anonymous visitors share one order — this
     avoids the performance cost of per-visitor sessions.
   - **Reset interval** — how often the order reshuffles: *Never* (fix it
     permanently), *Hourly*, *Every 8 hours*, *Daily*, or *Custom*. Choosing
     *Custom* enables a field where you enter the interval in seconds.
   - **Reuse seed** — leave blank normally, or point it at another view display so
     the two listings shuffle in identical order.
5. Save the view.

**Caching tip:** if the view uses output caching, choose **time-based** caching
aligned with your reset interval — otherwise a cached page can outlive its seed
(or the reverse), and the randomization can look stale or inconsistent.
