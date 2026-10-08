# Media oEmbed Control — agent index

Extends core Media's `oembed` field formatter with **Autoplay** and **Background video**
options for YouTube/Vimeo. No admin page (`configure` null), no permissions, no schema,
no Drush. Requires core **Media** (used, though not declared in info.yml). Configured on a
field's *Manage display* → oEmbed formatter settings.

- **The two formatter settings, the hooks that add them, and the iframe-rewrite request
  flow (route override + query params)** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Third-party settings on the `oembed` formatter: `video_autoplay`, `video_background`
  (namespace `media_oembed_control`), added in `media_oembed_control.module`.
- Route subscriber replaces the `media.oembed_iframe` controller with
  `OEmbedIframeController` (extends core; calls `parent::render()` so the `hash` check runs).
- Only providers `YouTube` and `Vimeo` are rewritten; others pass through unchanged.
- YouTube always gets `enablejsapi=1`; autoplay forces `mute`; background sets
  `controls=0&loop=1` + self-playlist. Vimeo autoplay/background set `autoplay`/`background=1`.
