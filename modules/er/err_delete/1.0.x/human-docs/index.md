# ERR Delete — manual setup guide

**ERR Delete** (`err_delete`) adds an alternative, **recursive** delete operation
for nodes that are connected through **Entity Reference Revisions** (ERR) — the
mechanism behind Paragraphs and other composite content. Deleting such content
cleanly is fiddly with the default delete, because a node can own referenced items
that may or may not be safe to remove. ERR Delete gives you a delete flow that walks
those relationships and lets you decide, item by item, what to remove.

When editing an entity, a **recursive delete** button appears at the bottom of the
page. Clicking it takes you to a list of the entities connected to the one you're
deleting. For each referenced item you get a checkbox: tick it to **permanently
delete** that referenced item along with the parent, or leave it unticked to keep
it. The guidance is simple — if a referenced item is used elsewhere and you want to
keep it there, don't tick it; only tick items you're sure are unused, or that you
genuinely want removed everywhere.

It depends on core's **Node** module, provides its own permission, and supports
Drupal 10 and 11.

> **This operation is destructive.** Deletions here are permanent, and ticking a
> referenced item's checkbox removes it from the whole system — including anywhere
> else it's used. Review the connected-items list carefully before confirming, and
> keep a backup. Deletion is gated by this module's permission, so grant it only to
> trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the small settings form for the delete
   button's label and visibility.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → ERR Delete settings**.
The recursive delete button itself appears on the node edit form, not in the admin
menu.
