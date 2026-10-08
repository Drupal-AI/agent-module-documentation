<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECK Status Field lets you add a status/published base field to Entity Construction Kit (ECK) entity types.

---

ECK Status Field extends the Entity Construction Kit (ECK) module so that custom ECK entity types can carry a core-style `status` (published/unpublished) base field. It adds a "Published field" checkbox to the ECK entity type form; when enabled, that entity type stores a `published` flag in its config, the module swaps in an entity class that implements Drupal's `EntityPublishedInterface` (via `EntityPublishedTrait`), and a `status` base field is attached through `hook_entity_base_field_info()`. The field is display-configurable on both the form and view, so ECK content editors get the same publish/unpublish toggle available on nodes. The module has no admin settings page of its own and depends only on `eck`. Note: on ECK 2.0 this functionality was merged into ECK itself, so the project documents an upgrade path to migrate the `published` config key to ECK's native `status` key and then remove this module.

---

- Give a custom ECK entity type a core-style published/unpublished status flag.
- Add draft vs. published states to ECK content without writing custom code.
- Enable the "Published field" checkbox on an ECK entity type's edit form.
- Store the publish toggle as a `published` setting inside the `eck.eck_entity_type.*` config.
- Attach a `status` base field to selected ECK entity types via `hook_entity_base_field_info()`.
- Make ECK entities implement `EntityPublishedInterface` like nodes and other core content entities.
- Expose the published checkbox on the ECK entity add/edit form (display-configurable widget).
- Show or theme the published state on the ECK entity's view display (display-configurable formatter).
- Let editors call `->setPublished()` / `->setUnpublished()` / `->isPublished()` on ECK entities in code.
- Build editorial workflows (create as unpublished, publish later) for custom entity types.
- Model content types beyond nodes (e.g. events, products, profiles) that need a publish switch.
- Feed the published status into Views filters that key off the `status` base field.
- Keep entities hidden from front-end listings by leaving them unpublished until ready.
- Standardise publish behavior across nodes and ECK entities in one site.
- Match ECK entities to code that expects the `EntityPublishedInterface` contract.
- Toggle the published flag per entity type, enabling it only where editorial status matters.
- Export the `published` setting with your ECK entity type configuration for deployment.
- Provide a foundation for content moderation or scheduling that relies on a status field.
- Prepare an ECK-based site for the ECK 2.0 migration where status is native.
- Add publishing support retroactively to existing ECK entity types.
