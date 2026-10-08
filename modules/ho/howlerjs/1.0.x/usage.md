<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Howler.js provides the Howler audio library to Drupal as an asset library, for code that needs programmatic control over sound.

---

The HTML `<audio>` element covers the ordinary case — one file, browser controls, play it — and stops there. Anything more needs a library: several sounds layered or crossfaded, a sprite where one file holds many short clips addressed by offset, playback rate control, spatial positioning, or reliable behaviour across the browsers' quite different autoplay policies and codec support. Howler is the established answer, and its notable characteristic is falling back from the Web Audio API to HTML5 Audio automatically, so code written once works where Web Audio is unavailable or restricted. This module makes it available as a Drupal asset library, version **1.0.2** on `^8` through `^11`, no dependencies, no configuration — the same shape as `vuejs` and `sweetalert2` documented earlier: it declares the library and does nothing until other code attaches it. Two points. **Autoplay is blocked by every current browser** without a user gesture, and that is not a bug to work around but a deliberate protection — audio that starts on page load is one of the most disliked things a site can do, and on a site with an accessibility obligation it is a WCAG failure unless it can be stopped within three seconds. And **audio content needs a text alternative** exactly as video does, so a site publishing spoken material owes a transcript regardless of how sophisticated the player is.

---

- Play layered sounds in a web application.
- Build an audio sprite for short clips.
- Control playback rate from JavaScript.
- Crossfade between tracks.
- Add reliable audio across browsers.
- Play sound in an interactive exhibit.
- Build a pronunciation guide.
- Add audio feedback to an interface.
- Play a sound effect on an event.
- Build a language-learning tool.
- Control audio from a custom module.
- Add spatial audio to a visualisation.
- Handle autoplay restrictions properly.
- Build an audio-guided tour.
- Play a sequence of clips.
- Add audio to a game-like feature.
- Provide a shared audio library.
- Build a custom audio player.
