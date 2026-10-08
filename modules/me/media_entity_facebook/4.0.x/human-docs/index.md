# Media Entity Facebook — manual setup guide

**Media Entity Facebook** (`media_entity_facebook`) adds a **Facebook** media
source to Drupal's core Media system, so editors can create Media entities from
Facebook post, photo, or video URLs (or from a pasted `<iframe>` embed code) and
place them anywhere Media is used. Instead of dropping raw embed snippets into
the body, your team manages Facebook content as proper reusable media.

Under the hood the module defines a `facebook` media source whose field holds a
Facebook content URL, validated so only genuine `facebook.com` / `fb.watch`
addresses are accepted (a pasted iframe has its real URL extracted
automatically). It renders through the `facebook_embed` formatter, which has two
modes. The default **Embedded Posts** mode uses Facebook's JavaScript SDK and
needs no app review — it just works. The alternative **oEmbed API** mode calls
Facebook's Graph API server-side using an app ID and secret; it produces
server-rendered embed HTML but requires a reviewed Facebook app.

Editors can add Facebook media straight from the core **Media Library** modal,
and themers can override the embed markup. There is no permission of its own —
access follows the core Media permissions — and the settings live at
**Configuration → Media → Facebook settings**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a Facebook media type and
   choose between Embedded Posts and the oEmbed API mode.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Facebook settings**
(`/admin/config/media/facebook-settings`), gated by the core **Administer
media** permission. Note that the module does not add a "Configure" link on the
Extend/modules page, so navigate via the menu or the path directly. You create
the media type itself under **Structure → Media types**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Create a **Facebook** media type and pick the **Facebook** source — see
   [Configuration](configuration/index.md) for the full walkthrough.
3. Leave the default **Embedded Posts** mode on unless you specifically need
   server-side oEmbed HTML and have a reviewed Facebook app.
4. Add Facebook media by pasting a post/photo/video URL — either at
   *Content → Media → Add media* or directly inside the Media Library modal when
   inserting media into content.
