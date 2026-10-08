<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Content Sync - Custom Field Example — agent index

Reference/example submodule. Ships a sample field type `cs_custom_field` and three example
Content Sync plugins demonstrating how to serialize (or ignore) a custom field/entity.
No config, no UI, no Drush, no permissions. Enable only to study the pattern.

Provided plugins (in `src/Plugin/cms_content_sync/`):
- **`@FieldHandler` `cms_content_sync_custom_field_handler`** (`field_handler/CustomFieldHandler`,
  extends `DefaultFieldHandler`) — `supports()` returns TRUE for field type `cs_custom_field`.
- **`@FieldHandler` `cms_content_sync_ignore_field_handler`** (`field_handler/IgnoreFieldHandler`) —
  matches field name `field_ignore_example`; `push()`/`pull()` return TRUE with no data,
  i.e. the field is excluded from sync.
- **`@EntityHandler` `cms_content_sync_custom_taxonomy_handler`** (`entity_handler/CustomTaxonomyHandler`,
  extends `DefaultTaxonomyHandler`).

Sample field type: `cs_custom_field` (FieldType `Plugin/Field/FieldType/CustomField`, plus a
widget and formatter). Handler mechanics and the two plugin types are documented in the
parent: `../../../../3.2.x/agent/plugins/handlers.md`.
