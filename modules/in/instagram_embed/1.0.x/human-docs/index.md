# Instagram Embed — manual setup guide

**Instagram Embed** (`instagram_embed`) lets editors embed Instagram posts, reels,
and IGTV videos directly inside CKEditor 5 content. It adds an **Instagram Post
button** to the editor toolbar; clicking it opens a small balloon form where the
editor pastes an Instagram URL, which the module validates before inserting. On
the front end, a text filter converts the stored placeholder into Instagram's
standard embed on render.

It is deliberately lightweight: **no build step, no external proxy service, and no
API key**. It uses Instagram's own native embed script directly, stores only a
small placeholder in the database, and performs strict server-side URL validation
so that no user-controlled markup or JavaScript is emitted — which keeps it safe
against cross-site scripting. There's also an optional per-embed background-color
toggle. It requires only core modules (**filter** and **ckeditor5**) and supports
Drupal 10.3+, 11, and 12.

One privacy note worth passing on: because the embed loads Instagram's native
widget, the visitor's browser contacts Instagram to render each post — the usual
third-party-embed consideration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. You switch it on by
adjusting your text formats and CKEditor 5 toolbar, as described below.

## Where it lives in the admin menu

Everything is configured under **Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`) — you edit the text format you
want Instagram embeds in.

## How to use it

Set it up on each text format where editors should be able to embed Instagram
content:

1. Go to **Configuration → Content authoring → Text formats and editors** and
   edit the format you want (for example **Full HTML**).
2. In the CKEditor 5 toolbar configuration, drag the **Instagram Post** button
   from the available buttons into the active toolbar.
3. Enable the **Instagram Embed** filter for that format.
4. Save the format.

Then, when writing content in that format, click the **Instagram Post** button,
paste an Instagram post/reel/TV URL into the balloon form, optionally set the
background color, and insert it. The post renders as an Instagram embed when the
content is displayed.
