# Revision Graph — manual setup guide

**Revision Graph** (`revision_graph`) shows your content's revision history as a
Git-style **graph** instead of a flat list. It adds a **Revision Graph** tab next
to the standard Revisions tab on an entity, where every language appears as a
branch and every revert appears as a fork — so you can see not just *that* content
changed, but *how*: which revision an edit was based on, where a revert branched the
history, and when each translation split off and caught up.

Drupal's built-in revision table tells you a list of changes. That is enough while
history is linear, but once you add translations, content moderation drafts
alongside a published version, or reverts, the story stops being a straight line —
two revisions from the same afternoon can belong to different branches, and a list
shows them as neighbours. The graph makes that structure visible, which is
especially useful when someone asks "where did my change go?"

This version (**3.1.x**) is the two-panel graph for **Drupal 10 and 11**. It needs
**no configuration** and has no dependencies. Access to the tab follows whatever
already governs the entity's revision tab — the module adds no permission of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module works as soon as it is enabled.

## How to use it

1. Enable the module — there is nothing to configure.
2. Open any node that has more than one revision and click the **Revision Graph**
   tab (alongside the standard **Revisions** tab). The graph draws the revision
   history, with a branch per language and forks where reverts occurred.

> **Access note:** because the graph exposes the full revision history at a glance,
> confirm who can reach the revision tab on sites where the *history itself* is
> sensitive. Revision Graph does not add or relax any access — it simply renders
> what the viewer is already allowed to see.
