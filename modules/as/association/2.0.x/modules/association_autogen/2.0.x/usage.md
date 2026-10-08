Auto-generates and links member entities (e.g. a starter node) whenever an association of a configured type is created, using a token-based label pattern.

---

`association_autogen` is a submodule of Entity Association. On an association type's settings you add one or more "generate" rules, each bound to a behavior **tag** and a target entity type/bundle. When a new `association` of that type is inserted (`hook_ENTITY_insert`), `EntityGenerator::generateMultiple()` creates each configured entity, sets its label from a token pattern resolved against the parent association (default `[association:name]: <bundle>`), applies the published flag, saves it, and creates the `association_link` back to the association (tagging the link with the rule's UUID). A rule can mark the generated label as non-editable, in which case an event subscriber disables the label field on the member's edit form. Rules are stored as `association_autogen` third-party settings on the `association_type` config entity and are edited at `/admin/structure/association/manage/{association_type}/autogen` (access = association type edit).

---

- Auto-create a landing node every time editors create a new "Campaign" association.
- Seed each new association with a placeholder entity so the collection is never empty.
- Name auto-created entities from the association using tokens like `[association:name]`.
- Publish (or keep unpublished) the auto-generated entity based on the rule's Published flag.
- Lock the auto-generated entity's title so editors cannot rename it (Allow-label-edit off).
- Generate different entity bundles for different behavior tags/slots of the same association type.
- Respect a manifest behavior's cardinality — the settings form only offers tags with remaining capacity.
- Add or remove generation rules per association type via the AJAX table on the autogen settings form.
- Keep generation configuration in exportable config (third-party settings) for deployment.
- Combine with association_page so a new association gets both its landing page and seeded content.
