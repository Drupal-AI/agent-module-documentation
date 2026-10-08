Islandora Core is the foundation of the Islandora digital-repository framework: it turns Drupal nodes, media, and taxonomy into a linked-data repository, wiring content to external microservices (derivative generation, indexing, Fedora sync) through the Context module and an event/message broker.

---

Islandora models repository objects as Drupal **nodes** related by `field_member_of` (parent/child) and typed
by `field_model` taxonomy terms, with binaries stored as **media** tagged by `field_media_use` terms. Rather
than hardcoding behavior, it drives everything through the **Context** module: Islandora ships Context
**Conditions** (node/media has term, parent has term, uses filesystem, mimetype, is Islandora object, …) and
**Context Reactions** (Derivative, Index, Delete, view-mode/JSON-LD/form alterations) so admins declaratively
say "when a node is an Image, emit a Generate-Derivative event." Those reactions fire Islandora **Actions**
(`emit_node_event`, `emit_media_event`, `emit_file_event`, `emit_term_event`, and the abstract
Generate-Derivative actions) that publish AMQP/STOMP messages (via `stomp-php`, default broker
`tcp://activemq:61613`) to microservices, and index actions push to Search API. Content is exposed as JSON-LD
(via the `jsonld` module) with configurable RDF mappings and, when Fedora is configured, mirrored into a
Fedora repository via `islandora/chullo` + the entity mapper. It adds REST-ish endpoints to attach/replace
media source files (authenticated by basic auth, cookie, or JWT), "Add/Upload children" and "Add/Upload
media" batch wizards on nodes, HTTP `Link` headers relating nodes↔media↔files, a core settings form
(`/admin/config/islandora/core`) for broker, JWT expiry, Fedora URL, upload location, and an RDF-mappings
report. JWTs (module `jwt`) authenticate outbound microservice callbacks; a Drush hook adds a `--userid`
option to `migrate:import`/`migrate:rollback` for ingest. Media/child derivative pipelines are extended by
submodules (image, audio, video, IIIF, OCR/text extraction, breadcrumbs). Three permissions: `view
checksums`, `manage members`, `manage media`.

---

- Build a digital-object repository where objects are nodes linked by `field_member_of`.
- Type repository objects with a `field_model` taxonomy (Image, Video, Audio, Paged Content, …).
- Attach binaries as media tagged by `field_media_use` (Original File, Service File, Thumbnail, …).
- Declaratively trigger derivative generation with Context conditions + the Derivative reaction.
- Emit AMQP/STOMP events to microservices when content is created/updated (Houdini, Homarus, Hypercube, …).
- Generate image/audio/video/OCR derivatives via the matching Islandora submodules.
- Index nodes (and their media's parent nodes) into Search API through the Index reaction/actions.
- Mirror Drupal content into a Fedora 6 repository as linked data (chullo + entity mapper).
- Expose nodes, media, and terms as JSON-LD with configurable RDF property mappings.
- Report all field→RDF and term→URI mappings at `/admin/reports/islandora/rdf_mappings`.
- Add child objects to a node in bulk with the "Upload children" wizard.
- Add or upload media to a node in bulk with the "Add/Upload media" wizard.
- Replace or attach a media's source file over HTTP (basic auth / cookie / JWT) for microservice callbacks.
- Authenticate microservice callbacks to Drupal with short-lived JWTs (configurable expiry).
- Relate nodes, media, and files to each other via HTTP `Link` headers for machine clients.
- Delete a node together with its media and files (with a confirmation form and a Delete reaction).
- Reorder child objects with an integer-weight Views selector.
- Map taxonomy terms to external linked-data URIs via `field_external_uri`.
- Switch view mode or alter the JSON-LD type per context (e.g. render Images differently).
- Restrict who can view file checksums, manage members, or manage media via permissions.
- Configure the message broker URL and optional broker credentials for the event pipeline.
- Run CSV/`migrate_plus` ingests as a chosen user with `drush migrate:import --userid=…`.
- Use Islandora Utils helpers (`islandora.utils`) to find parents, media, ancestors, and term URIs in code.
- Build breadcrumbs from `field_member_of` hierarchy (islandora_breadcrumbs submodule).
- Serve IIIF manifests and image tiles for viewers (islandora_iiif submodule).
- Extract and display OCR/HOCR text from ingested documents (islandora_text_extraction submodule).
