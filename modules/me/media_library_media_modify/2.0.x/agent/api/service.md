<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: service, override mechanism & guards

## Service `media_library_media_modify`

Class `Drupal\media_library_media_modify\EntityReferenceOverrideService`. Public methods an
integrator uses:

- `migrateEntityReferenceField(string $entity_type_id, string $field_name): void` — converts
  an existing `entity_reference` field storage/config to `entity_reference_entity_modify`,
  adding the `<field>_overwritten_property_map` column to the field's data (and revision)
  tables, updating the last-installed schema definitions and each bundle's form-display
  component to the modify widget. Throws if the field is not `entity_reference`. This is what
  the Drush command calls.
- `getOverriddenValues($referenced_entity, $original_entity, array $fields): array` — returns
  the recursive diff (`DiffArray::diffAssocRecursive`) of the given fields between an edited
  referenced entity and the original — i.e. what to persist as the override map.
- `formElement($items, $delta, $element, &$form, $form_state, $form_mode = 'default')` —
  builds the hidden `overwritten_property_map` element plus the "Override …" AJAX button that
  opens `ModifyEntityForm` in a modal. Used by both widgets.

Other services: `media_library_media_modify.ui_builder`
(`MediaLibraryMediaModifyUiBuilder`, builds the library edit UI) and an unnamed decorator of
`media_library.opener.field_widget` (`MediaLibraryMediaModifyFieldWidgetOpener`).

## How overrides are applied (render-time only)

The field type `EntityReferenceEntityModifyItem::__get('entity')` **clones** the referenced
entity, JSON-decodes `overwritten_property_map`, and `overwriteFields()` merges each override
onto the clone (`NestedArray::mergeDeepArray`, intersecting keys with the original). The
clone is tagged `$entity->entity_reference_entity_modify = "<type>:<bundle>:<id>.<propPath>"`
and given a cache dependency. Stored media is never modified — only the rendered clone.

## Guards / hooks an agent should know

- `hook_entity_presave()` throws `ReadOnlyEntityException` (a `\LogicException`) if an entity
  carrying the `entity_reference_entity_modify` marker is saved — prevents an override-loaded
  clone from overwriting the real media.
- `hook_entity_build_defaults_alter()` adds the override marker to the render cache keys so
  each context caches separately.
- `hook_field_formatter_info_alter()` makes every `entity_reference` formatter accept the
  `entity_reference_entity_modify` field type.
- `hook_media_source_info_alter()` registers a `media_library_media_modify_edit` form on the
  core file/image/audio/video/oembed:video media sources (used by the in-library edit form).

## Override form access

`ModifyEntityForm::access(AccountInterface $account)` looks up a tempstore entry by request
`hash`; if absent → `AccessResult::forbidden()`. Otherwise access = the **referenced
entity's `view` access**. There is no dedicated permission — anyone who can view the media
can set contextual overrides for it.
