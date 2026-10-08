# Scheduler for ECK — manual setup guide

**Scheduler for ECK** (`scheduler_eck`) is a small bridge module that connects
the [Scheduler](https://www.drupal.org/project/scheduler) module to the
[Entity Construction Kit (ECK)](https://www.drupal.org/project/eck) module. On
its own, Scheduler lets editors set a future date to publish or unpublish core
content like nodes and media. This module extends that same convenience to the
custom entity types you build with ECK, so an ECK entity can be set to go live
at a chosen time and to come down again later — all without writing any code.

Under the hood it registers each of your ECK entity types with Scheduler as a
schedulable type, reusing Scheduler's familiar *publish-on* and *unpublish-on*
date fields and its cron-driven processing. It adds no settings pages, routes,
or permissions of its own — it is pure "glue" between the two modules. Because
scheduling runs through Scheduler's normal cron and Drupal's existing entity
access, it adds no new public endpoints or attack surface.

There is nothing to configure inside this module itself. Once it is enabled
alongside Scheduler and ECK, you turn scheduling on per ECK entity type/bundle
using **Scheduler's own settings** (the same controls Scheduler adds to node and
media types). It requires Scheduler 2.0.0-rc4 or newer.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it alongside Scheduler and ECK, and confirm the requirements.

## How to use it

There is no configuration page for this module. After installing and enabling
it (see [Installation](installation/index.md)):

1. Make sure the ECK entity type has a **status (published/unpublished) field**
   enabled — Scheduler needs something to publish and unpublish.
2. Visit the ECK bundle's edit page (or the Scheduler settings form) and turn on
   Scheduler's **publish-on** and/or **unpublish-on** options for that bundle,
   exactly as you would for a content type.
3. Make sure **cron runs** on your site — Scheduler processes any dates that have
   come due on each cron run.

From then on, editing an ECK entity of that bundle shows Scheduler's date fields,
and the entity will publish or unpublish itself automatically when the time
arrives. All of the scheduling experience comes from Scheduler itself.
