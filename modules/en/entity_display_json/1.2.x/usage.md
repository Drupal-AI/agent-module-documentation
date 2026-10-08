<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Display JSON exposes Drupal entities as JSON using their existing view-display (Manage Display) configuration.

---

Entity Display JSON is a read-only JSON API for Drupal entities driven by the display modes you already configure under **Manage Display**. Configure a view display once and you get a stable JSON contract — hidden fields stay hidden, formatter settings and labels come through, and view modes propagate to referenced entities — so editors changing how content looks never reshape the data your front end depends on. It exposes three GET endpoints under `/ejson` (site info, path-to-pointer resolve, and entity/view build), all gated by a single `access entity display json` permission, and enforces per-entity and per-field view access on top of that permission. Referenced entities, paragraphs, media and files are walked recursively using each component's view mode (with cycle/depth guards emitting `_stub` markers), responses are cacheable by default (`CacheableJsonResponse` with the right cache tags/contexts), and output is extensible without forking through `FieldValueExtractor` plugins and four alter hooks. Optional integrations (Views, Field Group, Block Field, Paragraphs) are picked up automatically when those modules are installed. It targets a decoupled/headless front end (React, Vue, Svelte, native apps, edge renderers) as a lightweight, display-driven alternative to JSON:API. Requires Drupal 10.2+ or 11; no extra Composer or PHP libraries.

---

- Serve a Drupal entity as JSON shaped by a view display mode.
- Build a headless/decoupled front end (React, Vue, Svelte, Next.js) against display-driven JSON.
- Use a lightweight alternative to JSON:API when you only need read access shaped by Manage Display.
- Create a dedicated "JSON" view mode per entity type and serve that instead of the visual Default display.
- Fetch a whole page in one request: node plus its referenced entities, paragraphs, media and files.
- Keep the JSON contract stable while editors restyle the visual display.
- Resolve a front-end URL or alias to an `{entity_type, uuid, id, display_id}` pointer via `/ejson/resolve?path=/about-us`.
- Bootstrap a SPA with site name, slogan, language map and homepage pointer from `GET /ejson`.
- Serve a specific translation of an entity with `?lang=xx`.
- Serialize a Views listing (page or block display) as JSON rows.
- Serialize `views_block:*` block-field values (via Block Field) into JSON.
- Recursively serialize Paragraphs trees using each component's view mode.
- Preserve Field Group structures as nested JSON objects.
- Request an alternate view mode for the same alias by overriding `display_id` on the resolver.
- Generate TypeScript types for the payload from the shipped `schema/entity-payload.schema.json` (via json-schema-to-typescript).
- Force a field to array or scalar output regardless of cardinality with the `multi_value` third-party setting.
- Return filtered HTML for formatted-text fields with the `render` third-party setting (runs `check_markup`).
- Take over serialization of a field type or formatter with a custom `FieldValueExtractor` plugin.
- Trim or reshape a single field's value with `hook_entity_display_json_field_alter()`.
- Inject a hidden field or a computed property into a payload with `hook_entity_display_json_entity_alter()`.
- Add top-level response metadata with `hook_entity_display_json_response_alter()`.
- Reweight or swap a built-in extractor with `hook_entity_display_json_field_value_extractor_info_alter()`.
- Serialize an entity in custom PHP with `\Drupal::service('entity_display_json.builder')->serialize($entity, $langcode, $display_id)`.
- Rely on automatic cache tags/contexts so JSON responses invalidate when the entity, fields, config or view change.
- Expose image-style thumbnail URLs (`media_thumbnail` formatter) as JSON `image_url` values.
- Absolute-ize `internal:` / `entity:` link URIs in link fields for front-end consumption.
