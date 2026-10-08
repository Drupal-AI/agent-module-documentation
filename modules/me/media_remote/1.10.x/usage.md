<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Remote turns a plain remote URL into a Drupal media item for providers that do **not** implement oEmbed — it supplies one `media_remote` media source plus 20 provider-specific field formatters (Loom, Google Drive/Maps, Box, Dropbox, Brightcove, Panopto, Matterport, Apple Podcasts and more) that convert the stored URL into an embed snippet.

---

Core's `oembed:video` source only works for providers listed in oembed.com's `providers.json`. Media Remote covers the rest with deliberately simple scaffolding: a media source plugin `media_remote` ("Remote Media URL") whose source field is a plain `string`, and a per-provider `@FieldFormatter` that renders that string through a Twig template into an `<iframe>` or provider widget. The provider is chosen **on the media type's `default` view display** — you pick, say, `media_remote_loom` as the formatter for the source field, and every formatter's `defaultSettings()` stamps its own class name into a `formatter_class` setting. That setting is load-bearing: `MediaRemoteSource::getFormatterClass()` reads `media.<bundle>.default` to find it, and both the media name and URL validation are derived from it. A `media_remote` validation constraint runs the chosen formatter's `getUrlRegexPattern()` against the submitted URL and, on failure, reports the formatter's `getValidUrlExampleStrings()` back to the editor; the same class also supplies `deriveMediaDefaultNameFromUrl()` so a new media item gets a sensible auto-name. Because the constraint depends on the default display, a media type whose source field has no Media Remote formatter throws a `LogicException` — which is why `hook_form_media_type_add_form_alter()` redirects you straight to *Manage display* with a warning after creating the type. `MediaRemoteMediaForm` adds a URL box to Media Library so editors can paste a link there too. There is no settings form, no configure route, no permissions, no Drush and no plugin type of its own; formatters that render iframes expose `width`/`height` (and Dropbox an `app_key`) as formatter settings.

---

- Embed a Loom screen recording as a proper media entity instead of pasting raw HTML.
- Publish a Google Doc, Sheet or Slides deck that has been "published to the web" inside a node.
- Show a custom Google My Maps map on a location page.
- Embed a Box shared file in an intranet page with a fixed iframe height.
- Render a Dropbox shared link as an embedded preview using a Dropbox app key.
- Add Brightcove player URLs as media without the full Brightcove module.
- Embed Panopto lecture recordings on a university course page.
- Put a Matterport 3D property tour on a real-estate listing.
- Embed an ArcGIS dashboard, map viewer or instant app.
- Add Apple Podcasts episodes to a podcast archive content type.
- Embed Buzzsprout or Libsyn podcast episodes with auto-derived titles.
- Show Deezer or Stitcher episode players in a media library.
- Embed a DocumentCloud document for investigative-journalism articles.
- Collect responses by embedding a Microsoft Forms form in a page.
- Embed NPR live-session videos in an editorial piece.
- Show a Quickbase report table inside a Drupal page.
- Embed Dacast or Planet eStream video for a broadcaster's site.
- Give editors one "Remote video" media type that validates URLs before saving.
- Reject a pasted URL from the wrong provider with a helpful example-URL error message.
- Let editors add remote media directly from the Media Library modal via a URL field.
- Auto-name new media items from the URL (episode slug, document id, etc.) instead of manual titles.
- Reuse one embedded video across many nodes through an entity reference media field.
- Set a consistent iframe width/height per provider across the whole site from Manage display.
- Standardise embeds so a CSP or privacy review only has to whitelist known iframe hosts.
- Replace ad-hoc `<iframe>` markup in body fields with structured, revisionable media entities.
- Add a new unsupported provider by subclassing `MediaRemoteFormatterBase` in a custom module.
- Migrate legacy embed-code fields into media entities keyed by URL.
- Expose remote media through JSON:API as a normal media entity with a URL field.
