RDF adds machine-readable semantic metadata to Drupal's HTML output using the RDFa specification, mapping entities and fields to vocabularies like Schema.org, SIOC, Dublin Core and FOAF so search engines and aggregators can understand your content's structure and relationships.

---

The RDF module was part of Drupal core through Drupal 9 and is now maintained as a contrib module. It lets modules and site builders describe bundles (content types, vocabularies, users, comments) and their fields in terms of RDF classes and properties, then injects that description into the page as RDFa attributes (`typeof`, `property`, `rel`, `about`, `content`) woven into the existing themed markup. Mappings are stored as `rdf_mapping` config entities (config prefix `rdf.mapping.*`), one per entity-type/bundle, and the module ships default mappings for core's article, page, forum, user, tags, and comment bundles. At render time hooks like `hook_preprocess_node`/`_user`/`_comment`/`_taxonomy_term` add the RDFa attributes to template variables, and a set of RDF namespace prefixes (collected via `hook_rdf_namespaces()`) is emitted so consumers can resolve the CURIEs. Developers read and edit mappings through the procedural helper `rdf_get_mapping($entity_type, $bundle)` and the `RdfMapping` config entity API. The module has no dedicated admin UI — mappings are managed in code/config — and no permissions of its own. It also provides a Drupal 7 migrate source plugin so legacy RDF mappings can be imported. The result is semantically enriched, standards-based output that improves interoperability and can feed rich results in search engines.

---

- Emit RDFa metadata on nodes so search engines understand author, date, and title.
- Map an article content type to the `sioc:Post` / `schema:Article` RDF class.
- Map a field (e.g. body, created date) to a Dublin Core or Schema.org property.
- Describe users with the FOAF vocabulary (`foaf:Person`, `foaf:name`).
- Annotate comments with SIOC (`sioc:Post`, `sioct:Comment`) for threaded-discussion semantics.
- Add `typeof` and `property` RDFa attributes to taxonomy term pages.
- Provide machine-readable relationships (`rel`) between content and its author.
- Feed structured data to aggregators and semantic-web crawlers.
- Improve SEO by exposing standards-based metadata alongside human-readable HTML.
- Define custom namespace prefixes for your own vocabulary via `hook_rdf_namespaces()`.
- Ship default RDF mappings for a custom content type via config/optional.
- Read a bundle's current mapping programmatically with `rdf_get_mapping()`.
- Set a bundle-to-class mapping in an update hook or install file.
- Export RDF mappings as configuration and deploy them across environments.
- Migrate Drupal 7 RDF mappings into Drupal 10/11 using the migrate source plugin.
- Enrich RSS/views RSS output with RDF metadata.
- Add `about` and `content` attributes so hidden/normalized values are exposed to machines.
- Mark up publication dates in ISO-8601 via RDFa `content` attributes.
- Support Linked Data / semantic web integrations for a decoupled consumer.
- Provide schema.org markup that helps generate search engine rich snippets.
- Attach RDF types to image fields and media so assets are described semantically.
- Give a headless front end a source of vocabulary mappings per bundle.
- Standardize metadata output across an entire multi-site install via shared config.
- Extend or override core's default mappings for article/page/forum bundles.
- Interoperate with other RDF-aware Drupal modules that read `rdf_mapping` entities.
