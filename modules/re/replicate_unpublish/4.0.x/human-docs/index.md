# Replicate Unpublished — manual setup guide

**Replicate Unpublished** (`replicate_unpublish`) is a small "glue" module that
makes cloned nodes safe by default: whenever you duplicate a node with the
[Replicate](https://www.drupal.org/project/replicate) module, this module
automatically sets the new copy — and every one of its translations — to
**unpublished**. That way a fresh clone never goes live by accident before an
editor has reviewed and updated it.

It solves a common editorial hazard. Without it, clicking "Clone" can create a
second, near-identical published page — which can duplicate live content, hurt
SEO, and needlessly fire node-published side effects such as notifications,
search indexing, feeds, or webhooks. Replicate Unpublished turns cloning into a
"duplicate then edit privately" workflow instead.

There is **nothing to configure**. The module registers a single event
subscriber that reacts to Replicate's clone event; installing and enabling it is
the entire setup. It only touches **nodes** — other entity types that Replicate
can clone are left exactly as they were. It depends on both **Replicate**
(`replicate`) and **Replicate UI** (`replicate_ui`), and it has no admin page,
no settings, no permissions, and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Replicate and Replicate UI.

## Where it lives in the admin menu

Nowhere — the module has no admin page and adds no menu items. Its effect is
invisible until you clone a node.

## How to use it

Just enable it, then clone nodes as you normally would with Replicate UI:

1. Make sure Replicate and Replicate UI are working (the clone action appears on
   content).
2. Clone a node — for example from the **Content** list
   (`/admin/content`) or a node's operations, using Replicate UI's **Clone**
   action.
3. The new copy is saved **unpublished** across all its translations. Open it,
   make your changes, and publish it when you're ready.

That's the whole behaviour. If you also need clones of *other* entity types
(media, taxonomy terms, custom entities) to start unpublished, or you want to
reset a Content Moderation state on clone, that requires a small custom event
subscriber — see the sibling [`agent/`](../agent/start.md) docs for the
extension points.
