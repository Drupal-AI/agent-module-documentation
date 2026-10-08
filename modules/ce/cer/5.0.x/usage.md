<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Corresponding Entity References (CER) keeps two entity-reference fields in sync: if entity A references entity B, CER writes the matching back-reference onto B automatically, and removes it again when the reference goes away.

---

CER is the Drupal 8+ successor to Corresponding Node References. Its whole configuration surface is a config entity type, `corresponding_reference` (`cer.corresponding_reference.<id>`, admin UI at `/admin/config/content/cer`, permission `administer cer`), which the project calls a **preset**. A preset names a `first_field` and a `second_field` (both plain entity-reference field machine names starting with `field_`, and they may be the *same* field for a reciprocal "related content" relationship), a set of `bundles` keyed by entity type (`node: [article, page]`, or `node: ['*']` for all), an `add_direction` of `append` or `prepend`, and an `enabled` flag. At runtime `cer.module` implements `hook_entity_insert()`, `hook_entity_update()` and `hook_entity_delete()`; each loads all *enabled* presets via `CorrespondingReferenceStorage::loadValid()` and calls `synchronizeCorrespondingFields()`. That method compares the saved entity's field against `$entity->original` to build an `add` / `remove` difference set, lets modules alter it through `hook_cer_differences_alter()`, and then writes each corresponding entity: it checks the target field's `target_type` and `handler_settings.target_bundles` before adding or removing a `target_id` and calling `save()`. Everything runs in the current user's security context, so entity/field access can silently prevent a sync. CER ships no Drush commands, no plugin types and no services other than a stub event subscriber; note also that the "Synchronize" confirm form on a preset currently **deletes** the preset instead of syncing existing content (`CorrespondingReferenceSyncForm::submitForm()` calls `$this->entity->delete()`), so avoid it.

---

- Keep a node's "Related articles" field reciprocal so both articles list each other.
- Link a "Company" node to its "Employee" nodes and have each employee point back at the company.
- Maintain a two-way "Prerequisite / Required by" relationship between course nodes.
- Sync a "Featured product" reference on a landing page with a "Featured on" field on the product.
- Build symmetric "See also" links without an editor having to update both sides.
- Keep a taxonomy-term reference and its inverse node reference aligned.
- Correspond a user profile's "Team" field with the team entity's "Members" field.
- Make an "Event" ↔ "Speaker" relationship editable from either side.
- Model a friend/colleague relationship with a single self-corresponding field.
- Remove the back-reference automatically when an editor unsets the forward reference.
- Clean up back-references automatically when the referencing entity is deleted.
- Restrict a preset to specific bundles so only Articles participate in a relationship.
- Apply a preset to every bundle of an entity type with the `*` wildcard.
- Correspond fields across different entity types (e.g. node ↔ commerce_product) via the bundles map.
- Choose whether a new back-reference lands at the top (`prepend`) or bottom (`append`) of the list.
- Temporarily switch a relationship off by disabling the preset instead of deleting it.
- Skip syncing for unpublished entities by implementing `hook_cer_differences_alter()`.
- Suppress syncing for a particular field or workflow state from custom code.
- Deploy the relationship rules as exported configuration between environments.
- Avoid writing a custom `hook_entity_presave()` to maintain inverse references.
- Replace a Views "relationship on reverse reference" with a real stored back-reference (better for sorting/filtering).
- Give editors a back-reference field they can reorder manually, rather than a computed list.
- Migrate a Drupal 7 CNR setup to Drupal 10/11 by recreating the relationships as presets.
- Keep two reference fields aligned across a content migration by saving each entity once.
- Audit relationship rules in one place (`/admin/config/content/cer`) instead of scattered code.
