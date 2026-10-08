# Paragon Core — manual setup guide

**Paragon Core** (`paragon_core`) is a tiny shared‑base module for sites built on
the Paragon distribution. It does exactly one thing: it tidies up the **local‑task
tabs** — the row of tabs such as *View*, *Edit*, *Revisions* and *Delete* — that
appear at the top of a node, so that every Paragon site presents the same, cleaner
set of editor tabs in the same order.

Concretely, once enabled it relabels and reorders those tabs: it renames the
Layout Builder tab to "Layout Builder", relabels the Content Moderation
"Workflows" tab to **"Preview"** and moves it to the front so it is the first thing
editors see, renames the node revision‑history tab to **"Version History"**, moves
the **Edit** tab into a consistent position, and **removes the Delete tab** from
the tab bar for a less cluttered, less accident‑prone editing screen.

It is important to understand that hiding the Delete tab is **presentation only**.
The underlying delete route and all of its access checks are untouched — a user who
has permission to delete a node can still do so through other paths; the tab is
simply not shown in the local‑task bar. Paragon Core is not an access‑control
module.

The module ships no settings page, no permissions, no routes and no configuration
of any kind. It is meant to be enabled as a base dependency of other Paragon
packages (for example [Paragon Gin](../../paragon_gin/1.1.x/human-docs/index.md))
and as a lightweight home for further shared Paragon admin tweaks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Its behaviour — the relabelled,
reordered tabs — applies automatically the moment it is enabled.

## Where it lives in the admin menu

Paragon Core adds no admin page. Its effect shows up on **node pages**: open any
node and look at the tab row along the top — you should see the "Preview" tab first,
a "Version History" tab, and no "Delete" tab.

## How to use it

There is nothing to configure. Enable Paragon Core (usually because you are running
a Paragon‑based site or installing Paragon Gin, which depends on it) and the tab
tidy‑up takes effect. If you later build additional shared admin‑UX tweaks for your
Paragon sites, this is the natural module to extend.
