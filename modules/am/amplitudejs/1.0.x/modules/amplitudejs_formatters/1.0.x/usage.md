AmplitudeJS Formatters adds seven audio-player field formatters that render media or file audio fields as themed AmplitudeJS players.

---

This submodule of the AmplitudeJS project ports the official AmplitudeJS example players into Drupal field formatters. Each formatter (Single Song Player, Multiple Songs, Blue Playlist, White Playlist, Flat Black Playlist, Simple Black Playlist, Visualization Player) applies to entity-reference (typically core Media) fields and to core file fields. In the formatter settings you supply token replacement patterns — the audio-file URL, title, artist, album, and album-art URL — which the plugin resolves per referenced entity, sanitizes, and hands to the AmplitudeJS JavaScript through `drupalSettings`; a Twig template renders the player markup and a shared init script boots each player on the page. It requires core file + media, the contrib token module, and the base amplitudejs module (for the library asset). It defines no routes, permissions, services, or config entities; players inherit the access of the underlying media/file fields.

---

- Turn a core Audio media reference field into a single-track player (Single Song Player).
- Render a multi-value media/file field as a scrollable track list (Multiple Songs).
- Display a media playlist with the Blue Playlist themed skin.
- Display a media playlist with the White Playlist slide-in list skin.
- Display a media playlist with the Flat Black Playlist slide-down list skin.
- Display a compact media playlist with the Simple Black Playlist skin.
- Show a now-playing player with an audio Visualization Player.
- Play a single uploaded MP3 on a core file field using `[file:url]` as the audio source.
- Play multiple MP3s from one multi-value file field in a list player.
- Use `[media:name]` as each track's displayed title.
- Point the title at a dedicated song-name text field via its token.
- Populate the artist line from an artist text field token.
- Populate the album line from an album text field token.
- Show original-size album art from an image field via `[media:field_image:entity:url]`.
- Show image-styled album art via `[media:field_image:STYLE:url]`.
- Add song title/artist/album/art fields to the core `audio` media type to feed the players.
- Place several player formatters on the same page (one plays at a time by design).
- Let editors browse tokens for the referenced entity and the parent entity in the settings form.
- Fall back to a bundled transparent 1×1 placeholder when album art is empty (Multiple Songs, Simple Black Playlist).
- Keep spacebar play/pause working for the active player without breaking form inputs.
- Provide `PlayerBase` as an extension point for building a new AmplitudeJS formatter skin.
