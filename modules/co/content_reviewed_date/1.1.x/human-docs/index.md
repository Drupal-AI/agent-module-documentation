# Content Reviewed Date — manual setup guide

**Content Reviewed Date** (`content_reviewed_date`) tracks when each piece of
content was last reviewed by an editor and surfaces content that has gone stale.
On any site where pages need to stay accurate — policies, product information,
help documentation — content quietly ages, and nobody can say which pages are
overdue for a look. This module records a "last reviewed" date per node and gives
editors a report of everything that's past its review-by point, so aging content
doesn't slip through the cracks.

When enabled, it adds a **Last Reviewed** date field and a **Reviewed By** user
reference field to node types, and content is automatically marked as reviewed
whenever an authenticated editor saves a tracked node — no extra step. A
**Stale Content** admin report at `/admin/content/stale-review` lists all
published nodes that are past their review threshold or have never been reviewed.
And a **Mark as Reviewed** tab on each tracked node lets an editor record a fresh
review date in one click, *without* having to change the content itself.

You control which content types participate, and how long is "too long", from a
settings page: a global staleness threshold in days, with optional per-content-
type overrides so different content can have different review intervals. Two
fine-grained permissions separate the two audiences — one lets editors mark
content as reviewed, the other lets administrators manage the settings. It depends
on core's **Node** and **DateTime** modules and requires Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note:** This project is not covered by Drupal's security advisory policy.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types are
   tracked, set the staleness threshold, and grant the permissions.

## Where it lives in the admin menu

The settings page is at **Configuration → Content → Content Reviewed Date**
(`/admin/config/content/reviewed-date`). The stale-content report is at
**Content → Stale Content** (`/admin/content/stale-review`), and each tracked node
gains a **Mark as Reviewed** tab.

## How to use it

1. Configure which content types are tracked and set your thresholds (see
   [Configuration](configuration/index.md)).
2. Editors simply edit and save tracked nodes as usual — the review date updates
   automatically. To record that a page has been reviewed *without* editing it,
   use the **Mark as Reviewed** tab on the node.
3. Check **Content → Stale Content** (`/admin/content/stale-review`) to see which
   published pages are overdue for review or have never been reviewed.
