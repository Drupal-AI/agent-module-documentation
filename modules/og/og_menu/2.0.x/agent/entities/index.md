<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities: ogmenu and ogmenu_instance

## `ogmenu` (config entity, the bundle / "template")

`src/Entity/OgMenu.php` — `@ConfigEntityType(id="ogmenu")`, `ConfigEntityBundleBase`.

- `config_prefix: ogmenu`, `bundle_of: ogmenu_instance`, `admin_permission: "administer og menu"`.
- `config_export`: `id`, `label` only (schema: `config/schema/ogmenu_instance_type.schema.yml`).
- Forms: add/edit `OgMenuForm` (label + machine name), delete `OgMenuDeleteForm`.
- List builder `OgMenuListBuilder`; collection route `admin/structure/menu/ogmenu`.
- `postSave()` on **create** (not update, not syncing) calls
  `Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, 'ogmenu_instance', $this->id())`
  — this attaches OG's audience field to the new bundle, making instances of it group content. It
  also clears block plugin definitions so the derived blocks pick up the new menu.
- `delete()` clears the `menu` cache and block definitions.
- Note: the annotation's `links.collection` points at `/admin/structure/visibility_group` (a stray
  path); the working collection route is `entity.ogmenu.collection` at `admin/structure/menu/ogmenu`.

## `ogmenu_instance` (content entity, one per group)

`src/Entity/OgMenuInstance.php` — `@ContentEntityType(id="ogmenu_instance")`, `base_table
ogmenu_instance`, `bundle_entity_type: ogmenu`.

- Base fields: `id`, `type` (entity_reference → `ogmenu`, required), `uuid`, `langcode`. The group
  reference is **not** a base field — it is the OG audience field added dynamically by
  `OgMenu::postSave()` per bundle.
- `admin_permission = "administer OgMenuInstance entities"` (declared but no such permission exists
  in `og_menu.permissions.yml`, so it grants nothing; access flows through the access handler).
- `label()` returns the associated **group's** label (via `getGroup()`), falling back to the
  `ogmenu` label; `getFieldTargetTypeLabel()` logs a warning and returns "- Parent group missing -"
  for orphaned instances.
- `getGroup()` loads the target entity from the audience field, throwing if unset/unloadable.
- **Backs a real menu:** each instance drives a Drupal menu named `ogmenu-{id}`. Menu links are
  `menu_link_content` entities with `menu_name = 'ogmenu-{id}'` (see `OgMenuInstanceController::addLink`).
- `preDelete()` calls `menu_link_manager->deleteLinksInMenu('ogmenu-' . $id)` — deleting an instance
  removes its links.
- `postSave()` invalidates the `ogmenu_instance` cache tag.

## Lifecycle hooks (`og_menu.module`)

- `hook_entity_insert`: when a group is created and `og_menu.settings:autocreate` is TRUE, create an
  `ogmenu_instance` for each `ogmenu` bundle wired to that group type.
- `hook_entity_delete`: when a group is deleted and OG's `delete_orphans` is FALSE, load and delete
  the group's `ogmenu_instance` entities (by the audience field).
- `hook_form_alter`: on `ogmenu_add_form`/`ogmenu_edit_form`, force the bundle to be group content
  and hide the OG "is group / group-content" toggles so they cannot be changed.
- `hook_system_breadcrumb_alter`: replaces core `menu_ui`'s breadcrumb (which errored on
  `ogmenu-*` menus) to build the crumb from the `ogmenu_instance` when the menu name is `ogmenu-*`.

## Editing links

`OgMenuInstanceForm` (`src/Form/OgMenuInstanceForm.php`) rebuilds core's menu-overview table for
`ogmenu-{id}`: a draggable, weighted table of the menu tree, with per-link edit/delete/reset/
translate operations routed to core `menu_ui` routes. `submitOverviewForm()` writes changed weight/
parent/enabled values back via `menuLinkManager->updateDefinition()`, using the plugin's own id
(not the tamperable hidden form value). The "Add link" empty-text link is shown only when the user
passes the add-link permission check (global OR OG-group).
