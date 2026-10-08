Field Permissions adds per-field access control to Drupal, letting administrators decide who can create, edit, and view the value of any individual field on any entity — down to distinguishing a user's own content from everyone else's.

---

By default Drupal grants field access at the entity level: if you can edit a node you can edit all its fields. Field Permissions overrides this per field. On each field's settings form you choose a **field permission type**: **Public** (default core behaviour), **Private** (only the entity's author and users with "access other users' private fields" may see or edit it), or **Custom** — which exposes a permission grid so you assign, per role, the granular permissions *create*, *edit own / edit anyone*, and *view own / view anyone* for that specific field. The permission type is stored as third-party settings on the field storage config, and the custom permissions are generated dynamically (via a `permission_callbacks` entry) so each configured field contributes its own named permissions. Access is enforced through core's `hook_entity_field_access`. The module is built on a pluggable `FieldPermissionType` plugin system, so developers can add entirely new access strategies beyond the three shipped ones. An admin report at **Reports → Field list → Permissions** summarises which fields have custom access and how each role is granted. Typical uses include private profile fields, internal-only editorial notes, and fields only certain roles may fill in.

---

- Make a user-profile "phone number" field visible only to its owner and admins.
- Add an internal editorial "notes" field that only editors can see or edit.
- Let authors set a field on their own content but not on other users' content.
- Allow a role to view a field's value but never edit it.
- Grant only a "Reviewer" role permission to edit a "review status" field.
- Restrict who can populate a "featured" flag with create/edit permissions.
- Keep a private "date of birth" field hidden from other site users.
- Expose a field for creation on new content but lock editing afterward per role.
- Give moderators view access to all users' private fields via one permission.
- Build a members-only field that anonymous visitors can never see.
- Separate "view own" from "view any" so users only read their own submissions.
- Hide an admin-only "commission rate" field from regular editors.
- Let support staff edit any user's private contact field while others cannot.
- Apply different field visibility rules per role on a single content type.
- Protect sensitive commerce/customer fields from lower-privileged roles.
- Mark a field Private so it never appears in another user's rendered entity.
- Audit field access across the site from the Field permissions report.
- Enforce that only HR can view an employee "salary" field on a profile entity.
- Allow contributors to create a field value but not change it once submitted.
- Combine per-role create/edit/view grants for fine-grained workflow control.
- Add a custom `FieldPermissionType` plugin implementing a bespoke access rule.
- Migrate legacy field access settings via the provided migrate process plugin.
- Give a "private message" field visibility limited to sender and recipient roles.
- Ensure decoupled/API responses respect field-level access for each consumer.
