Entity Reference validators adds two opt-in validation constraints to any entity reference field: one that blocks circular (self-referencing) chains and one that blocks the same target being referenced more than once.

---

The module ships no configuration UI, route, or field type of its own. It works entirely through per-field third-party settings on an `entity_reference` field. `hook_form_field_config_edit_form_alter()` injects a "Reference validators" fieldset into every entity reference field's edit form with three checkboxes: "Prevent circular references", "Recursively check circular references" (deep), and "Prevent entity from referencing duplicates". The circular checkboxes are only shown when the field's target entity type equals the host entity type (e.g. a node field pointing at nodes). When a checkbox is ticked, `hook_entity_bundle_field_info_alter()` reads the third-party settings and calls `$field->addConstraint('CircularReference', ['deep' => ...])` and/or `$field->addConstraint('DuplicateReference')`, so the standard Drupal validation/Typed Data system enforces the rule on entity save and via the entity form. `CircularReference` rejects an entity that would reference itself (optionally walking the whole reference tree when "deep" is on); `DuplicateReference` rejects a value list where the same target id appears twice. Settings persist under `field.field.<entity>.<bundle>.<field>` → `third_party_settings.entity_reference_validators`.

---

- Stop a "Related articles" node reference field from letting an article reference itself.
- Prevent a taxonomy parent field from creating a circular parent/child loop.
- Block a menu/page hierarchy field from pointing a node back at one of its own ancestors (deep check).
- Enforce that a "Team members" reference field never lists the same user twice.
- Keep a multi-value "Tags" entity reference from containing duplicate term references.
- Add referential-integrity guards to a field without writing a custom constraint plugin.
- Turn on circular-reference prevention per field via the field's Manage fields edit form.
- Enable recursive (deep) circular checking so an indirect A→B→A loop is caught, not just A→A.
- Validate on both the entity edit form and programmatic `$entity->save()` paths using core's constraint system.
- De-duplicate a "See also" links field so editors cannot enter the same node twice.
- Protect a self-referencing "Parent product" reference on a commerce product type.
- Guard an organization-chart field where a person must not report to themselves.
- Prevent an infinite loop in a related-content recommendation field.
- Ship the setting in exported config (`third_party_settings.entity_reference_validators.circular_reference: true`) for deployment.
- Toggle duplicate prevention on a field per environment by overriding its field config.
- Combine circular + duplicate prevention on the same reference field.
- Apply duplicate prevention to a paragraphs/media reference field to avoid repeats.
- Keep a "Prerequisite courses" field from listing a course as its own prerequisite.
- Constrain a category tree so a term cannot be its own parent.
- Add validation feedback ("This entity cannot be referenced") shown inline on the edit form.
- Enforce unique references on a "Featured items" field used in a view.
- Use with any entity type that supports entity reference fields (node, user, taxonomy, media, custom).
- Avoid data corruption from accidental self-references introduced during content migration.
- Provide a lightweight alternative to custom Symfony validators for the two most common reference bugs.
