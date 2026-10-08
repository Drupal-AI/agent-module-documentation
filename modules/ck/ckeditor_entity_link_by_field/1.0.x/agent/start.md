<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Entity Link by Field (ckeditor_entity_link_by_field) — agent index
**Adds a CKEditor/Linkit dialog + JSON autocomplete to link nodes by a configured field instead of the title.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 — depends on `ckeditor`, `editor`, `linkit`.
- **Routes:** `.dialog` `/ckeditor-entity-link-by-field/dialog/{filter_format}` (`_entity_access: filter_format.use`); `.config_form` `/admin/config/content/ckeditor_entity_link_by_field` (`administer ckeditor_entity_link_by_field`); `.autocomplete` `/admin/ckeditor_entity_link_by_field/autocomplete/by_field` (`access content`, JSON).
- **Config:** `ckeditor_entity_link_by_field.settings` (`sources` = entity_type→field map).
- **Security:** the autocomplete (`access content`, anonymous by default) queries nodes with **no `accessCheck()`** and returns unpublished article field values + nids (`EntityLinkByFieldAutoCompleteController.php:75-90`) — information disclosure of unpublished content. Admin/dialog routes are properly gated.

See [configure/settings.md](configure/settings.md).
