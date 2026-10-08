# Media Crowdriff — manual setup guide

**Media Crowdriff** (`media_crowdriff`) adds a Drupal **media source** for
[Crowdriff](https://crowdriff.com/), the visual/UGC gallery platform. With it,
editors can paste a Crowdriff embed code into Drupal's Media system and then reuse the
resulting gallery like any other media asset — in entity-reference media fields, in
the Media Library, and inside CKEditor via the Insert Media button.

The module hooks into core Media rather than adding screens of its own. It provides a
media source plugin (so you can create a Media type backed by Crowdriff), a tailored
Media Library "add" form with an **Embed Code** textarea, a validation rule that
rejects anything that is not a real Crowdriff embed, and a field formatter that turns
the stored embed code into Crowdriff's live gallery at display time. The raw embed
code is what gets stored; the formatter injects Crowdriff's loader script only when
the media is rendered.

Because it plugs straight into core Media, everything you already know about media
applies: revisions, access control, translation, and reusing one asset across many
pages all work normally. There is **no settings page, no configure route, and no
permissions of its own** — you "set it up" entirely through core Media's own
interface.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the four plugins, the validation regex, and the theme hook
— read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Media.

There is no separate configuration page for this module: setup happens through core
Media, as described below.

## How to use it

All configuration is standard core Media. To get a working Crowdriff media type:

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. For **Media source**, choose **Media Crowdriff**, then save. Core automatically
   creates a text source field to hold the embed code.
3. Editors add assets at **Content → Media → Add media → (your type)**, or through
   the **Media Library** on any media field. They paste the fragment copied from
   Crowdriff's share/embed dialog into the **Embed Code** textarea. On save, the
   module validates that the code contains a real Crowdriff id and rejects it
   otherwise, with a clear error message.
4. To control the rendered size, edit the media type's **Manage display** and set the
   **Media Crowdriff** formatter's **Width** and **Height** (CSS units such as `640px`
   or `100%`; the defaults are `100%` wide and `900px` tall).

From then on, Crowdriff galleries behave like any other media: reference them from
fields, list them in Views, embed them in body text, or swap a gallery site-wide by
editing one media entity.

## Where it lives in the admin menu

Media Crowdriff has no dedicated admin page. It appears as the **Media Crowdriff**
option under **Media source** when you create or edit a Media type at **Structure →
Media types**, and as the **Media Crowdriff** display format on that type's **Manage
display** page.
