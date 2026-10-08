Webform Entity Handler adds a Webform **handler plugin** ("Entity") that creates or updates any content entity (node, user, taxonomy term, custom entity…) from the values of a webform submission, mapping each entity field/property to a submission element, a token, or a static value.

---

The module registers a single `WebformHandler` plugin, id `webform_entity_handler`, that you attach to a webform under *Settings → Emails / Handlers → Add handler → Entity*. In the handler form you pick the target **Entity type + bundle** (`entity_type_id`, e.g. `node:article`), an **operation** (create a new entity, or update the entity whose ID is stored in a chosen submission element / a custom value), and then map each of the target bundle's fields/properties to a submission value: choose `input:<element_key>` to copy a submitted value, `_null_` to set NULL, or a custom/token value. Multi-value fields offer an "append instead of override" checkbox. It supports **loading an existing entity by properties** (a YAML `entity_properties` map, tokens supported) when you do not have its ID, a `skip_if_exists` toggle, optional new-revision creation, and a `states` list controlling which submission lifecycle states (draft/completed/updated/deleted…) trigger it. All work happens in `postSave()`: it resolves the mapped values (token-replacing everything), loads or creates the entity, sets/apppends the fields, saves, logs a created/updated message, and (for update-by-element operations) writes the new entity ID back into the submission. Tokens are enabled (`tokens = TRUE`); `drupal/token` is suggested for the token browser.

---

- Create a node (e.g. an Article) from every completed submission of a "Submit a story" webform.
- Register/create a user account from a signup webform, mapping name/mail elements to user fields.
- Create a taxonomy term from a "suggest a category" form submission.
- Update an existing node by storing its ID in a hidden element and choosing the update operation.
- Update a user's profile fields when they submit a "profile update" webform.
- Load-and-update an entity by matching properties (e.g. by email) via the YAML `entity_properties` map.
- Skip creating a duplicate entity when one already exists (`skip_if_exists`).
- Map a webform text element straight into a node title field with `input:title`.
- Set a field to NULL on update by choosing the `_null_` option for that property.
- Append a value to a multi-value field instead of overwriting it (the append checkbox).
- Use tokens to compute a field value (e.g. `[current-user:uid]`) when creating the entity.
- Create a Webform submission-backed "lead" content entity for a CRM-style workflow.
- Fire the handler only on completion, not on drafts, via the `states` checkboxes.
- Also run on submission update or deletion by enabling those states.
- Create a new revision of the target entity on each update (revisionable entities).
- Populate a custom content entity type from a structured intake form.
- Turn an "event RSVP" webform into event-registration entities.
- Store the created entity's ID back into a submission element for later reference.
- Map composite element sub-values (e.g. address components) to separate entity properties.
- Change an entity's bundle on update (the handler recreates it preserving id/uuid).
- Stack multiple Entity handlers on one webform (cardinality is unlimited) to create several entities.
- Feed moderated content by creating unpublished nodes that editors later review.
- Build a "contact → create support ticket entity" pipeline without custom code.
- Convert anonymous submissions to entities only once they are converted to authenticated.
