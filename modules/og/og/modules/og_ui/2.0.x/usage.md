<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Organic Groups UI is the admin front-end for the `og` API module: an "Organic groups" tab on every bundle form, plus the site-wide OG settings, roles and permissions screens under `/admin/config/group`.

---

`og_ui` adds no entities, no permissions and no services of its own — it reuses `og`'s single global permission `administer organic groups` on every route. Its centrepiece is `og_ui_form_alter()`, which on any `BundleEntityFormBase` (content type, vocabulary, media type, …) hands off to the `og_ui.bundle_entity_form_alter` service (`Drupal\og_ui\BundleEntityFormAlter`) to inject an **Organic groups** details element into the form's *Additional settings* vertical tabs. That element carries `og_is_group` (make every entity of this bundle a group), `og_membership_type` (which `og_membership_type` new memberships get), `og_group_content_bundle` (make this bundle group content), `og_target_type` and `og_target_bundles` (which group entity type/bundles the audience field may point at). On save, `og_ui_entity_insert()` / `og_ui_entity_update()` translate those form values into real OG API calls — `Og::groupTypeManager()->addGroup()` / `removeGroup()`, `setGroupDefaultMembershipType()` / `removeGroupDefaultMembershipType()`, `Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, …)` or deleting that field, and updating the audience field storage's `target_type` and the field's `handler_settings.target_bundles`. The module also provides the `/admin/config/group` admin index (route `og_ui.admin_index`, which is the module's `configure` route and a menu item under Configuration), the OG settings form `/admin/config/group/settings` (`AdminSettingsForm`, editing `og.settings`), the roles and permissions overview `/admin/config/group/{roles|permissions}`, the per-group-type permission matrix `/admin/config/group/permissions/{entity_type_id}/{bundle_id}` (`OgPermissionsForm`), the single-role permission form `/admin/config/group/permissions/{entity_type_id}/{bundle_id}/{role_name}` (`OgRolePermissionsForm`) and the `OgRole` add/edit/delete forms that back `og`'s `entity.og_role.*` routes. Note the membership-type management screens (`/admin/structure/membership-types`) and the per-group member admin pages live in `og` itself, not here.

---

- Tick a checkbox on a content type to turn it into an OG group.
- Tick a checkbox on a second content type to turn it into group content.
- Choose which group bundles a group-content bundle's audience field may reference.
- Point a bundle's audience field at a different entity type (e.g. taxonomy terms as groups).
- Pick the default membership type used for a given group bundle.
- Demote a bundle from group to normal content and have OG clean up.
- Remove the audience field from a bundle by unticking "Group content".
- Edit `og.settings` from a form instead of `drush cset`.
- Turn "Group manager has full permissions" on or off.
- Toggle "Strict node access permissions" for OG-aware node CRUD.
- Enable orphan deletion and pick the simple / batch / cron strategy in the UI.
- Turn off "Automatically add creators to the group".
- Browse every group type's roles from `/admin/config/group/roles`.
- Browse every group type's permission matrix from `/admin/config/group/permissions`.
- Grant a group permission (e.g. `create post content`) to the `member` role of one group bundle.
- Give the `non-member` role the `subscribe` permission so visitors can join.
- Add a custom OG role (e.g. "editor") for one group bundle.
- Edit a single role's permissions on its own form.
- Delete a non-required custom OG role.
- Verify which permissions the administrator role implies via `is_admin`.
- Give site builders a discoverable "Organic groups" entry under Configuration.
- Onboard a site builder to OG without any code.
