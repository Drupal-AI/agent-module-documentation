# EPT Call to Action — manual setup guide

**EPT Call to Action** (`ept_cta`) adds a Call-to-Action Paragraph type to your
site: a heading, a block of text, an image or video, and one or two buttons —
the promotional block that sits on a landing page and pushes the visitor toward a
next step. Its settings let you choose a 1- or 2-column layout, place the image to
the left or right, and optionally make the image "fluid" so it takes 50% of the
width. The whole thing is mobile responsive and collapses to a single column at a
breakpoint you select.

EPT Call to Action is one module in the **Extra Paragraph Types (EPT)** family.
Its buttons are provided by the shared
[`ept_basic_button`](https://www.drupal.org/project/ept_basic_button) module, so
button colors and styles stay consistent with the rest of your EPT components,
and the common per-instance *design options* (spacing, background, container
width) come from the shared
[`ept_core`](https://www.drupal.org/project/ept_core) base module. As with every
EPT type there is **no site-wide settings page** — you configure each call to
action on the paragraph where you place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Compatibility note worth reading before you adopt it.** Release **2.0.1** of
> this module has a defect against `ept_core` 2.0.0: its settings widget was not
> updated when `ept_core`'s widget base class gained two constructor arguments, so
> on a clean install the module enables and the `ept_cta` paragraph type is
> created, but its edit form is never written — the type exists with no working
> form. This is the family-wide "widget constructor" issue. Check the resolved
> `ept_core` version before you rely on this component, pin the EPT modules
> together, and test that you can actually add and edit a CTA paragraph after
> installing. See the [`agent/`](../agent/start.md) notes for the exact error.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Calls to action are
configured per instance, on the paragraph itself, using the CTA layout options
plus the shared EPT design options described below.

## Where it lives in the admin menu

EPT Call to Action adds no admin settings page. Once enabled it registers a
**Call to Action** Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Call to Action is used by placing it inside a
**Paragraphs field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Call to Action** paragraph type.
2. Edit a piece of content, add a **Call to Action** paragraph, and fill in the
   heading, text, media, and button(s). Choose a 1- or 2-column layout and, if
   using two columns, the image side and whether it is fluid.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific block. Button styling comes from
   `ept_basic_button`.
4. Save. The call to action renders on the page and collapses to one column on
   small screens.
