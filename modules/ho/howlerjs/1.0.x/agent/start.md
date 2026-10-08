<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Howler.js (howlerjs) — agent index

Provides the **Howler** audio library as a Drupal asset library. No dependencies, no routes, no
permissions, no configuration, no config schema — it declares the library and does nothing until
other code attaches it. Same shape as `vuejs` (wave 70) and `sweetalert2` (wave 60). Version
**1.0.2**. Core requirement `^8 || ^9 || ^10 || ^11`.

## What it actually ships

Three asset libraries in `howlerjs.libraries.yml`, wrapping **howler.js 2.2.3** (MIT):

| Library id | File loaded | Notes |
|---|---|---|
| `howlerjs/howler` | `howler.min.js` | Full build (core + spatial). |
| `howlerjs/howler.core` | `howler.core.min.js` | Core only, smaller. |
| `howlerjs/howler.spatial` | `howler.spatial.min.js` | Spatial/3D plugin; `dependencies: howlerjs/howler.core`. |

By **default the JS is loaded from the jsDelivr CDN** (`//cdn.jsdelivr.net/npm/howler@2.2.3/dist/...`,
declared `type: external`). `howlerjs.module` implements **`hook_library_info_alter()`**: if a matching
file is found under `/libraries/howlerjs/` (via the `library.libraries_directory_file_finder`
service), it swaps the CDN URL for the local path. So you get CDN out of the box and self-hosting for
free by dropping the files into the libraries directory — no configuration either way.

There is **no PHP API, formatter, block, or widget** here. Attaching the library and driving the
`Howler` global is the integrating code's job. See `agent/api/attach-library.md`.

## What `<audio>` cannot do, and Howler can

Layered or crossfaded sounds, **audio sprites** (one file holding many short clips addressed by
offset), playback-rate control, spatial positioning, and consistent behaviour across browsers' quite
different autoplay policies and codec support. Its notable characteristic is falling back from **Web
Audio API to HTML5 Audio automatically**.

## Two points to raise whenever audio comes up

1. **Autoplay is blocked by every current browser** without a user gesture — a deliberate
   protection, not a bug to work around. Audio starting on page load is among the most disliked
   things a site can do, and it is a **WCAG failure** unless it can be stopped within three seconds.
2. **Audio content needs a text alternative** exactly as video does. A site publishing spoken
   material owes a **transcript**, however sophisticated the player.

## Files

- `agent/api/attach-library.md` — how to attach the library and self-host locally.
