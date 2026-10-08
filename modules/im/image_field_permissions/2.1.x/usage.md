<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an "Advanced custom" Field Permissions type for image fields, so roles can be granted or denied create/edit/view access to the image file and its alt and title sub-attributes independently.

---

The module builds on the contrib Field Permissions module by supplying an `AdvancedCustomAccess` field-permission plugin (extending Field Permissions' `CustomAccess`) that adds image-specific pseudo-field permissions. Beyond the standard create/edit/view own/any file permissions, it exposes edit-own/edit-any permissions for the image **alt** and **title** values — letting you, for example, allow a translator to edit alt/title text without letting them replace or remove the image file. A `ServiceProvider` registers the plugin and an `ImageFieldPermissionsPermissionsService` (arguments: entity type manager, field permissions type manager) computes the pseudo-field access via `getPseudoFieldAccess($op, $entity, $account, $field_definition, $subfield)`.

The enforcement is done in `hook_form_node_form_alter()`: for each image field on the node form it checks the current user's permissions and, where the file value is not editable, hides upload/remove buttons (via `#process` callbacks `_image_field_permissions_disallow_edit_value`) or hides restricted `alt`/`title` sub-widgets (`_image_field_permissions_disallow_subfields`) while still allowing the field to render for viewing. Permissions appear both on the field's "Field visibility and permissions" setting (choose "Custom permissions") and on the standard People → Permissions page. Note the alter currently targets the node form specifically. Setup: enable Field Permissions + Field UI, set the image field to custom permissions, and assign the per-role image/alt/title permissions.

---

- Let a role edit image alt/title without replacing the image.
- Grant view-only access to an image file per role.
- Allow uploading own image files but not others'.
- Allow editing anyone's image file for an admin role.
- Control create/edit/view of image files by role.
- Separately permit editing the image alt attribute.
- Separately permit editing the image title attribute.
- Give translators alt/title edit rights only.
- Hide the upload/remove buttons for restricted users.
- Hide restricted alt/title sub-widgets on the node form.
- Set an image field to "Custom permissions" in field settings.
- Assign image field permissions on People → Permissions.
- Enforce per-role image editing on content forms.
- Combine with Field Permissions for non-image fields.
- Protect original imagery while allowing metadata edits.
- Restrict image changes to editors, metadata to authors.
- View the permissions overview at Reports → Field list.
- Apply distinct rules to different image fields.
- Let authors edit own images but not others'.
- Keep alt text editable for accessibility while locking files.
- Audit which roles can touch image files vs. metadata.