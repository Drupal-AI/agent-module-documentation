Adds an entity-reference selection handler that automatically passes the entity being edited (its ID) as the first contextual argument to the View that builds the reference field's candidate list.

---

Drupal core ships a "Views: Filter by an entity reference view" selection handler that lets a View provide the selectable options for an entity-reference field, with optional static arguments. This module extends that handler with one addition: it prepends the **current (host) entity's ID** to those arguments before the View runs. The referenced View therefore receives the host entity's ID as its first contextual filter argument, and any static arguments you configure follow it. This makes the list of referenceable entities depend on the entity you are currently editing — for example, only showing candidates related to that specific node, user, or term. Behaviour is otherwise identical to core's Views selection: you pick a View + display of type *Entity Reference*, the View's own access and filters gate the results, and labels are rendered through core's autocomplete/select handling. No new UI, routes, permissions, or services are added — you simply choose the handler "*Views: Filter by an entity reference view (with current entity ID as argument)*" in the field's Reference type settings.

---

- Limit a node's entity-reference candidates to entities related to that exact node.
- Build a self-referencing "related items" field where a View excludes the current entity by its ID.
- Prevent an entity from referencing itself by using the host ID as a contextual filter that filters it out.
- Show only child/descendant entities of the entity currently being edited.
- Restrict a user profile's reference field to records owned by or linked to that user's ID.
- Filter taxonomy-term references to terms scoped to the current term's tree via its ID.
- Let a paragraph/component reference only items belonging to its host entity.
- Populate a "next step" reference with options computed from the current workflow entity's ID.
- Scope a media reference field to media associated with the current entity.
- Constrain a commerce/product reference to variations of the current product.
- Provide context-sensitive autocomplete suggestions that change per edited entity.
- Combine the automatic host ID with additional static View arguments (comma-separated) for multi-argument contextual filtering.
- Drive an entity-reference View with contextual filters that would otherwise need custom PHP or hook code.
- Show only entities in the same group/organization as the host entity, keyed by its ID.
- Filter event-registration references to sessions belonging to the current event's ID.
- Build hierarchical selection widgets where each level filters by the parent entity's ID.
- Reference only translations or revisions tied to the current entity's ID.
- Offer curated related-content pickers whose options are defined and maintained entirely in Views.
- Reuse an existing Entity Reference View display and add per-entity context without cloning the View.
- Let site builders control per-entity candidate lists without writing an EntityReferenceSelection plugin.
- Filter a reference field on a config/content entity form so options depend on the entity's stored ID.
- Keep candidate access enforced by the View's access plugin while still scoping results to the host entity.
