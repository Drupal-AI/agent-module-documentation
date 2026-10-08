AmplitudeJS registers the AmplitudeJS HTML5 audio library as a Drupal asset library and ships an optional submodule of ready-made audio-player field formatters.

---

The base `amplitudejs` module does one thing: it declares the third-party AmplitudeJS JavaScript library (521dimensions/amplitudejs 5.3.2), expected on disk at `/libraries/amplitudejs/dist/amplitude.min.js`, as a Drupal library so any theme or custom code can attach it. It provides no UI, routes, or permissions of its own — only a `hook_help` page that renders the README. The bundled `amplitudejs_formatters` submodule builds on it, adding seven field formatters (ported from the official AmplitudeJS example players — Single Song, Multiple Songs, Blue/White/Flat Black/Simple Black Playlists, and a Visualization Player) that render entity-reference (media) or file fields as styled audio players. Formatter settings map token patterns (via the required `token` module) to the player's audio URL, title, artist, album, and album-art fields, so editors point each player slot at the right field without code. The module targets Media/audio display; audio and image files continue to follow core media/file access, and it grants no content or access capability.

---

- Register AmplitudeJS 5.3.2 as a reusable Drupal asset library.
- Attach the AmplitudeJS library to a custom theme or module for a hand-built player.
- Build a fully custom AmplitudeJS player without enabling the formatters submodule.
- Enable `amplitudejs_formatters` to get drop-in audio players as field formatters.
- Render a core Audio media reference field as a Single Song Player.
- Display a multi-item media/file field as a Multiple Songs list player.
- Present a media playlist with the Blue Playlist themed player.
- Present a playlist with the White Playlist (slide-in list) player.
- Present a playlist with the Flat Black Playlist (slide-down list) player.
- Present a compact playlist with the Simple Black Playlist player.
- Show a now-playing player with an audio Visualization Player.
- Play a single MP3 uploaded to a core file field using `[file:url]`.
- Use `[media:name]` (or a dedicated text field) as each track's title.
- Map an artist text field to the player's artist line via a token.
- Map an album text field to the player's album line via a token.
- Show album art from an image field, optionally through an image style, via a token URL.
- Add several player formatters on one page (only one plays at a time, per library limits).
- Extend the media `audio` type with name/artist/album/album-art fields feeding the players.
- Let editors browse available replacement tokens in the formatter settings form.
- Keep audio playback keyboard-accessible (spacebar toggles the active player).
- Serve audio players whose access is governed by the underlying media/file field access.
- Fall back to a bundled transparent placeholder image when no album art is set (Multiple Songs, Simple Black Playlist).
- Provide a base for developing new AmplitudeJS-based formatters by extending `PlayerBase`.
