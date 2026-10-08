# Profile Updates — manual setup guide

**Profile Updates** (`profile_updates`) lets site administrators review the
optional configuration changes shipped by an install profile (or its modules) and
decide — one by one, or in bulk — which ones to apply. Unlike a forced
`hook_post_update_N()`, applying a profile update is always a deliberate action:
nothing runs automatically on `drush updb` or `drush deploy:hook`.

It is aimed at distributions and their maintainers. Instead of a full
config-import workflow, each shipped change surfaces as a discrete, per-site
opt-in that you can review — with a live config diff — and then **Apply** (through
the Batch API, so it scales) or **Skip**. Every choice is recorded in a permanent
audit log, and a skip can later be undone (**Restore**) so the update returns to
the pending list. Each update's state is worked out live for *your* site by
diffing the shipped config against your active config, so it always reflects what
actually needs attention here: Pending, Blocked, Up to date, Applied, or Skipped.

Update tasks are auto-discovered as plugins from any enabled extension's
`update_tasks/*.yml` files and re-scanned on every cache clear — there is no
import step and no sync directory to manage. A Drush command set (`pu:list`,
`pu:apply`, `pu:skip`) lets you drive the same workflow from CI or deploy
pipelines, and an optional **Profile Updates: Export** submodule can generate
update-task YAML (or update-hook scaffolding) for distribution authors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   `config_update` dependency with Composer, then enable it.

Profile Updates has no settings form to configure. Its one admin screen is the
review list described below, where you apply or skip the updates a profile ships.

## Where it lives in the admin menu

Once enabled, the review screen sits at **Configuration → Development → Profile
updates** (`/admin/config/development/profile-updates`). Every route is gated by
the restricted **Administer profile updates** permission, so grant it only to
trusted administrators.

## How to use it

1. Open **Configuration → Development → Profile updates**. Each shipped update is
   listed with its current, per-site **state** — *Pending* (actionable now),
   *Blocked* (waiting on a required module or an earlier update — the row names
   what it needs), *Up to date*, *Applied*, or *Skipped*.
2. Click through to a per-item **diff** to see exactly what an update would change
   before you commit to it.
3. **Apply** an update to bring the shipped config into your active config (this
   runs through the Batch API and is recorded in the audit log), or **Skip** an
   update you never want on this site.
4. Browse the **Applied** and **Skipped** tabs at any time. The Applied tab even
   shows the historical before/after captured at apply time, and you can
   **Restore** a skipped update — that simply removes the skip record so the task
   recomputes back to *Pending*.

Because state is keyed to a content hash of the shipped config, a re-released
update automatically re-appears as pending rather than being silently missed. To
drive the same actions headless — for CI or a deploy step — use the `pu:list`,
`pu:apply`, and `pu:skip` Drush commands.
