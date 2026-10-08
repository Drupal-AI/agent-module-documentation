# Relevant Content — manual setup guide

**Relevant Content** (`relevant_content`) shows visitors other content similar to
the page they are on, based on **shared taxonomy terms**. If a blog post is tagged
with A, B, C, and D, the module finds other published nodes that share those tags,
ranks them by how many tags they have in common (with the most recently created
winning ties), and lists them in a block — the classic "related articles" or "you
might also like" feature, built without writing a single View.

The way you shape it is through **presets**. Each preset is a configuration entity
that says which content types to consider, which vocabularies to match on, and how
many results to show at most. Every preset you create produces its own **block**,
which you then place on the node pages where you want suggestions to appear. The
block is context-aware: it reads the current node from the route, and it
automatically excludes the node you are viewing from its own suggestion list.

The module depends on core's **Node**, **Taxonomy**, and **Block** modules and
runs on Drupal 9 and 10. For developers, it also dispatches a `TermAlter` event so
custom code can add or change the terms used for matching.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

Relevant Content has no single "settings form" — instead you create one or more
**presets** and place their blocks. Because each preset is a configuration entity,
your presets export and deploy with Configuration Management. The full workflow is
in "How to use it" below.

## Where it lives in the admin menu

You manage presets under **Configuration → Search → Relevant Content**
(controlled by the *administer relevant content* permission). You place the
resulting blocks from the usual **Structure → Block layout**.

## How to use it

1. **Create a preset.** Go to **Configuration → Search → Relevant Content** and
   add a preset. Choose:
   - the **content types** the block should consider,
   - the **vocabularies** whose terms should count toward "relevance," and
   - the **maximum number** of results to show.
2. **Place the preset's block.** Go to **Structure → Block layout**, find the
   block under the *Relevant Content* category (each preset gets its own block),
   and place it in a region on your node pages. Because the block uses the node
   route context, it naturally appears on node pages and shows suggestions for the
   node being viewed.
3. **Repeat as needed.** Create additional presets for different sections of the
   site (for example one rule for blog posts, another for products), each with its
   own block.

When someone views a node, the block queries for published nodes of the allowed
types that share the current node's terms, ranks them by the number of matching
terms (then by recency), excludes the current node, and lists up to your maximum.
If nothing matches, it degrades gracefully.

> **For developers:** subscribe to the `TermAlter` event to add or change the set
> of terms used for matching before the query runs — handy for boosting or
> filtering relevance programmatically.
