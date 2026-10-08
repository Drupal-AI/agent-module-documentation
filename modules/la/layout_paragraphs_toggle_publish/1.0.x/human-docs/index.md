# Layout Paragraphs Toggle Publish — manual setup guide

**Layout Paragraphs Toggle Publish** (`layout_paragraphs_toggle_publish`) adds a
**publish/unpublish** control to each component in the
[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) builder, so
a section can be hidden without being deleted.

Layout Paragraphs gives editors a drag‑and‑drop page builder made of paragraph
components, and its controls already cover add, edit, move, and delete. The verb
that is missing is the one editors reach for constantly: *hide this for now*. A
seasonal promotion between campaigns, a section awaiting legal sign‑off, a
component being compared against another — all of them want to be kept but not
shown. Without a toggle the only options are to delete the component and rebuild it
later, or to park an unused copy somewhere; both lose work and context. Paragraphs
entities already carry a published flag, and this lightweight module simply exposes
that flag as a button in the builder's controls.

Two things are worth knowing before you rely on it. First, an unpublished paragraph
is **hidden, not removed** — it still occupies a position in the field, still
exports with your configuration, and is still handed to anything that reads the
field directly. Second, confirm that your site's **view modes and any API
consumers actually respect** the paragraph's published flag, because not every
renderer does.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Paragraphs and Layout Paragraphs.

There is **no settings page** for this module. Once enabled, the publish/unpublish
control simply appears on every component in the Layout Paragraphs builder.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from within the Layout
Paragraphs builder on any content that uses a Layout Paragraphs field.

## How to use it

1. Edit a piece of content that uses a Layout Paragraphs paragraph‑reference field.
2. In the builder, each component now shows a **publish/unpublish** control
   alongside its existing edit, delete, and move controls.
3. Toggle a component to **unpublished** to hide it from the rendered page while
   keeping it — its content and settings — in place. Toggle it back to
   **published** when you want it to appear again.

Access to the toggle follows Layout Paragraphs' own rules: anyone who may already
edit that layout can use it, and it inherits any future change to the parent
module's access handling. There is no separate permission to grant.
