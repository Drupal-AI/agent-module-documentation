<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Views Extras — agent index

Adds Views relationships joining webform submissions to **any** content entity type they were
submitted from (not just node). Depends on `webform_views`, `webform`, `views`. No global config
page (`configure` null), no permissions of its own (admin entity uses `administer site configuration`).

- **Create relationships, the base fields, and the Views field/filter/relationship** →
  [configure/relationships.md](configure/relationships.md)

Key facts:
- Config entity `webform_submission_relationships` (config prefix `webform_submission_relationships`,
  `admin_permission = administer site configuration`), managed at
  `/admin/structure/webform_submission_relationships`.
- Per content entity type, `hook_entity_base_field_info()` adds base field
  `entity_id_<entity_type>` to `webform_submission`; values back-filled on install and via
  `hook_entity_presave()` from the submission's `entity_type`/`entity_id`.
- `hook_views_data_alter()` (`.views.inc`) exposes each relationship: field/filter/argument/sort +
  a **relationship** joining `webform_submission.entity_id_<type>` → target entity data table.
- Add form hides entity types already configured or lacking a webform reference field.
