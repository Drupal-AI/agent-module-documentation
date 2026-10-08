Swaps Drupal's proxied `/media/oembed` iframe for the oEmbed provider's own returned HTML markup, per field display.

---

Media oEmbed Provider Markup is a small, no-configuration helper for core Media's `oembed` field formatter. Core renders remote oEmbed media (YouTube, Vimeo, etc.) inside a Drupal-served `<iframe src="/media/oembed?url=…">` proxy so third-party HTML runs in an isolated frame. That rewritten URL, however, is invisible to Consent Management Platforms (CMPs) and cookie-blockers, which look for the real provider domain, and the extra frame can interfere with responsive sizing or provider scripts. This module adds a per-display checkbox — "Use provider's markup for oEmbed field" — as a third-party setting on the core `oembed` formatter. When enabled, a `hook_preprocess_field()` implementation re-resolves the media through core's `media.oembed.url_resolver` and `media.oembed.resource_fetcher` services and outputs the provider's own `<iframe>`/embed HTML (e.g. `youtube.com/embed/…`) instead of the Drupal proxy URL, so CMPs recognise and can gate the source. It ships no routes, permissions, services, entities, or admin settings pages — configuration lives entirely in each view display's field formatter settings, and a `hook_alter` (`hook_media_oembed_provider_markup_alter`) lets other modules post-process the emitted HTML string.

---

- Make YouTube/Vimeo embeds show the real provider iframe URL so a Consent Management Platform can detect and block them until consent is given.
- Restore provider-native embed markup that a cookie/consent scanner expects, instead of the opaque `/media/oembed` proxy URL.
- Comply with GDPR/e-privacy consent workflows that must identify each external source before it loads.
- Let a CMP (e.g. Cookiebot, Usercentrics, Borlabs) auto-block third-party video until the visitor opts in.
- Fix responsive-sizing issues caused by core's nested iframe by emitting the provider's own responsive embed code.
- Allow provider embed scripts that expect to run in the provider's own frame context to load correctly.
- Enable provider markup on a single view mode (e.g. "full") while leaving other view modes on core's proxied iframe.
- Toggle provider markup per field display without touching global media or oEmbed settings.
- Keep using standard core Remote video media types and the `oembed` formatter — no new field types or media sources.
- Present the original provider embed for SEO/analytics tools that key off the provider domain.
- Provide the raw provider iframe so a custom lazy-loader or facade script can wrap it.
- Post-process the emitted embed HTML from a custom module via `hook_media_oembed_provider_markup_alter()` (e.g. add `loading="lazy"`, tweak the allow attributes, or inject a placeholder).
- Add `data-*` or consent-manager attributes to provider iframes in a custom alter hook.
- Swap in a click-to-load facade by rewriting the provider HTML in the alter hook.
- Support editorial teams who paste standard YouTube/Vimeo URLs into Remote video media but need the native embed on the front end.
- Migrate an existing site from core's proxied oEmbed to provider markup one display at a time.
- Combine with a CMP module so blocked embeds display a consent placeholder keyed on the provider host.
- Serve provider markup on marketing/landing pages where CMP compatibility is required, while admin pages keep the proxy.
- Reduce one server round-trip per embed (no `/media/oembed` sub-request) on pages with many videos.
- Keep the module dormant until explicitly enabled per display — installing it changes nothing on its own.
- Roll back instantly by unchecking the display setting, reverting to core's proxied iframe.
