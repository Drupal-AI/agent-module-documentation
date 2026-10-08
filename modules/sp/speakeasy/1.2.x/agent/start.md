<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Speakeasy (speakeasy) — agent index

Text-to-speech that reads page content aloud using the **browser's Speech Synthesis API**
(client-side; no server calls, no external service). Version **1.2.1**, dir `1.2.x`.
Core `^9 || ^10 || ^11`, PHP 8.0, package "Web services". No module or composer dependencies.

## What it provides
- **Block plugin** `speakeasy_block` (`src/Plugin/Block/SpeakeasyBlock.php`) — compiles plain
  text from a node's text fields and renders playback controls in one of three output styles
  (`simple_link`, `media_player`, `default`). Block access requires `access content`.
- **Config form** `SpeakeasySettingsForm` (route `speakeasy.settings`, `/admin/config/speakeasy`,
  permission `administer speakeasy settings`) — global defaults, per-browser voice whitelist,
  language filter, theme, default speed, feature toggles.
- **User form** `SpeakeasyUserPreferencesForm` (route `speakeasy.user_preferences`,
  `/user/speakeasy/preferences`, permission `manage speakeasy user preferences`) — per-user
  voice + speed stored in the `user.data` store.
- **Config object** `speakeasy.settings` (schema `config/schema/speakeasy.schema.yml`).
- **Theme hook** `speakeasy_media_player` (template `templates/speakeasy-media-player.html.twig`).
- **Permissions**: `administer speakeasy settings`, `manage speakeasy user preferences`.
- **JS libraries** (browser-only): `speakeasy` (tts), `.voice`, `.highlight`, `.bus`,
  `.constants`, `.utils`, `.user_preferences`, `.admin`; CSS themes `speakeasy_theme_default`,
  `speakeasy_theme_olivero`.
- No entities, no services.yml, no Drush commands, no submodules, no external HTTP.

## Solution docs
- [config/settings.md](config/settings.md) — the `speakeasy.settings` config object, schema keys,
  the settings form, routes, and permissions.
- [blocks/speakeasy-block.md](blocks/speakeasy-block.md) — the `speakeasy_block` plugin: content
  compilation, output styles, block-config options, per-user preferences, drupalSettings payload.
