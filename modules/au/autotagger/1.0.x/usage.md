autotagger is a plugin framework that automatically assigns taxonomy terms to nodes on save; the base module ships no tagging logic and only becomes useful once a submodule or custom Autotagger plugin is enabled.

---

autotagger defines an `Autotagger` plugin type and a plugin manager, then wires three node/form hooks (`hook_help`, `hook_form_alter`, `hook_ENTITY_TYPE_presave` for nodes) that fan out to every registered plugin. On the node type add/edit form each plugin may add its own settings (stored as node-type third-party settings under the `autotagger` provider), and on every node presave each plugin gets a chance to inspect the node and append taxonomy term references. The core module contains no matching, AI, or network logic of its own — the only shipped implementation lives in the bundled `autotagger_search_in_text` submodule, which does plain local substring matching of taxonomy term labels against a node's text fields. Version 1 supports nodes only. It depends solely on core Taxonomy and requires Drupal 9, 10, or 11.

---

- Auto-assign taxonomy terms to nodes when they are saved.
- Provide a pluggable `Autotagger` plugin type for custom tagging strategies.
- Enable the `autotagger_search_in_text` submodule to tag by literal term-label text matching.
- Configure, per content type, which fields to scan and which taxonomy reference field to fill.
- Write your own Autotagger plugin (keyword rules, external classifier, ML, etc.).
- Add per-bundle tagging options to the node type add/edit form via a plugin.
- Store per-content-type tagging configuration as node-type third-party settings.
- Tag content only on initial creation, or on every save (per submodule option).
- Populate an existing taxonomy_term entity_reference field with matched terms.
- Automate categorization of large content sets instead of tagging by hand.
- Reuse an existing controlled vocabulary as the source of taggable terms.
- Scan title, body, and other text/string fields for term matches.
- Scan text fields on referenced entities (node/media entity_reference).
- Scan text fields on referenced paragraphs, including nested paragraphs.
- Keep manually added tags and only append newly matched terms (no duplicates).
- Restrict tagging to nodes of specifically configured content types.
- Drive editorial workflows that depend on consistent taxonomy tagging.
- Bootstrap a related-content / faceted-search setup by ensuring nodes are tagged.
- Extend tagging behavior via the `autotagger_info` alter hook on plugin definitions.
- Cache plugin definitions (cache bin key `autotagger_plugins`) for performance.
- Serve as the framework layer that community/custom tagging plugins build on.
- Migrate off manual tagging with a review-then-trust rollout per content type.
- Combine several enabled plugins, each contributing its own tags on save.
