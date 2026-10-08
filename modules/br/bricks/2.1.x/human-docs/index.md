# Bricks — manual setup guide

**Bricks** (`bricks`) is a page-building field type. It lets editors nest
referenced entities into a drag-and-drop tree — much like arranging menu or
taxonomy items — which is then rendered recursively on the page. Think of it as a
lightweight alternative to Paragraphs, Panelizer or Layout Builder that stays
entirely within Drupal core's own building blocks: Entity Reference, display
modes, the Layout API and the tabledrag JavaScript.

Instead of shipping a whole new storage model, Bricks adds a `bricks` field type
that extends core's entity-reference field with two extras per item: a **depth**
(so items can be indented into a tree) and a small **options** blob (a view-mode
override, optional CSS class/id, and — for a layout item — which Layout API layout
to use). On save it normalises the depths so every child sits exactly one level
under its parent; on display, the flat list of referenced entities is folded into
a nested tree, with access-denied items (and their children) quietly dropped. You
can reference any entity type — nodes, custom blocks, ECK entities, paragraphs —
in a single Bricks field.

Bricks does **not** force a special widget on you: it makes the `bricks` field
type usable by *any* entity-reference-compatible widget, and injects the tree UI
(drag-to-indent, plus the per-item options) into whichever widget you choose. It
works the moment you enable it, but there's nothing to *do* until you add a Bricks
field to a bundle and pick the Bricks formatter — that setup is the real
configuration. The base module has no admin settings page and no permissions of
its own. It ships seven optional submodules for demos and variants (revisioned,
dynamic, paragraphs- and inline-entity-form-based widgets), and integrates with
Entity Usage and (when present) Replicate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — adding a Bricks field to a bundle,
   choosing a widget, the Bricks formatter, and the per-item options.

## Where it lives in the admin menu

There is no dedicated settings page. You work with Bricks through the standard
**Field UI**: add a **Bricks** field to an entity bundle under *Manage fields*,
choose a widget on *Manage form display*, and select the **Bricks** formatter on
*Manage display*.
