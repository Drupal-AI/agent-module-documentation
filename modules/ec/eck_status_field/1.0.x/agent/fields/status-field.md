<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECK Status Field — the status base field

How `eck_status_field` gives an ECK entity type a core-style `status` (published) base field.
All logic lives in `eck_status_field.module` plus two tiny entity subclasses. No routes,
services, permissions, config schema, install hooks, or Drush.

## Enabling per entity type
- `eck_status_field_form_eck_entity_type_form_alter()` adds a checkbox `$form['base_fields']['published']`
  (title "Published field") to the ECK entity type form. Its `#default_value` is read from
  `eck.eck_entity_type.<id>` config key `published`.
- `eck_status_field_entity_type_alter()` registers `published` in the `eck_entity_type`
  config entity's `config_export` list, so the checkbox value is stored/exported in the ECK
  type's config. It also sets the entity class to `PublishedEckEntityType` and adds the
  `entity_keys` mapping `published => status`.
- Net effect: checking the box writes `published: true` into `eck.eck_entity_type.<id>`.

## Attaching the field and class (only when `published` is true)
- `eck_status_field_entity_type_build()` loops all entity types; for those provided by `eck`
  whose class is `Drupal\eck\Entity\EckEntity` and whose config `published` is set, it swaps
  the entity class to `PublishedEckEntity` and adds `entity_keys['published'] = 'status'`.
- `eck_status_field_entity_base_field_info(EntityTypeInterface $entityType)`: when the type's
  config `published` is set, it merges in `PublishedEckEntity::publishedBaseFieldDefinitions($entityType)`
  and marks the `published`-keyed field `setDisplayConfigurable('form', TRUE)` and
  `('view', TRUE)`.

## The entity classes
- `src/Entity/PublishedEckEntity.php` — `PublishedEckEntity extends EckEntity implements
  EntityPublishedInterface`, `use EntityPublishedTrait;`. The trait supplies the standard
  `status` base field definition (`publishedBaseFieldDefinitions()`) plus `isPublished()`,
  `setPublished()`, `setUnpublished()`.
- `src/Entity/PublishedEckEntityType.php` — `PublishedEckEntityType extends EckEntityType`,
  adds a protected `$published` property and `hasPublishedField(): bool` (returns
  `isset($this->published) && $this->published`).

## Operating it
1. Enable the module (`drush en eck_status_field`); requires `eck`.
2. Edit or create an ECK entity type; tick "Published field"; save.
3. New/edited entities of that type expose a Published widget on the form and the flag on view;
   in code use `$entity->isPublished()` / `->setPublished()` / `->setUnpublished()`.

## Help hook
- `eck_status_field_help()` renders `README.md` on `help.page.eck_status_field` (raw `<pre>`,
  or via the `markdown` filter plugin if the `markdown` module is enabled).

## ECK 2.0 note
Published support was merged into ECK 2.0 itself (native `status` key). See the project's
upgrade steps (migrate the `published` config key to `status`, then uninstall/remove this module).
