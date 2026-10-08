<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
oEmbed lazy load YouTube enhancer is a submodule of oEmbed lazy load that adds a YouTube-specific ProviderEnhancer plus YouTube player options (autoplay, modest branding, IFrame API, related-videos behaviour) to the lazy-load oEmbed formatter.

---

The submodule registers a `ProviderEnhancer` plugin (`youtube`, matching the "YouTube" provider) that extends `ProviderEnhancerBase`: it parses the video/playlist/shorts id out of a YouTube URL, attaches a YouTube-specific JS library, tailors the placeholder (adding the parsed `embed_code`), and rewrites the embedded iframe URL with YouTube player parameters. Those parameters are exposed as **third-party settings** on the `lazyload_oembed` field formatter via `hook_field_formatter_third_party_settings_form()`, so on a field's *Manage display* (when the Lazy load oEmbed formatter is selected) a "YouTube settings" section appears with checkboxes: **autoplay**, **modestbranding** (hide the YouTube logo), **enablejsapi** (allow control via the YouTube IFrame API), **origin** (restrict IFrame API to the oEmbed iframe host — only relevant with enablejsapi), **hideinfo** (deprecated) and **rel** (only show related videos from the same channel). They are stored under the formatter component's `third_party_settings.oembed_lazyload_youtube.*` and applied by the enhancer's `alterOembedResponse()` when it builds the iframe URL. The submodule also adds a `oembed_lazyload_placeholder__youtube` template suggestion and a settings-summary theme hook. It adds no permission, route, service or config entity of its own. Requires `oembed_lazyload`.

---

- Autoplay a lazy-loaded YouTube video once the visitor triggers it.
- Hide the YouTube logo on the player using the modest-branding option.
- Restrict a YouTube embed's related videos to the same channel (`rel`).
- Enable the YouTube IFrame API so JavaScript can control the player.
- Lock IFrame API access to the oEmbed iframe host for safety (`origin`).
- Configure YouTube player options per field from Manage display.
- Parse the video id from watch, youtu.be, /v/, playlist and shorts URLs automatically.
- Attach a YouTube-specific JS library only when a YouTube embed is present.
- Override the YouTube placeholder markup via the `oembed_lazyload_placeholder__youtube` suggestion.
- Provide a designed, branded YouTube placeholder while deferring the real player.
- Combine autoplay with the parent's onclick strategy so the video plays on click.
- Keep YouTube's heavy player deferred until engagement while still theming the thumbnail.
- Store YouTube options as formatter third-party settings for config export/deploy.
- Serve as a reference ProviderEnhancer implementation for other providers.
- Present cleaner, less-branded YouTube embeds to match site design.
- Reduce distraction by hiding related videos from other channels.
- Support YouTube Shorts and playlist URLs in the lazy-load formatter.
- Apply different YouTube options per view mode via separate view displays.
