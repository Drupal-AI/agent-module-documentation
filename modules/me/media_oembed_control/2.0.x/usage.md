Media oEmbed Control adds per-display "Autoplay video" and "Embed as background video" options to core Media's oEmbed field formatter (YouTube and Vimeo), injecting the right provider query parameters into the embedded iframe.

---

Core Media renders remote video via an oEmbed field formatter that outputs a sandboxed iframe pointing at the internal `media.oembed_iframe` route, but it gives no control over playback options. This module adds two third-party settings — `video_autoplay` and `video_background` — to the core `oembed` field formatter through `hook_field_formatter_third_party_settings_form()` (with a summary via `hook_field_formatter_settings_summary_alter()`). When such a field is rendered, `hook_preprocess_field()` appends a `media_oembed_control` payload (provider name + the chosen settings) to the iframe's `src` query string. A route subscriber (`MediaOembedControlRouteSubscriber`) swaps the `media.oembed_iframe` controller for the module's `OEmbedIframeController`, which extends core's controller, calls the parent (so core's `hash` signature check still runs and still throws `AccessDeniedHttpException` on mismatch), then rewrites the resulting YouTube/Vimeo iframe URL: enabling `autoplay` (+`mute` on YouTube), or background mode (`background=1`, and on YouTube `controls=0`, `loop=1`, a `playlist` self-reference). It also always adds `enablejsapi=1` for YouTube. There is no admin settings page, no permission, and no config schema — everything is configured on a field's *Manage display* formatter settings. Only YouTube and Vimeo are handled; other providers are left untouched.

---

- Autoplay a YouTube or Vimeo video embedded via core Media oEmbed on a specific display.
- Autoplay a video muted (YouTube autoplay is forced muted to satisfy browser autoplay policies).
- Embed a video as a silent, looping, control-less background video (hero banners).
- Configure autoplay/background per view mode (e.g. teaser vs full) via *Manage display*.
- Add playback options to a remote video without switching away from core Media oEmbed.
- Enable the YouTube JS API (`enablejsapi`) on embeds for custom player scripting.
- Loop a background YouTube video automatically using its own ID as the playlist.
- Give editors a checkbox-driven autoplay toggle instead of hand-editing embed URLs.
- Keep core Media's signed-iframe security (`hash` check) while still customising playback.
- Show the active oEmbed control options in the formatter settings summary.
- Provide different autoplay behaviour for the same media field across multiple displays.
- Build an autoplaying video carousel from Media entities rendered through the oEmbed formatter.
- Leave non-YouTube/Vimeo oEmbed providers rendered exactly as core does (no unexpected changes).
- Clear the extra settings automatically by unchecking both options (kept out of stored config).
- Add a muted, looping YouTube background to a landing page without a custom video field.
- Set up a hero section where a Vimeo clip plays as an ambient background loop.
- Toggle autoplay on or off for editorial vs marketing displays of the same media.

