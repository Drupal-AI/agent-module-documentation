# EPT Hero — manual setup guide

**EPT Hero** (`ept_hero`) adds a ready-made Hero Paragraph type — the big opening
banner at the top of a landing page. A hero here is a title, a subtitle or
description, and up to two buttons, usually over a background image or video. It
supports a couple of layout styles (a **2-column** hero and a **one-column**
hero), so it works as a homepage opener, a campaign page header, a product or
service page banner, or a section opener partway down a page.

EPT Hero is one module in the **Extra Paragraph Types (EPT)** family. Its buttons
come from the shared
[`ept_basic_button`](https://www.drupal.org/project/ept_basic_button) module — so
they are a genuine shared component rather than a link field styled by hand, which
is what keeps buttons consistent between the hero and everything else — and the
common per-instance *design options* (spacing, background, container width) come
from the shared [`ept_core`](https://www.drupal.org/project/ept_core) base
module. As with every EPT type there is **no site-wide settings page**: you
configure each hero on the paragraph where you place it.

One thing worth deciding yourself, because no module can decide it for you: the
**heading level**. A hero at the very top of a page is usually the page's `h1`,
but a hero placed mid-page is not. If you use the component in both positions,
make sure the rendered heading level is right for each so you don't end up with
two `h1`s or a document outline that skips a level.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Heroes are configured per
instance, on the paragraph itself, using the hero layout styles plus the shared
EPT design options described below.

## Where it lives in the admin menu

EPT Hero adds no admin settings page. Once enabled it registers a **Hero**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Hero is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Hero** paragraph type.
2. Edit a piece of content, add a **Hero** paragraph, and fill in the title,
   subtitle, and up to two buttons. Choose the 2-column or one-column style.
3. Open the paragraph's **design options** (from `ept_core`) to set the
   background image or video, spacing, and width. Button styling comes from
   `ept_basic_button`.
4. Save. The hero renders at the position of the paragraph in the field.
