<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Field Fetch adds a field type that mirrors (fetches) a field value from another node, term, or paragraph onto the entity it is placed on.

---

Entity Field Fetch lets you designate one node or term as the source of centralized content and then display that content anywhere. You add an "Entity Field Fetch field" to a content type, vocabulary, or paragraph type, and in the field settings point it at a target entity type (node or term), a target entity id (nid or tid), and the machine name of the field to pull — or, optionally, a specific paragraph on that source. The field then fetches the source value and renders it on both the view and edit displays of the host entity, keeping shared content edited in one place. Because the fetched data is exposed as computed properties on the field item, it rides along with the host entity through normal entity loads and data APIs (including JSON serialization and an optional GraphQL field), much like an entity reference. Output is cached against the source entity, so updating the source refreshes every place it is mirrored. It requires no other modules and works on Drupal 8 through 11.

---

- Show the same "top of page" notice on every article by mirroring one source node's field.
- Centralize a promotional banner edited in a single place and displayed sitewide.
- Reuse a shared disclaimer or legal blurb across many content types.
- Pull a taxonomy term's description field onto nodes that reference the topic.
- Mirror a paragraph (by id or UUID) from a source node onto other entities.
- Fetch a single field from a source node into a destination content type.
- Fetch a field from a source term into a destination vocabulary.
- Keep editorial workflow and revisions on shared content (unlike a markup field).
- Provide shared content that belongs to the entity for decoupled/headless setups.
- Surface fetched values through data APIs and entity loads like a reference.
- Expose fetched content over GraphQL via the bundled "fetched" field plugin.
- Display fetched WYSIWYG/text-format fields with their filters applied.
- Convert link/URI fields on the source into resolved URLs in the fetched data.
- Include referenced (entity_reference_revisions) sub-entities in the fetched payload.
- Add a "link to source" affordance on the edit form via the widget settings.
- Show the source's last-updated date on the edit form.
- Toggle whether the field label is shown on the edit form.
- Cache mirrored output against the source so edits propagate automatically.
- Mark mirrored output from an unpublished source with an unpublished CSS wrapper.
- Warn editors when a source node/term is still in use before it is deleted.
- Prevent accidental deletion of a node/term that is a fetch source.
- Build a light content-syndication pattern within a single Drupal site.
- Replace fragile shared blocks with entity-owned shared field content.
- Standardize repeated field content across bundles without duplicating data.
