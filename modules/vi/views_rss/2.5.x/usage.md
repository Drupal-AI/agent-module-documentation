<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Views RSS Feed replaces core's built-in RSS style with a fields-based style/row plugin pair that lets you map any View field to any RSS 2.0 channel or item element.

---

The module adds a Views **style** plugin (`rss_fields`, "Advanced RSS feed") and a matching **row** plugin (`views_rss_fields`, also labelled "Advanced RSS feed") that together replace core's fixed `node_rss`/`comment_rss`/`aggregator_rss` output with a field-by-field builder: any field added to the View can be assigned to any RSS `<channel>` or `<item>` element via dropdowns and textboxes in the style/row settings forms. The module itself defines no RSS elements at all — it only supplies the plugin machinery, the `views_rss_*` hooks, a config schema, and an RFC-822 date format (`core.date_format.rfc822`); the actual `<title>`, `<link>`, `<description>`, Dublin Core, and Media RSS (MRSS) elements are contributed by its five submodules (`views_rss_core`, `views_rss_dc`, `views_rss_format`, `views_rss_media`, `views_rss_media_getid3`), each implementing `hook_views_rss_namespaces()`, `hook_views_rss_channel_elements()`, and/or `hook_views_rss_item_elements()`. Element definitions returned by those hooks drive both the settings-form UI (grouped by namespace, with help links and optional per-element form overrides) and the render pipeline, including per-element preprocess-function chains that transform raw field values into RSS-ready markup or attributes. Two custom Twig templates (`views-view-rss.html.twig`, `views-view-row-rss.html.twig`) ship with the module to work around Drupal's HTML-tag rendering quirks (a `<link>` tag inside `<image>` and CDATA wrapping). The style plugin requires the matching row plugin (and vice versa, validated in each plugin's `validate()`), and the row plugin further requires `views_rss_core` to be enabled so at least a title or description element exists, since RSS 2.0 mandates one of the two on every item.

---

- Build a custom RSS 2.0 feed from an existing View by adding a Feed display with format "Advanced RSS feed".
- Map a View's "Title" field to the RSS `<title>` item element instead of using the row's raw title.
- Map a body/summary field to the item `<description>` element with relative-path-to-absolute-URL rewriting.
- Expose per-item `<enclosure>` (podcast/video/audio attachment) elements sourced from a file or image field.
- Add a `<guid>` element with `isPermaLink` computed automatically from the item link.
- Populate the channel `<image>` element (feed artwork) from a path, honoring the 144x400px RSS limit.
- Set channel `<ttl>`, `<skipHours>`, and `<skipDays>` hints for feed readers/aggregators.
- Add an `<atom:link rel="self">` element automatically for feed self-discovery.
- Publish Dublin Core metadata (`dc:creator`, `dc:date`, `dc:subject`, etc.) alongside core RSS elements (with `views_rss_dc`).
- Publish Yahoo Media RSS (`media:content`, `media:thumbnail`, `media:category`) for podcast/video feeds (with `views_rss_media`).
- Enrich `media:content`/`media:thumbnail` with real audio/video bitrate, resolution, and duration via getID3 (with `views_rss_media_getid3`).
- Skip HTML-entity encoding for specific elements that need raw markup passed through (with `views_rss_format`).
- Toggle "Replace relative paths with absolute URLs" so feed readers off-site can resolve embedded links/images.
- Control whether the feed's own RSS icon is attached to the View's links output ("feed_in_links").
- Merge RDF namespaces into the feed's XML namespaces when the core `rdf` module is enabled.
- Group multiple item `<category>` elements from a taxonomy-reference field, one `<category>` per referenced term.
- Derive channel `<pubDate>`/`<lastBuildDate>` automatically from the most recent item date in the result set.
- Emit a `<content:encoded>` element (wrapped in CDATA) for full-content feeds alongside a short `<description>`.
- Author a brand-new views_rss_* extension submodule that registers its own namespace + element set via the hooks.
- Alter another module's element definitions (e.g. adding preprocess functions) via `hook_views_rss_*_elements_alter()`.
- Validate the style/row options form with custom logic via `hook_views_rss_options_form_validate()`.
- Serve a podcast RSS feed with per-episode enclosure length/type/duration for podcast-app compatibility.
- Replace core's RSS feed display on an existing View without rebuilding fields, by swapping the style plugin.
- Produce a valid RSS 2.0 XML document even when optional elements are left blank (they are omitted, not empty-tagged).
- Add a `<comments>` element linking to a node's comment page from an RSS item.
- Add an `<author>`/`dc:creator` element derived from a "Content: Authored by" field, stripping role suffixes.
- Localize the channel `<language>` element to the current site language when left blank.
