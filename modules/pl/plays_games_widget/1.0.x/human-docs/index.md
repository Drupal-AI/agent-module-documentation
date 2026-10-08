# Plays Games Widget — manual setup guide

**Plays Games Widget** (`plays_games_widget`) lets you add an interactive feed of
playable **HTML5 games** to your Drupal site through a configurable block. It embeds
the Plays Games service's game feed directly into your pages, so visitors can browse
and play casual games without leaving your site — a simple way to boost engagement and
time-on-site for publishers and community sites.

Each games feed is a Drupal **block**, so you place it in any theme region and
configure it there. You can set custom **width and height**, a **corner radius**, and
a **game category**, and the display is responsive across desktop, tablet, and mobile.
You can also place **multiple** independently configured blocks on the same page. The
module ships an administration dashboard with a **live preview** and **service
diagnostics** to help you set things up.

Two practical notes. The game content is served by the **Plays Games** service, so the
widget requires an **internet connection** to work and embeds third-party content — a
privacy consideration you may want to reflect in your privacy policy. No additional
Drupal modules or third-party libraries are required. (The project's security advisory
coverage is marked **not covered** at this version, so weigh that for high-value
sites.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no global settings form** — each games feed is configured on its own block,
described below.

## Where it lives in the admin menu

After enabling, open the **Plays Games Widget dashboard** from the Drupal
administration interface for a live preview and service diagnostics. You place and
configure the actual feeds from **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the games feed, and choose the
   **Plays Games Widget** block.
3. In the block's configuration, set its **width** and **height**, **corner radius**,
   and **game category**.
4. Save the block. Repeat to place additional, independently configured feeds — you
   can have several on the same page.

Use the Plays Games Widget dashboard's live preview and diagnostics while you tune the
settings, and remember the feed needs an internet connection to load games from the
Plays Games service.
