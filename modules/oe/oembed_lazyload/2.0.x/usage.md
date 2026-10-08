<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
oEmbed lazy load defers loading of embedded third-party media (YouTube, Vimeo, etc.) until the visitor needs it — either when the embed scrolls into view or when they click a play button — replacing the heavy provider iframe with a lightweight thumbnail placeholder until then. It ships a field formatter for oEmbed/link fields and a pluggable per-provider enhancer system.

---

The core of the module is the `lazyload_oembed` field formatter ("Lazy load oEmbed video"), usable on `link`, `string` and `string_long` fields that hold an oEmbed resource URL. Instead of printing the provider iframe immediately, it resolves the oEmbed resource, renders a placeholder (provider name, title, thumbnail) via Twig templates, and only swaps in the real iframe according to a **strategy**: `intersection_observer` (load when it enters the viewport, with an optional root `intersection_observer_margin`) or `onclick` (load when the user activates a play button). The formatter also has `max_width` / `max_height` settings. The actual iframe is served through a module route guarded by an access check (`IframeUrlHelper` signs a hash so only legitimate placeholder-generated URLs resolve). Per-provider behaviour is customised through a **ProviderEnhancer** plugin type (manager service `oembed_lazyload`, plugins in `Plugin/oembed_lazyload/ProviderEnhancer`): each enhancer declares which providers it handles and can add libraries, tweak the placeholder, alter the iframe URL and change the oEmbed markup; a `fallback` enhancer handles any provider without a specific one. Theming is fully overridable — `oembed_lazyload`, `oembed_lazyload_placeholder` and `oembed_lazyload_help` theme hooks plus per-provider template suggestions (`oembed_lazyload__<provider>`), and CSS/JS libraries (`common`, `onclick`, `intersection-observer`). There is no global settings page; configuration lives entirely in the formatter on a view display. The `oembed_lazyload_youtube` submodule adds a YouTube-specific enhancer with player options. Requires core `media`.

---

- Lazy-load a YouTube video embedded in a field until it scrolls into view.
- Defer loading of an embedded video until the visitor clicks the play button (onclick strategy).
- Replace a heavy provider iframe with a lightweight thumbnail placeholder to speed up page load.
- Improve Core Web Vitals / Lighthouse scores on pages with many embedded videos.
- Reduce third-party requests and cookies until the user actually engages with a video.
- Configure a maximum width/height for the embedded oEmbed resource.
- Start loading an embed slightly before it enters the viewport via an intersection-observer margin.
- Apply the `lazyload_oembed` formatter to a link field storing a video URL.
- Apply the formatter to a plain text field that holds an oEmbed URL.
- Serve the provider iframe through a signed, access-checked route rather than inline.
- Add a per-provider enhancer to customise how a given provider's embeds are lazy-loaded.
- Provide YouTube player options (autoplay, modest branding, rel) via the YouTube submodule.
- Override the placeholder markup per provider with a template suggestion.
- Theme the placeholder (thumbnail, title, provider label) to match the site design.
- Fall back to a generic enhancer for providers without a dedicated one.
- Keep embedded media GDPR-friendlier by not contacting the provider until engagement.
- Reduce layout shift by rendering a sized placeholder before the iframe loads.
- Lazy-load Vimeo or other oEmbed provider content the same way as YouTube.
- Attach custom CSS/JS libraries only when a particular provider's embed is present.
- Use on media/entity reference display where the oEmbed URL is exposed as a field.
