# Publish Guard — manual setup guide

**Publish Guard** (`publish_guard`) is an editorial safeguard that restricts *when*
content can be published. You define the days of the week and the daily time
window during which publishing is allowed, and the module warns editors — or
outright blocks them — if they try to publish outside that window. It's built for
teams who want to avoid content going live during nights, weekends, or holidays
when nobody is around to catch a mistake.

There are two enforcement modes. In **Warn** mode, an editor who tries to publish
outside the allowed window sees a message but can still go ahead. In **Block**
mode, publishing outside the window is prevented entirely — the node form refuses
to save the node as published. Either way, you can customise the message editors
see, and you can grant trusted roles a **Bypass Publish Guard** permission so
release managers aren't held to the schedule. Time checks use your site's
configured timezone, so the window means what your team means by it.

One thing to be clear about: Publish Guard operates on the **node add/edit form
only**. It's a UI convenience to prevent accidental after‑hours publishing — not a
hard security boundary. It does **not** restrict who can *view* content, and it
does **not** intercept programmatic saves, REST/JSON:API writes, migrations, or
Scheduler‑driven (cron) publishes. If you need genuinely scheduled publishing,
pair it with the Scheduler module; if you need enforced editorial workflows, look
at Content Moderation. Publish Guard is deliberately narrow: a simple time‑window
guard on the publish action itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable restrictions, set the allowed
   days and daily window, choose Warn or Block, and grant the bypass permission.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Publish Guard** (`/admin/config/content/publish-guard`). The module is
**disabled by default**, so no restrictions apply until you turn them on there —
see [Configuration](configuration/index.md).
