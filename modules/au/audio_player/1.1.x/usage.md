<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audio Player renders core File fields or Media (audio) references as a themeable HTML5 player, with skins, playlists, colour palettes and an equalizer display, plus a Views style for building playlists from a view.

---

The browser's native `<audio>` element works but is unstyleable and looks different in every browser. For a music site, a podcast, an oral-history archive or a language-learning resource the player is part of the presentation, and a consistent, themeable one is worth having.

This module provides that as two field formatters ("Audio Player" for File fields, "Media Audio Player" for Media entity-reference fields) plus a Views style plugin ("Audio Player") that turns view rows into a playlist. A single-cardinality field plays as one track; a multi-value field can play as a looped single or as a playlist. Presentation is chosen per display: 18 single-audio skins, 2-3 playlist skins, ~20 colour palettes and ~27 canvas equalizer visualisations, all overridable by copying the module's Twig templates into a theme. The player JavaScript and CSS are bundled with the module and loaded as Drupal libraries per selected skin — nothing is fetched from a CDN.

Each track is resolved from its managed-file URI, and the formatters call `$file->access('view')` before emitting a URL, so private-file protection is honoured. Track titles are derived from the filename (or a chosen view field), cleaned and HTML-escaped.

Two things belong in any audio-player deployment. **Keyboard and screen-reader access** — a custom player can lose what the native element gives for free, so check that play, pause, seek and volume are reachable by keyboard and labelled. And **a transcript is not optional** for spoken-word audio on a site with accessibility obligations; the player does not provide one, so the content model has to. Practical note: audio files are large and served from the site, so plan hosting for a substantial archive.

---

- Play a single audio file with a themeable player instead of the browser default.
- Present a podcast episode on a content type.
- Play a set of uploaded files as a looped single track.
- Play a multi-value audio field as a playlist.
- Build a site-wide playlist from a View of audio content.
- Attach an audio player to a File field on any entity (node, block, paragraph).
- Attach a player to a Media reference field using the audio media bundle.
- Choose from 18 single-audio skins per display.
- Choose from the playlist skins for multi-track displays.
- Apply one of ~20 named colour palettes to the player.
- Add a canvas equalizer visualisation (waveform, frequency, circular, etc.).
- Map a view field to the playlist track title and subtitle.
- Map a view field to the audio source and thumbnail.
- Override a skin's Twig template by copying it into a theme.
- Restyle the player with custom CSS targeting the `audio-player` classes.
- Serve an oral-history or spoken-word archive with a consistent player.
- Support language-learning audio with per-track playback controls.
- Respect private-file access when displaying restricted audio.
- Provide a transcript field alongside the audio in the content model.
- Check keyboard and screen-reader operation of the custom controls.
- Plan file hosting for large audio libraries served from the site.
