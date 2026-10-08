<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Entity Link by Field adds an editor dialog and autocomplete that let content authors link to entities by matching a configured field (e.g. a machine-name field) rather than the entity title.
---
The module registers a CKEditor/Linkit-based "Add link by field" dialog at `/ckeditor-entity-link-by-field/dialog/{filter_format}` (form `CKEditorEntityLinkByFieldDialog`, protected by `_entity_access: filter_format.use`), an admin settings form at `/admin/config/content/ckeditor_entity_link_by_field` (route `ckeditor_entity_link_by_field.config_form`, permission `administer ckeditor_entity_link_by_field`) where an administrator maps entity types to the source field, and a JSON autocomplete controller at `/admin/ckeditor_entity_link_by_field/autocomplete/by_field`. Editors type into the dialog, the autocomplete queries article nodes whose configured field CONTAINS the input, and a link is inserted.

Operational/security note: the autocomplete route is gated only by `_permission: 'access content'`, and `EntityLinkByFieldAutoCompleteController::handleAutocomplete()` builds its node query with `getQuery()` WITHOUT an `accessCheck()`, returning both published and unpublished article nodes (it even renders a 🚫 marker for unpublished ones). Any user holding `access content` — anonymous by default — can therefore enumerate the configured field values and node IDs of unpublished articles. Setup: install (requires `ckeditor`, `editor`, `linkit`), configure the source field per entity type, and grant `administer ckeditor_entity_link_by_field` only to trusted editors.
---
- Insert a link to a node by typing part of its machine-name field instead of its title.
- Map the `node` entity type to a specific source field on the settings form.
- Give editors a Linkit-style dialog scoped to a chosen field.
- Restrict configuration access with the `administer ckeditor_entity_link_by_field` permission.
- Add the "Add link by field" button to a CKEditor toolbar for a text format.
- Gate the dialog per text format via the `filter_format.use` entity access.
- Autocomplete article nodes whose field CONTAINS the typed string.
- Show published vs unpublished status markers in the autocomplete results.
- Limit autocomplete results to the first 10 matches.
- Sanitize the typed query with `Xss::filter()` before querying.
- Configure which field feeds the autocomplete via `ckeditor_entity_link_by_field.settings`.
- Provide editors a consistent way to link internal content by a stable identifier.
- Review the autocomplete route's `access content` gating before exposing it publicly.
- Audit that unpublished-node field values are not leaked to anonymous users.
- Integrate with the core editor link dialog by reusing `editor_link_dialog` base form.
- Translate the dialog and settings labels.
- Combine with Linkit profiles already configured on the site.
- Use the inserted link markup within any Linkit-enabled text format.
- Verify the configured source field exists as a `field_storage_config` on node.
- Disable the module to remove the dialog and autocomplete route.
- Restrict the autocomplete by hardening its permission if unpublished content is sensitive.
