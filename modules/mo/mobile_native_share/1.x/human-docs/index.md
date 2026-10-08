# Mobile Native Share — manual setup guide

**Mobile Native Share** (`mobile_native_share`) adds a native "share" button to
your Drupal entities. On supported browsers it uses the **Web Share API** to open
the device's own share sheet — the familiar system dialog that lets a visitor send
a page to Messages, WhatsApp, email, and so on — which is the expected way to share
on mobile. Where the Web Share API isn't available, it degrades gracefully, falling
back to the Clipboard API or a prompt dialog. It only ever shares the current
page's URL and title; nothing sensitive is exposed. (The Web Share API requires
HTTPS and a user gesture to fire.)

Out of the box it works with **nodes, taxonomy terms and comments**, and can be
extended to other entity types (paragraphs, custom entities) by developers via a
hook. You choose which entity types and bundles show the button, set a title and
description per bundle (with token support for dynamic values), and pick a global
icon and style. It also exposes a rendering service so developers can output the
share button programmatically in custom blocks, controllers or routes, and provides
theme suggestions per entity type and bundle for easy template overrides.

The module has a straightforward settings screen but no secrets, credentials or
external services — it is a purely front-end feature with no security surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The settings are simple enough to cover here rather than in a separate chapter —
see "How to use it" below.

## Where it lives in the admin menu

After enabling, the settings live at **Configuration → Search and metadata →
Mobile Native Share** (`/admin/config/search/mobile-native-share`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **`/admin/config/search/mobile-native-share`**.
3. **Enable the share button** for the entity types and bundles you want (nodes,
   taxonomy terms, comments, and any others you've extended it to).
4. **Configure the display** — set a **Title** and **Description** per entity/bundle
   (both support tokens for dynamic values), and choose the global **Icon** and
   **Style**.
5. **Choose where it appears** by adjusting the display modes so the share button
   shows in the right place on those entities.
6. Save, then view one of those entities on an HTTPS URL and tap the share button —
   on a supported mobile browser the native share sheet opens; elsewhere it falls
   back to copy-to-clipboard or a prompt.
