# Revision Graph — manual setup guide

**Revision Graph** (`revision_graph`) shows your content's revision history as a
Git-style **graph** instead of a flat list. It adds a **Revision Graph** tab to
every node, next to the standard Revisions tab, where every language appears as a
branch and every revert appears as a fork — so you can see not just *that* content
changed, but *how*: which revision an edit was based on, where a revert branched the
history, and when each translation split off and caught up.

Drupal's built-in revision table lists changes, which is fine while history is
linear. Once you add translations, content moderation drafts alongside a published
version, or reverts, the story stops being a straight line — two revisions from the
same afternoon can be on different branches, and a flat list shows them as
neighbours. The graph makes that structure visible, which is exactly what you want
when someone asks "where did my change go?"

This is the **4.0.x** branch — a new major version for **Drupal 11 and 12**.
Compared with the 3.1.x branch it:

- replaces the two-panel graph with a single **revision rail**, drawn by a new
  standalone TypeScript renderer served through a JSON endpoint that pages in more
  data as you scroll;
- adds a **settings form and an `administer revision graph` permission** so you can
  choose the colour of each branch (language);
- records true provenance in a new `revision_graph_parent` base field, so reverts
  show as real forks rather than guesses (this needs a database update after
  upgrading — see Installation).

> **Upgrading from 3.x?** 4.0 dropped Drupal 10, and its client is a rewrite. If
> your site extends Revision Graph's shipped JavaScript library, you will need to
> update that integration — see the module's changelog.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and run the required database update.
2. [Configuration](configuration/index.md) — the optional branch-colour settings
   form and its permission.

## Where it lives in the admin menu

The graph itself appears on the **Revision Graph** tab of any node with revisions.
Its optional settings form is at **Configuration → Content authoring → Revision
Graph** (`/admin/config/content/revision-graph`).

## How to use it

1. After installing and running the database update (see Installation), open any
   node that has more than one revision and click the **Revision Graph** tab. The
   revision rail draws the history, with a lane per language and forks where reverts
   occurred.
2. Optionally, adjust the colour used for each branch on the settings form — see
   [Configuration](configuration/index.md).

> **Access note:** the tab and its JSON data endpoint both require the core
> "view all revisions" permission on the node — no permission of the module's own
> gates *viewing* the graph. On sites where revision history itself is sensitive,
> confirm who holds that permission, since a graph makes the history much easier to
> read at a glance.
