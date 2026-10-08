<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Player (audio_player) — agent index

Renders core **File** fields and **Media** (audio bundle) references as a themeable HTML5 audio
player — skins, playlists, colour palettes, canvas equalizers. Also ships a **Views style** to build
a playlist from view rows. Package `Audio Player`. Core `^10 || ^11`. Version 1.1.4.
Dependencies: `image`, `field`, `media`.

All player CSS/JS is **bundled with the module** and loaded as per-skin Drupal libraries — no CDN,
no external library, no admin-configurable script URL. No routes, no controllers, no permissions,
no services, no config entities, no config schema, no Drush, no submodules, no `composer.json`.

## What it provides

- **`AudioPlayerFieldFormatter`** (id `audio_player_field_formatter`, label *"Audio Player"*) —
  field formatter for `file`/`string`/`link` fields, extends `FileFormatterBase`.
- **`AudioPlayerMediaFieldFormatter`** (id `audio_player_mfield_formatter`, label *"Media Audio
  Player"*) — formatter for `entity_reference` fields, extends `EntityReferenceFormatterBase`,
  only renders referenced media of bundle `audio`.
- **`ViewsAudioPlayer`** (id `audio_player`, label *"Audio Player"*) — Views style plugin
  (`StylePluginBase`) mapping view fields (title, subtitle, source, thumbnail) to a playlist.
- Theme hooks `audio_player` and `views_audio_player`; many Twig templates under `templates/`.
- Helper functions in `audio_player.module`: skin/equalizer/palette option lists and
  `audio_player_generate_name()` (filename cleanup + `Html::escape`).

## Solution docs

- **The two field formatters — settings, mechanism, how a track URL is resolved** →
  [fields/formatter.md](fields/formatter.md)
- **The Views style playlist plugin + preprocessing** → [plugins/views-style.md](plugins/views-style.md)
- **Skins, palettes, equalizers, libraries and Twig template overrides** →
  [theming/skins-and-libraries.md](theming/skins-and-libraries.md)
