<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A field type that records which Mautic segments or tags a piece of content is for — a targeting hint for templates and Views, and optionally a per-field view access gate.

---

Where the base Mautic Audiences module answers "who is this visitor?", the Audience field submodule holds the other half — "who is this content for?" — on the content itself. It provides the `mautic_audience` field type (unlimited cardinality, one alias per item), a widget fed from the Mautic segment/tag inventory the base module already caches, and matching Views and Search API tooling. A storage setting picks whether the field's aliases are matched against the visitor's segments or their tags. By default the field is purely editorial: templates can ask `is_in_segment(node.field_audience)` and Views can filter on it, but nothing about access changes. Each field instance also has an opt-in "Restrict viewing to the selected Mautic audiences" setting; turn it on and any entity with at least one alias picked is refused to visitors outside those audiences (whoever may edit the entity is never refused, and content with nothing picked stays public). Because access is answered through `hook_entity_access`, it protects rendering but not raw queries, listings, or search on its own — so the submodule also ships a per-row Views filter and a Search API query-time processor to carry the same condition there. Viewing the stored aliases is administrative (gated by `administer mautic audiences`), so formatters, JSON:API, REST, and Views field handlers stay empty for everyone else. It requires the base Mautic Audiences module and Drupal core's Field module; Search API is optional and only needed for the search processor.

---

- Add an "Audience" field to a content type, media type, or taxonomy to tag which segments it targets.
- Configure the field to match against Mautic tags instead of segments (a storage-time choice).
- Let editors pick audiences from real Mautic segment/tag names rather than typing aliases.
- Keep a value that Mautic has since renamed visible and labelled, instead of silently dropping it on save.
- Show only stored values (with a notice) when Mautic is temporarily unreachable, so an outage never reads as deletions.
- Refresh the Mautic inventory on demand from the widget's "Refresh the list from Mautic" button.
- Use the field purely as an editorial targeting hint that changes nothing about access.
- Branch a template on the field with `{% if is_in_segment(node.field_audience) %}`.
- Turn on per-field view-access enforcement so gated entities are refused to non-matching visitors.
- Serve gated content to anonymous visitors carrying a Mautic tracking cookie (campaign links without login).
- Keep an entity's own permissions authoritative — the gate only ever refuses, never grants.
- Hide gated rows from a listing with the per-row "Audience matches the visitor" Views filter.
- Offer a "picked for you" block by turning off "keep rows with no audience" in that filter.
- Keep gated content out of search results with the "Mautic audience access" Search API processor.
- Preserve facets and search inside a gated area without maintaining a second index.
- Keep audience aliases out of formatters, JSON:API, and REST for non-administrators.
- Surface, on the status report, which fields enforce view access and the page-cache cost of doing so.
- Match audiences at the entity level across all translations (or keep the field non-translatable to avoid that).
- Combine the gate with the entity's own permissions when authentication is also required.
