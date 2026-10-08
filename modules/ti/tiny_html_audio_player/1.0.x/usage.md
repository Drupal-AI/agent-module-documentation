<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
tiny-player HTML audio player renders a file field's audio as a compact custom player built on the Howler JavaScript library.

---

The module adds a single field formatter, **tiny-player HTML audio player**, to any **file** field that holds audio. To use it, add or reuse a file field (for example on an article or a media type), then on the entity's **Manage display** tab pick that formatter for the field; its settings — **show controls**, **autoplay** and **loop** — map straight onto the emitted `<audio>` element, and a multiple-files option controls whether several uploads render as separate players or one player with multiple sources. Rendering is entirely client-side enhancement: the formatter outputs an `<audio class="iru-tiny-player"><source></audio>` block and attaches `js/tinyPlayer.js`, which drives playback through **Howler** (the required `howlerjs` module), the sensible engine because it abstracts the Web Audio API with an HTML5 Audio fallback and smooths over the browsers' different autoplay and codec behaviour. The player library (MIT-licensed) is bundled with the module, and Font Awesome supplies the control icons — installed from a CDN by default, or served locally if you add the suggested `fontawesome` module. There is no settings page, permission or route: everything is per-field on Manage display. Because a custom player replaces a native control, check the three things a native `<audio>` gave for free — **keyboard operation** (play/pause and seek without a mouse), **screen-reader state** (the play control's accessible name should change with state), and **a transcript**, which is a WCAG requirement for prerecorded audio and also the only way the spoken content becomes searchable. Version **1.0.4**, core `^9.3 || ^10 || ^11`.

---

- Play a podcast episode from a file field.
- Add a compact audio player to a content type.
- Enable the player on an article's audio upload.
- Publish an oral-history recording.
- Play a language course's audio clips.
- Add a music-sample player to a page.
- Match an audio player to the site's design.
- Show playback controls, autoplay or loop per field.
- Render multiple audio uploads as separate players.
- Play an interview recording.
- Add audio to an article body's attachment field.
- Publish a lecture recording.
- Play a pronunciation clip.
- Get a consistent player look across browsers.
- Publish an audio guide or walking tour.
- Play a radio-programme archive item.
- Add audio to a portfolio entry.
- Publish a recorded reading or audiobook chapter.
- Play a meditation or ambient track.
- Publish a conference-session recording.
- Serve the player icons locally by adding Font Awesome.
