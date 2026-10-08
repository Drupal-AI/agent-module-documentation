# GIF Player — manual setup guide

**GIF Player** (`gifplayer`) is a file **field type and formatter** for animated
GIFs that don't autoplay. By default each GIF is shown as a paused still image
with a play indicator; the animation only starts when the visitor clicks it, and
clicking again pauses it. That keeps pages calmer and lighter — no motion or
bandwidth is spent until a reader deliberately opts in.

Under the hood the module uses the **GifPlayer jQuery library** to render each GIF
according to how you configure the field formatter. The field configuration lets
you choose which elements appear in the edit widget and which are rendered for
display. It's a more polished, modern take on the older *Animated GIF* module,
built to current Drupal coding standards with a proper configurable GIF field type
rather than a plain file upload.

GIF Player works on **any fieldable entity type**, so you can add it to content
types, media, users, taxonomy terms, and so on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate settings page you need to visit to get started** — the
field type and its formatter are configured directly on your entity's *Manage
fields* and *Manage display*, described in "How to use it" below. (The module does
expose one small option, described there, for loading the GifPlayer library
site‑wide instead of only on the field.)

## Where it lives in the admin menu

GIF Player adds no content of its own. You use it through the **Field UI** —
**Structure → Content types → *(your type)* → Manage fields** to add the field,
and **Manage display** to pick the GIF Player formatter. The formatter and widget
settings live on those field pages, not on a central admin form.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields →
   Add field** (the same works for any fieldable entity — media, users, terms).
2. Add the **GIF Player** field type, give it a label, and save the field
   settings. Configure the widget on **Manage form display** to decide which
   elements editors see when uploading.
3. On **Manage display**, set the field's format to the **GIF Player** formatter
   and adjust its options for how the GIF is rendered.
4. Add content, upload a GIF, and save. On the rendered page the GIF appears
   paused and plays on click.

**Loading the library globally:** by default the GifPlayer library is attached
only where the field is rendered. If you need it available site‑wide (for example
to drive GIFs added outside this field), the module's configuration page offers an
option to load the library globally — leave it off unless you specifically need
it, to avoid loading the script on pages that don't use it.
