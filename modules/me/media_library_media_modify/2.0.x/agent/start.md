<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Library Media Modify — agent index

Stores **per-instance (contextual) overrides** of a referenced media item's fields, edited
from the media library widget. The source media entity is never changed; overrides apply at
render time only. No configure route (`configure: null`), no permissions.

- **Field type, widget & its settings, the Views edit-link field, form modes** →
  [configure/field-and-widget.md](configure/field-and-widget.md)
- **The `EntityReferenceOverrideService`, the override-map mechanism, the read-only guard,
  the formatter/source alters** → [api/service.md](api/service.md)
- **Drush command to migrate an entity_reference field to the modify field type** →
  [drush/migrate.md](drush/migrate.md)

Key facts:
- Field type `entity_reference_entity_modify` ("Media with contextual modifications"),
  default `target_type: media`, default widget `media_library_media_modify_widget`, default
  formatter `entity_reference_entity_view`. Adds an `overwritten_property_map` (JSON, `text
  big`) column.
- Widget `media_library_media_modify_widget` ("Media library extra") extends core
  `MediaLibraryWidget`. Settings: `form_mode`, `multi_edit_on_create`, `no_edit_on_create`,
  `check_selected`, `replace_checkbox_by_order_indicator`. Config schema:
  `field.widget.settings.media_library_media_modify_widget`.
- Views field `media_library_media_modify_edit_link` ("Edit link for the Media Library").
- Drush: `media_library_media_modify:migrate <entity_type_id> <field_name>`.
- Service id `media_library_media_modify` = `EntityReferenceOverrideService`.
- Submodule `entity_reference_entity_modify` (experimental) adds an autocomplete override
  widget for non-media references → see its own docs.
