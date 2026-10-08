# Layout Builder No Render — manual setup guide

**Layout Builder No Render** (`layout_builder_norender`) adds a *publish /
unpublish* toggle to the individual components (blocks) you place inside a core
**Layout Builder** layout. An unpublished component is **not rendered** on the
live page — but it still shows on the Layout Builder *preview* screen, so content
editors can keep working on a component, stage it, or temporarily hide it without
deleting it and losing its configuration.

It works by adding a new **Publish / Unpublish** contextual link to each block in
the Layout Builder preview. On that preview a hidden component is marked with an
"Unpublished" label in red and covered with an overlay so editors can see at a
glance that it will not appear on the live page; hovering over the component lifts
the overlay so they can still see how it would look once rendered.

One thing to be clear about: this is an **editorial rendering toggle, not access
control**. Unpublishing a component only stops it from being output — it does not
protect the underlying content. If a component displays sensitive data, secure
that data with real access control on the block or entity, not by relying on this
toggle. The module extends core Layout Builder and depends on it alone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Once enabled, you use it
entirely from the Layout Builder editing interface, described below.

## How to use it

This module extends core Layout Builder, so you use it wherever Layout Builder is
active (a content type's *Manage display*, or a per‑entity layout override):

1. Edit a page's layout in **Layout Builder**.
2. Hover over any component (block) to reveal its contextual links.
3. Click the new **Publish / Unpublish** link to toggle that component.
4. When a component is unpublished it appears on the preview with a red
   "Unpublished" label and an overlay; hover over it to preview how it would look
   when rendered. It will **not** appear on the live page.
5. Save your layout. Unpublished components stay in the layout, ready to be
   published again later.
