# Howler.js — manual setup guide

**Howler.js** (`howlerjs`) makes the
[Howler](https://howlerjs.com/) audio library available to Drupal as an **asset
library**. Howler is the established JavaScript library for working with sound on
the web, and its notable feature is falling back from the Web Audio API to HTML5
Audio automatically — so code written once works reliably across browsers with
their quite different autoplay policies and codec support.

The plain HTML `<audio>` element handles the ordinary case — one file, browser
controls, press play — and stops there. Howler is what you reach for when you need
more: several sounds layered or crossfaded, an **audio sprite** (one file holding
many short clips addressed by offset), playback‑rate control, or spatial
positioning. This module simply **declares the library** so that other code (a
custom module, a theme, or another module that depends on it) can attach it. It
adds no players, no configuration, no permissions, and no admin pages of its own —
on its own it does nothing visible until some code uses it.

Because of that, this is a building block for developers, or a dependency pulled in
by a player module such as *Tiny HTML Audio player*. To actually play something you
either write JavaScript that uses Howler, or install a module that does.

> **Two things worth keeping in mind whenever you add audio:**
>
> 1. **Autoplay is blocked by every current browser** without a user gesture. That's
>    a deliberate protection, not a bug to work around — audio that starts on page
>    load is one of the most disliked things a site can do, and it's an
>    accessibility (WCAG) failure unless the visitor can stop it within three
>    seconds.
> 2. **Audio content needs a text alternative**, exactly as video does. If you
>    publish spoken material, provide a transcript regardless of how capable the
>    player is.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it declares the Howler asset
library and nothing more. Attaching and using the library happens in code.

## Where it lives in the admin menu

Howler.js adds no admin page and has no settings. Once enabled, the library is
available to be attached by any code that needs it — for example
`$build['#attached']['library'][] = 'howlerjs/howler';` in a render array, or a
`libraries[]` dependency from your theme or module — after which you write
JavaScript against the global `Howl` API that Howler provides.
