<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Api Site Studio processor adds a Search API processor that decodes Acquia Site Studio (formerly Cohesion) layout-canvas components on an entity and injects their text into the search index.
---
Content built with Site Studio components is stored as a JSON layout canvas on `cohesion_entity_reference_revisions` fields rather than plain field text, so standard Search API field indexing misses it. This module provides a processor plugin (`sitestudio_component_item`, marked locked + hidden) that supplies a configurable `search_api_html` property named "Sitestudio Components". When added as an index field it loads each node's `cohesion_layout` entity, decodes the canvas JSON with `LayoutCanvas`, walks the component tree (recursively including child components), extracts human text values from the component `model` (stripping tags/entities from richtext), and adds the concatenated string to the index item.

The processor is configurable per index field: by default it indexes text from all components, or you can restrict it to whole component categories or individual components via the field configuration form (built from `cohesion_component_category`, `cohesion_component`, and the custom-component discovery service). All extraction is wrapped in a broad try/catch that logs an error (and adds a re-index warning during post-request indexing) so a single malformed canvas does not break indexing. It requires Search API and a working Acquia Site Studio (`cohesion`/`cohesion_elements`) install.
---
- Make text inside Site Studio components searchable in Search API
- Index Cohesion layout-canvas content that standard field indexing misses
- Add a "Sitestudio Components" field to a Search API index
- Index all components across every layout canvas (default)
- Restrict indexing to specific component categories
- Restrict indexing to individual named components (e.g. only Hero Banner)
- Exclude decorative/settings-only components from search text
- Extract richtext body text from components (tags stripped)
- Recursively index text from nested/child components
- Improve search recall on pages built entirely with Site Studio
- Keep index size down by filtering to relevant component categories
- Reindex safely — errors are logged and items re-queued, not fatal
- Combine component text with other Search API fields on a node index
- Support Solr, database, or any Search API backend for the extracted text
- Surface component-driven landing-page copy in site search results
- Configure component selection per index field via a vertical-tabs form
- Audit which components feed the index by reading the field configuration
