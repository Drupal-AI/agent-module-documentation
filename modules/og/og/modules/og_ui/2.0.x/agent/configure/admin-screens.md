<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin screens and the bundle-form integration

## Routes (all require `administer organic groups`)

| Route | Path | Form/controller |
|---|---|---|
| `og_ui.admin_index` | `/admin/config/group` | `SystemController::systemAdminMenuBlockPage` — the module's `configure` route |
| `og_ui.settings` | `/admin/config/group/settings` | `Form\AdminSettingsForm` (edits `og.settings`) |
| `og_ui.roles_permissions_overview` | `/admin/config/group/{type}` where `type` is `roles` or `permissions` | `Controller\OgUiController::rolesPermissionsOverviewPage` |
| `og_ui.permissions_overview` | `/admin/config/group/permissions/{entity_type_id}/{bundle_id}` | `Form\OgPermissionsForm` |
| `og_ui.permissions_edit_form` | `/admin/config/group/permissions/{entity_type_id}/{bundle_id}/{role_name}` | `Form\OgRolePermissionsForm` |

Menu links: "Organic groups" under *Configuration* (right column, weight -5) with children
"OG settings", "OG roles", "OG permissions".

`og`'s own `entity.og_role.collection|add_form|edit_form|delete_form` routes
(`/admin/config/group/roles/{entity_type_id}/{bundle_id}`, `/admin/config/group/role/{og_role}/…`)
are served by `og_ui`'s `OgRoleForm`, `OgRoleDeleteForm` and
`OgUiController::rolesOverviewPageTitleCallback`.

## The "Organic groups" tab on bundle forms

`og_ui_form_alter()` fires for any form whose form object is a `BundleEntityFormBase`
(node types, vocabularies, media types, block types, …) except `og_membership_type`, and
delegates to the `og_ui.bundle_entity_form_alter` service
(`Drupal\og_ui\BundleEntityFormAlter`). It adds a details element `og`
(title "Organic groups", `#group: additional_settings`) with these form values:

| Value | Meaning |
|---|---|
| `og_is_group` | checkbox — every entity of this bundle is a group |
| `og_membership_type` | select — default `og_membership_type` for groups of this bundle (visible only when `og_is_group` is checked) |
| `og_group_content_bundle` | checkbox — this bundle is group content (gets the `og_audience` field) |
| `og_target_type` | select — entity type the audience field points at |
| `og_target_bundles` | multi-select (AJAX) — allowed target bundles |

Nothing is saved directly by the form. `og_ui_entity_insert()` / `og_ui_entity_update()` call
`og_ui_entity_type_save()`, which reads those properties off the saved
`ConfigEntityBundleBase` and performs the real OG operations:

```php
$entity->og_is_group        →  Og::groupTypeManager()->addGroup() / removeGroup()
$entity->og_membership_type →  setGroupDefaultMembershipType() / removeGroupDefaultMembershipType()
$entity->og_group_content_bundle
                            →  Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, …)
                               or FieldConfig::loadByName(…, 'og_audience')->delete()
$entity->og_target_type     →  FieldStorageConfig 'og_audience' setSetting('target_type', …)
$entity->og_target_bundles  →  FieldConfig setSetting('handler_settings.target_bundles', …)
```

So a scripted equivalent of ticking the boxes is simply the `og` API — see
`modules/og/2.0.x/agent/configure/groups-and-fields.md`. (Setting the properties on a bundle
entity before saving it also works, since the hooks read them.)

## The OG settings form

`Form\AdminSettingsForm` (`og_ui_admin_settings`) is a `ConfigFormBase` over **`og.settings`**:

| Form element | Config key |
|---|---|
| Group manager has full permissions | `group_manager_full_access` |
| Strict node access permissions | `node_access_strict` |
| Delete orphans | `delete_orphans` |
| Deletion method (radios, one per `OgDeleteOrphans` plugin) | `delete_orphans_plugin_id` |
| Automatically add creators to the group | `auto_add_group_owner_membership` |

Each deletion-method radio also renders that plugin's own `configurationForm()`. Everything the
form does is equivalent to `drush cset og.settings <key> <value> -y`.

## Libraries

`og_ui/form` (`css/form.css`) — indentation for the child radio items on the settings form.
