# Layout Builder Block Copy — manual setup guide

**Layout Builder Block Copy** (`layout_builder_block_copy`) adds a **Copy block**
action to Drupal's **Layout Builder**, so a content editor can duplicate any inline
block within the same section with a single click from the block's contextual menu.

The important detail is that this is a **deep clone**, not a shallow reference.
Each copy becomes a brand‑new, fully independent `block_content` entity: editing a
copied block never affects the original, and deleting the original never removes
the copy. That independence goes both ways, which is what you want when you copy a
block as a starting point and then edit it. It is also compatible with the **Quick
Node Clone** module — cloned nodes receive their own independent block entities
rather than sharing them.

It was created to address known issues in the similar *Layout Builder Block Clone*
project, including shallow‑clone behaviour and Drupal 11 incompatibility, and it
needs no contrib dependencies beyond Drupal core. Copying happens entirely within
the Layout Builder edit flow, which is already gated by layout/edit access, so the
module adds no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no settings form — copying is an editor action inside Layout
Builder. See "How to use it".

## Where it lives in the admin menu

Layout Builder Block Copy adds no admin settings page. The **Copy block** action
appears in a block's contextual menu while you edit a layout in **Layout
Builder** — see
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit a layout in **Layout Builder** (for example a per‑entity layout, or a
   content type's **Manage display** with Layout Builder enabled).
3. Open the contextual menu on an **inline block** you want to duplicate, and
   choose **Copy block**. A new, independent copy is created in the same section.
4. Edit the copy as needed — changes to it do not affect the original, and vice
   versa — then **Save the layout**.
