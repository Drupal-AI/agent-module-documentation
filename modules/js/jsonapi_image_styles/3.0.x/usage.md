<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Image Styles exposes the derivative URLs of Drupal image styles on JSON:API `file--file` resources, so a decoupled front end can request pre-defined image-style renditions (thumbnail, crop-based styles, etc.) without knowing Drupal's internal URL scheme.

---

The module adds a single computed base field, `image_style_uri`, to every File entity. When a file is an image, that field is populated at read time with a map of `image_style_machine_name => absolute_derivative_url` for each exposed image style (using `ImageStyle::buildUrl()`), and JSON:API serializes it into the resource's attributes. A small admin form at `/admin/config/services/jsonapi/image_styles` stores an optional allow-list in `jsonapi_image_styles.settings` (`image_styles`); if the list is empty, all defined image styles are exposed, otherwise only the selected ones. An event subscriber tags all JSON:API responses with the `config:jsonapi_image_styles.settings` cache tag so the output is invalidated when the allow-list changes. The module defines an internal `image_style_uri` field type plugin (a `no_ui` map field) that backs the computed field. It adds no permissions of its own (the settings form is gated by core's *Administer image styles* permission), no Drush commands, and no config schema. Requesting the derivative URLs from a front end normally involves including the image file in a JSON:API request (e.g. `?include=field_image.field_media_image`) and reading `image_style_uri` from the file resource's attributes.

---

- Serve Drupal image-style derivative URLs (thumbnail, medium, large) to a React/Vue/Next.js front end over JSON:API.
- Let a decoupled build consume crop-defined image styles (from Crop API / Focal Point) without duplicating crop logic on the client.
- Restrict which image styles are published to the API by selecting an allow-list on the settings form.
- Expose every defined image style by leaving the allow-list empty (the default behaviour).
- Add responsive-image renditions to a headless gallery by reading multiple named styles off one file resource.
- Read `image_style_uri` from a `file--file` resource included via `?include=field_image` in a node request.
- Provide art-directed image URLs to a mobile app that talks to the site's JSON:API.
- Avoid hard-coding `/sites/default/files/styles/...` paths in front-end code by letting Drupal build the derivative URLs.
- Keep front-end image URLs valid across environments (dev/stage/prod) because the URLs are generated server-side.
- Trigger image-style derivative generation lazily by handing the client the style URL to fetch.
- Publish a curated subset of styles (e.g. only `thumbnail` and `large`) to keep API payloads small.
- Ensure API caches invalidate when the exposed-style list changes, via the `config:jsonapi_image_styles.settings` cache tag.
- Feed a static-site generator (Gatsby, Astro) the exact image renditions it should download at build time.
- Expose WebP/AVIF derivatives produced by an image style to clients that request the style URL.
- Combine with Consumer Image Styles alternatives when you only need plain per-style URLs, not a link-template negotiation.
- Give a Paragraphs/Layout-driven front end the style URLs for images referenced through media fields.
- Let editors add new image styles in Drupal and have them appear automatically in the API (when no allow-list is set).
- Deliver square/cropped avatars to a decoupled user profile screen.
- Support a JSON:API-driven email or PDF builder that needs sized image URLs.
- Migrate a monolithic theme to headless without rebuilding image-derivative logic in JavaScript.
- Audit which styles are exposed by reading `jsonapi_image_styles.settings.image_styles`.
- Expose image styles for files uploaded through any entity (nodes, media, taxonomy, users) since the field lives on the File entity.
- Keep the API response cacheable and CDN-friendly by returning stable derivative URLs.
