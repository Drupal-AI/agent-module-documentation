# Scheduled Updates — manual setup guide

**Scheduled Updates** (`scheduled_updates`) changes field values on entities at a
time you choose — publish a page at nine on Monday, switch a price on the first of
the month, clear a banner when a campaign ends. Where the popular `scheduler`
module handles publishing and unpublishing for nodes, this is the general version:
**any field on almost any entity type** — content, users, taxonomy terms, files
and more — set to a new value at a future moment. Because so many things in Drupal
are fields, that includes properties like *published*, *promoted*, *sticky* and
*title*, not just custom fields.

That breadth covers cases the publishing‑only modules cannot: embargoing a
document until an announcement, rotating a promoted flag, changing a price, or
expiring a status field on a user account. Each scheduled update is itself an
entity, so your updates are listable, revisable and reviewable **before** they
fire.

The module supports two ways of scheduling. **Embedded updates** appear directly
on the add/edit form of the entity they will change — for example a publish or
unpublish date right on the node form, or setting a user to inactive on the user
edit form. **Independent updates** are created on their own forms, where you pick a
group of entities to change together — say, a batch of nodes to promote and
publish on a certain date, or a set of users to be given a role at the start of
next month.

The module needs configuration before it does anything: you must first create at
least one **Scheduled Update Type** (see the configuration guide). It depends on
core's **Options** module and on **Inline Entity Form**, and has no submodules.
This is the **3.0.x** branch; its core requirement is `^10.4 || ^11.3 || ^12` —
note that `^11.3` excludes earlier 11.x releases, and it reaches toward a core 12
that does not exist yet. The branch was brought up to 10.4/11 standards with the
help of AI, so the maintainers ask that you test it thoroughly.

The single most important operational fact is that **updates fire when cron runs,
not at the exact configured instant**. A site whose cron runs hourly cannot honour
a nine‑o'clock embargo to the minute. If timing matters — a press release, a
regulated disclosure — sort out your cron frequency first, and confirm what happens
to an update whose scheduled moment passed while cron was not running.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   its dependencies.
2. [Configuration](configuration/index.md) — creating Scheduled Update Types,
   embedded vs independent updates, permissions and the cron caveat.

## Where it lives in the admin menu

Scheduled Update Types are managed under **Configuration → Workflow → Scheduled
Updates → Scheduled Update Types** (route `scheduled_update.config.overview`).

## How to use it

After creating a Scheduled Update Type, you either add embedded updates on the
entity's own add/edit form, or create independent updates from their own forms to
target a batch of entities. The scheduled changes then apply automatically on the
next cron run at or after their configured time.
