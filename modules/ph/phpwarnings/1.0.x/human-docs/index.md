# PHP Warnings & Errors — manual setup guide

**PHP Warnings & Errors** (`phpwarnings`) is a small development aid. It provides
a **block** that lists recent, unique PHP warnings and errors pulled from
Drupal's database log (`dblog`), so that as you build modules and themes you
notice PHP notices, warnings, and errors without having to keep reopening the
full **Reports → Recent log messages** page.

The idea is simple: place the block somewhere you'll always see it — the site
footer is the classic choice — and let it quietly surface coding mistakes while
you work. Because it reads from `dblog`, the core Database Logging module must be
enabled (it is a hard dependency), and warnings only appear once they have been
logged there.

This is strictly a **development** tool. The maintainers' own advice is worth
repeating: **don't forget to remove or disable it before deploying to a live
site**, since a block that prints PHP warnings to the page is not something you
want your visitors to see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its `dblog` dependency.

There is **no dedicated configuration page** for this module — you set it up
entirely by placing its block, described below.

## Where it lives in the admin menu

PHP Warnings & Errors adds no settings page. You work with it through the block
system at **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Make sure core's **Database Logging** (`dblog`) module is enabled — Drupal
   enables it automatically as a dependency when you turn on PHP Warnings &
   Errors.
2. Go to **Structure → Block layout**.
3. Find the region where you want the warnings to appear (for a development site,
   the **Footer** is a good, always‑visible choice) and click **Place block**.
4. Choose the **PHP Warnings & Errors** block from the list, configure the usual
   block visibility settings if you want to limit it to certain pages or roles,
   and save.

The block now lists the unique PHP warnings and errors it finds in the log.
Remember to remove it — or restrict it to administrators — before the site goes
to production.
