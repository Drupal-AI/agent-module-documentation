<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media entity GoogleDocs provides a Media source plugin so Google Docs, Sheets, Slides and Forms published-embed URLs (or their `<iframe>` embed codes) can be stored as media entities and rendered inline.
---
The module registers a `googledocs` MediaSource plugin (allowed source field types `string`, `string_long`, `link`) that extracts metadata — the embed `shortcode`, document `type` (document/spreadsheets/presentation/forms) and `id` — by running two regular expressions against the source field value. A validation constraint (`GoogleDocsEmbedCode`) rejects source values that don't match those patterns, and a field formatter (`googledocs_embed_generic`) renders the matched `shortcode` as an `<iframe>` with configurable width, height, scrolling and fullscreen. Type-specific thumbnail icons are returned for the four document types.

From a security standpoint this module does not fetch the Google Docs URL server-side, so there is no SSRF surface and no TLS-verification concern: the PHP code only runs `preg_match` on the field value and then emits an `<iframe src="...">` for the browser to load client-side. The regexes constrain the value to `docs.google.com/.../{spreadsheets|presentation|document|forms}/d/.../(pubhtml|pub?embedded=true|embed|viewform?embedded=true)` published-embed URLs, and the `src` is taken from that validated `shortcode` capture. The main residual consideration is standard embed trust — an editor with permission to create these media entities embeds third-party Google-hosted iframe content — plus the module targets Drupal 8/9 (`^8 || ^9`), so verify compatibility before use on newer core. There are no routes, permissions, services, or database queries of its own.
---
- Create a Media type using the "GoogleDocs" source.
- Store a published Google Docs/Sheets/Slides/Forms embed URL as media.
- Paste a full `<iframe>` embed code as the source value (parsed automatically).
- Validate that a source value is a real Google Docs embed URL/code.
- Render a Google Doc inline via the `googledocs_embed_generic` formatter.
- Configure iframe width and height for embeds.
- Toggle scrolling and fullscreen on the embedded document.
- Show type-specific thumbnail icons (doc/sheet/slide/form).
- Extract the document type and ID as media metadata.
- Embed a published Google Sheet in a page.
- Embed a Google Slides presentation.
- Embed a Google Form for collecting responses.
- Reuse embedded docs across nodes via media reference fields.
- Use a `link`, `string`, or `string_long` source field.
- Integrate with Lightning Media via the companion module.
- Avoid server-side fetching (iframes load client-side, no SSRF).
- Restrict embeddable sources to `docs.google.com` published URLs (regex-enforced).
- Manage embedded documents centrally in the media library.
- Verify Drupal 8/9 compatibility before deploying on newer core.