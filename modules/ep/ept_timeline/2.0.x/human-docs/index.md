# EPT Timeline — manual setup guide

**EPT Timeline** (`ept_timeline`) adds a Timeline Paragraph type to your site — a
sequence of dated entries rendered in one of several presentation styles. It's the
component for a company history, a project's milestones, a product roadmap, or the
stages of an application process. Each entry is structured data with its own
fields, ordered by the editor and rendered by templates the theme can override —
much better than a hand-built table or a pile of nested divs in the body field.

EPT Timeline is one module in the **Extra Paragraph Types (EPT)** family. Every
EPT module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width — plus a per-instance style choice, so the same timeline
component can look different on different pages without new view modes. There is
**no site-wide settings page**: you configure each timeline on the paragraph where
you place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Timelines are configured per
instance, on the paragraph itself, using the style choice plus the shared EPT
design options described below.

## Where it lives in the admin menu

EPT Timeline adds no admin settings page. Once enabled it registers a **Timeline**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Timeline is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Timeline** paragraph type.
2. Edit a piece of content, add a **Timeline** paragraph, and add each dated
   entry, reordering them as needed. Pick the presentation style for this
   instance.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific timeline.
4. Save. The timeline renders at the position of the paragraph in the field.
