# Link Advance Attributes — manual setup guide

**Link Advance Attributes** (`link_advance_attributes`) extends Drupal's core
**Link** field so that a link can carry richer presentation — most notably an
**icon or image** pulled from your Media library. You upload a media image to a
native link field and the module overrides the link's output to include that image
alongside (or in place of) the default link text. It's the module to reach for when
you want, say, a menu of links where each one shows an icon.

The extra data is stored with the link and rendered on output; the module has no
access‑control role of its own. It builds on core **Link**, **Media**, and **Media
Library**, so you get the familiar media‑selection UI when adding the image.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no central settings page**. You configure it per field on the
form and display screens, described in "How to use it" below.

## How to use it

1. Make sure the entity (content type, taxonomy vocabulary, etc.) has a **Link**
   field.
2. On the bundle's **Manage form display**, use the widget provided by this module
   so editors can attach a **media image** (via Media Library) to each link value.
3. On the bundle's **Manage display**, choose this module's formatter so the link
   renders with its attached image/icon.
4. Save. When you edit content, you can now pick an icon image for each link, and
   it appears in the rendered output.
