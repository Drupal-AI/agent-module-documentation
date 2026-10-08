<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Skins, palettes, equalizers, libraries & template overrides

All presentation assets ship inside the module and load as Drupal libraries defined in
`audio_player.libraries.yml`. Nothing is fetched from a CDN and there is no admin-configurable
asset URL.

## Libraries (`audio_player.libraries.yml`)

- `audio_player.base` — `css/base.css` + `js/base.js`; deps `core/jquery`, `core/drupal`,
  `core/drupalSettings`, `core/once`. Always attached.
- `audio_player.skin-one` … `audio_player.skin-eighteen` — single-audio skins; each pairs
  `css/single-audio/skin-N.css` with `js/single-audio/skin-N.js`.
- `audio_player.audio-playlist.skin-one` / `.skin-two` / `.skin_three` — playlist skins.
- `audio_player.equalizer` — `js/equalizer-effects.js` (weight -10), the canvas visualisations.
- `audio_player.color-palettes` / `audio_player.playlist-color-palettes` — palette CSS (weight -10).

Attachment logic lives in the preprocess functions, not the plugins:
`template_preprocess_audio_player()` attaches `base`, then `audio_player.{audio_display}.{skin}`
(or `.{skin}` for single), then `equalizer` if set, then the playlist- or single- palette CSS.

## Option sources (`audio_player.module`)

- `audio_player_single_audio_skins()` — `skin-one`..`skin-eighteen` (18).
- `audio_player_audio_playlist_skins()` — `skin-one`, `skin-two`.
- `audio_player_equalizer_options()` — ~27 entries (`''`=None, `waveform`, `frequency`, `circular`,
  `dots`, `blob`, `soundwave`, … `vortexSpectrum`); these are canvas effect ids read by
  `js/equalizer-effects.js` via a `data-equalizer` attribute.
- `audio_player_palette_options()` — `default-palette` + `palette-1`..`palette-20` (named colour
  schemes); the palette id is emitted as a CSS class on the player wrapper.

## Templates (`templates/`)

- `audio-player.html.twig` — wrapper; `{% include template_part with audios %}`.
- `single-audio/skin-one.html.twig` … `skin-eighteen.html.twig` — single-track markup; an `<audio>`
  element with `src="{{ original_url }}"` and control buttons; wrapper class `{{ palette }}`.
- `audio-playlist/skin-one.html.twig`, `skin-two.html.twig`, `skin-three.html.twig` — playlist
  markup; builds a `playlist` array and renders `data-playlist="{{ playlist|json_encode }}"` plus a
  `<canvas class="audio-player-equalizer-canvas">`; track titles printed via `{{ song.mainTitle }}`
  (Twig-autoescaped, and already `Html::escape`d upstream).
- `views-audio-player.html.twig` — Views style wrapper that assembles `audios` from rows.

## Overriding

Copy any skin template into a theme at the same relative path (e.g.
`{theme}/templates/audio-playlist/skin-one.html.twig`). Both formatters and the Views preprocess
check `file_exists` on the theme path first and prefer `@{theme}/...` over `@audio_player/...`.
Restyle with CSS targeting the `audio-player*` class names; define custom palettes by adding CSS
classes matching a chosen palette id.
