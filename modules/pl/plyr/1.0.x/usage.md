Plyr renders video and audio through the lightweight [Plyr](https://plyr.io) JavaScript player as Drupal field formatters — for remote (YouTube/Vimeo) oEmbed media and for local audio/video file fields.

---

The module ships three field formatters: `plyr_remote_video` (for `link`/`string`/`string_long` fields on an oEmbed media type, e.g. core Remote video), `plyr_file_video` and `plyr_file_audio` (for `file` fields). The remote-video formatter parses the stored URL with the core oEmbed URL resolver, restricts it to YouTube or Vimeo, extracts the provider and embed id with two regexes, and renders a `plyr_remote_video` theme element carrying `data-plyr-provider`/`data-plyr-embed-id`. The file formatters extend core's `FileMediaFormatterBase` and add `plyr`/`plyr-player` classes. Each formatter has a rich per-instance settings form (autoplay, loop, resetOnEnd, hideControls, a fieldset of Plyr control toggles, and a YouTube `noCookie` option) whose values are compacted into a `#plyr_settings` array, JSON-encoded into a `data-plyr-config` attribute, and read by `js/plyr-player.js`, which calls `Plyr.setup('.plyr-player', …)` with translated i18n labels. The Plyr JS/CSS assets (v3.7.8) load from the Fastly/cdn.plyr.io CDN via the `plyr/plyr` asset library. There is a `plyr.settings` config route (`/admin/config/media/plyr`, permission *administer site configuration*) but its form defines no fields — all real configuration lives on the formatters at *Manage display*.

---

- Play a core Remote video (YouTube/Vimeo) media field through the Plyr player instead of the default oEmbed iframe.
- Add a Plyr audio player to a local audio `file` field.
- Add a Plyr video player to a local video `file` field.
- Toggle individual player controls (play, progress, current time, mute, volume, settings, fullscreen, etc.) per field.
- Show a large centered play button on a hero video.
- Enable autoplay on a background/promo video (with the UX caveat that browsers often block it).
- Loop a short clip continuously.
- Reset playback to the start when a video ends.
- Auto-hide the controls after a couple of seconds of inactivity.
- Add restart / rewind / fast-forward buttons to a tutorial video.
- Show the media duration alongside the progress bar.
- Enable picture-in-picture or AirPlay playback where the browser supports it.
- Use YouTube's privacy-friendly `youtube-nocookie.com` domain for embeds.
- Provide a consistent, accessible player skin across YouTube, Vimeo, and self-hosted files.
- Localize player control labels automatically via Drupal's `Drupal.t()` i18n strings.
- Override player defaults in a custom theme by merging into `plyr_settings` in the Twig template.
- Restrict remote-video playback to YouTube and Vimeo (other providers are silently skipped).
- Serve a lighter alternative to full oEmbed iframes for remote video.
- Add a video/audio player without writing any custom JavaScript.
- Configure separate control sets for different view modes of the same field.
- Show or hide the settings (quality/speed) menu per field instance.
- Present captions controls on videos that ship subtitle tracks.
- Style the player container via the `plyr`/`plyr-player` classes added to each element.
