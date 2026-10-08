e-Plikt exposes published node and media entities as an RSS 2.0 feed formatted for Swedish legal-deposit (mandatory delivery) to the National Library of Sweden.

---

e-Plikt (machine name `eplikt`) adds two RSS endpoints — `/eplikt/all` and `/eplikt/weekly` — that list the site's published content for legal-deposit harvesting. Content is gathered by enabled "source" plugins; the module ships a Node source and a Media source, each with per-bundle selection. Feed items carry Dublin Core metadata (publisher identifier, access rights, format) built from the module's settings, and media items additionally emit a `media:content` download URL resolved through the Media entity download module. A settings form at `/admin/config/services/eplikt` controls the publisher identifier, the default access-rights value, and which source plugins are active. The output templates follow the National Library of Sweden RSS delivery spec, and developers can extend the `EpliktSource` plugin type to feed additional entity types into the export.

---

- Publish a legal-deposit (e-plikt) RSS feed of a Drupal site's published content for the National Library of Sweden.
- Serve the full catalogue of deposit-eligible content at `/eplikt/all`.
- Serve only recently changed content (last 7 days) at `/eplikt/weekly` for incremental harvesting.
- Include published node content in the deposit feed via the Node source plugin.
- Include published media items in the deposit feed via the Media source plugin.
- Restrict a source to specific node bundles (content types) using per-source bundle selection.
- Restrict a source to specific media bundles (media types) using per-source bundle selection.
- Emit a downloadable `media:content` link for each media item through the Media entity download route.
- Set the site's publisher identifier (e.g. an `id.kb.se` organisation URI) once and stamp it on every feed item.
- Set a default Dublin Core access-rights value (`gratis`/free or `restricted`) for exported items.
- Provide Dublin Core `dc:publisher`, `dcterms:accessRights` and `dc:format` metadata per item.
- Give each feed item a stable GUID based on the entity UUID.
- Point harvesters at RFC 2822 publication dates derived from each entity's created time.
- Combine multiple source plugins into a single merged feed.
- Add a custom source plugin (e.g. for paragraphs or embedded content) by extending `EpliktSourceBase`.
- Order feed items newest-first (sorted by created date descending).
- Include only published entities the feed's viewer is allowed to see.
- Override the RSS output by supplying custom Twig templates (`eplikt-rss`, `eplikt-rss-item`, `eplikt-rss-item--media`).
- Add entity-type/bundle-specific item templates via the module's theme suggestions.
- Read module help rendered from the README on the admin help page.
- Expose the deposit feeds to an external legal-deposit harvesting service on a schedule.
- Configure everything from a single admin settings page without writing code.
- Support multilingual sites by tagging the feed with the current interface language.
