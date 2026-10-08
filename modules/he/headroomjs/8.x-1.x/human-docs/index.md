# Headroom.js — manual setup guide

**Headroom.js** (`headroomjs`) integrates the lightweight
[Headroom.js](https://github.com/WickyNilliams/headroom.js) JavaScript widget
into Drupal. Headroom.js reacts to the direction you scroll: it **hides** an
element (typically a sticky header or menu) when you scroll **down**, and
**reveals** it again when you scroll **up**. The result is a fixed header that
stays out of the way while you read, then reappears the instant you need to
navigate — freeing screen space without sacrificing quick access to the menu.

Fixed headers are popular because they keep navigation close, but they eat into
the content area — especially on landscape desktop screens and small portrait
phones. Headroom.js is the compromise: navigation when you want it, content the
rest of the time.

Two practical notes worth knowing up front. First, the JavaScript library is
**not** bundled with the module — you download it into your site's `libraries`
directory yourself (see [Installation](installation/index.md)). Second, the
module ships **no CSS**: you decide which element Headroom.js attaches to and you
write the positioning/display styles for the classes it toggles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the Headroom.js library, and enable it.
2. [Configuration](configuration/index.md) — pointing it at your header/menu
   element and tuning the scroll behaviour.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → System → Headroom.js**
(`/admin/config/system/headroomjs`), where you choose which element to apply the
behaviour to and set the scroll options. See
[Configuration](configuration/index.md).
