<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Embera bundles the mpratt/embera PHP oEmbed library and exposes it to Drupal through a single service, `embera.manager`.

---

Embera (Library) is a thin, developer-facing wrapper: installing it pulls the mpratt/embera PHP library into `/vendor/` and registers one Drupal service, `embera.manager` (class `Drupal\embera\EmberaServiceManager`). That service turns a supported media URL (YouTube, Vimeo, Twitter and the other providers the library knows) into oEmbed data — full embed HTML, a thumbnail URL, or a title — and caches provider responses both on disk (Embera's filesystem HTTP cache, in the temp directory) and statically within a single request. It ships no content types, fields, blocks, routes, permissions, or admin form; its behaviour is tuned only through `Settings` values (`embera.class.configuration`, `embera.file_cache.duration`, `embera.file.cache.disabled`). It is meant to be used by other modules that need oEmbed conversion, not installed on its own by site builders.

---

- Add oEmbed support to a custom module by depending on `embera` and calling `embera.manager`.
- Convert a pasted YouTube URL into its responsive embed HTML with `getEmbedCode()`.
- Convert a Vimeo URL into embed markup for a custom render array.
- Fetch a video's thumbnail image URL with `getThumbnailUrl()` to build a poster/preview.
- Retrieve a media item's title with `getTitle()` for automatic labelling.
- Pull the full oEmbed response array with `getEmbedInformation()` for custom rendering.
- Back a custom field formatter that renders embeds from a stored link value.
- Back a custom media source or field widget that previews an entered media URL.
- Provide the library dependency another contrib module declares as a requirement.
- Cache provider oEmbed responses on disk to avoid repeated HTTP calls across requests.
- Tune how long provider responses are cached by setting `embera.file_cache.duration`.
- Disable disk caching entirely for debugging by setting `embera.file.cache.disabled` to TRUE.
- Pass advanced library options (responsive/offline/provider settings) via `embera.class.configuration`.
- Deduplicate repeated lookups of the same URL within one request via the built-in static cache.
- Generate embed markup during a migration or import that ingests media URLs.
- Populate a computed field with a video title or thumbnail derived from a URL.
- Build a Twig-facing service call that renders an embed inside a custom template.
- Enrich search-index data with a media title fetched from its oEmbed metadata.
- Confirm the library is present via the `hook_requirements()` status report entry.
- Serve as the shared oEmbed layer so several site-specific modules reuse one cache.
