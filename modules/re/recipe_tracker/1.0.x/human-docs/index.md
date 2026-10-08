# Recipe Tracker — manual setup guide

**Recipe Tracker** (`recipe_tracker`) keeps an audit trail of the Drupal
[recipes](https://www.drupal.org/docs/extending-drupal/drupal-recipes) applied to
your site. Every time a recipe is applied, the module records a log entry
capturing the **recipe name**, its **Composer package and version**, **who**
applied it, and **when**. That gives you provenance for the configuration recipes
install — useful for verifying which recipes a deployment actually applied,
distinguishing core recipes from contrib/custom ones, and feeding a change‑management
or compliance review.

It works entirely automatically. An event subscriber listens for core's
"recipe applied" event and writes a log record each time — there's nothing to call
and nothing to configure. The records are stored as a dedicated content entity
(`recipe_tracker_log`) and are browsable through a simple admin list, where you can
view an individual entry or delete old ones (individually or in bulk). Records are
retained independently of the server's Composer/Git state, so history survives even
if the codebase moves on.

The module requires **Drupal 11** (it depends on core's Recipe system) and has no
contrib dependencies, no Drush commands, and no plugin types. It defines a single,
restricted‑access permission — **Administer logs**
(`administer recipe_tracker_log`) — that gates all access to the log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The recipe log lives under **Extend** at
**Administration → Extend → Recipe log** (`/admin/modules/recipe-log`). You need
the **Administer logs** permission to see it.

## How to use it

There is **nothing to configure** — the module has no settings form. Once enabled,
it silently records a log entry whenever a recipe is applied (from that point
onward; it can't retroactively log recipes applied before it was installed).

To review the history, go to **Extend → Recipe log** (`/admin/modules/recipe-log`).
The list shows, newest first, who applied each recipe, the recipe, its version, and
when it was applied. Click through to a single record for its full detail. To tidy
up, use the row's **Delete** action, or select several entries and run the
**Delete logs** bulk operation. All of this requires the **Administer logs**
permission, which is marked restricted‑access — grant it only to trusted
administrators.

Because the version comes from Composer's installed‑package data, a core recipe is
recorded against `drupal/core`, while a contrib or custom recipe is recorded
against its own package name and version — so you can tell at a glance where each
applied recipe came from.
