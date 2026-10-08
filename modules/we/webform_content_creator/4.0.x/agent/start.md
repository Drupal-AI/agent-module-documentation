# Webform Content Creator — agent index

Creates a content entity from each webform submission, mapping submission values (and tokens) onto
the new entity's fields. Requires the **webform** module.

- **The `webform_content_creator` config entity, admin routes, permission, mapping config, and
  sync/encrypt/redirect options** → [configure/entities.md](configure/entities.md)
- **The field-mapping plugin type and how to add one** →
  [plugins/field-mapping.md](plugins/field-mapping.md)

Key facts:
- Config entity type id `webform_content_creator` (class `Entity\WebformContentCreatorEntity`),
  config prefix `webform_content_creator.webform_content_creator.<id>`. Key fields: `webform`,
  `target_entity_type`, `target_bundle`, `elements` (the per-field mapping), plus sync/encrypt/
  redirect settings.
- Admin UI at `admin/config/webform_content_creator` (route
  `webform_content_creator.collection`); "Manage fields" at
  `admin/config/webform_content_creator/manage/{id}/fields`. Permission
  `access webform content creator configuration`.
- Driven by `hook_webform_submission_insert/update/delete` → the entity's
  `createContent()` / `updateContent()`.
- Plugin type `@WebformContentCreatorFieldMapping` (manager
  `plugin.manager.webform_content_creator.field_mapping`, dir
  `src/Plugin/WebformContentCreator/FieldMapping`). Default plugin `default_mapping`.
- Provides a token `[webform_submission:unmapped_values]`. No Drush.
