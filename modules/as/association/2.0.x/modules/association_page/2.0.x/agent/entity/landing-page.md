<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The association_page entity: lifecycle, access, revisions

## Enable & choose the handler

`drush en association_page` (requires `association`, `toolshed`). Then on an association type set its
**landing page** handler to **"Dedicated association page"** (plugin id `association_page`). From then
on, associations of that type own an `association_page`.

## Identity & storage

`association_page` (`src/Entity/AssociationPage.php`) is a `RevisionableContentEntityBase`:
`base_table=association_page`, `data_table=association_page_field_data`, revision tables
`association_page_revision` / `association_page_field_revision`. Bundle = `association_type`. It uses the
**same integer id as its association** — `getAssociation()` loads the `association` storage by
`$this->id()`. It implements `AssociatedEntityInterface`, so the parent module's negotiators and
`association_link` machinery treat it as association-owned content.

Base fields: `uid` (author, defaults to current user; anon in `preSave` if unset), `title` (label,
required, max 255), `status` (published), `created`, `changed`, `revision_translation_affected`.
Additional fields are added per bundle through Field UI.

## Lifecycle (tied to the association)

- **Create**: `AssociationPage` landing-page plugin `onCreate($association)` creates the page with
  `id`/`title`/`type` from the association and saves it. Direct create access is
  **forbidden** (`checkCreateAccess`), so pages exist only via this path.
- **URL**: `getPageUrl()` returns `$page->toUrl('canonical')` = `/association/{association_page}`. The
  parent `Association::toUrl('canonical')` delegates here, making the page the association's canonical
  page. If no page, `<nolink>`.
- **Delete**: `onPreDelete($associations)` loads pages by association ids and deletes them. Entity
  `delete` op is forbidden in the access handler — pages are removed only when their association is.
- **Revisions**: `RevisionablePagePluginInterface::shouldCreateNewRevision()` from config
  `new_revision`. `preSaveRevision()` keeps the previous revision log message when the new one is blank
  and it's not a new revision.

## Access (`PageAccessControlHandler`)

Admin permission (`administer association configurations`) bypasses. Otherwise:

| operation | rule |
|-----------|------|
| `view` | allowed if the parent association `isActive()`; else falls through to `page_update` |
| `update` | per-type permission `page_update` |
| `revision_view` / `revision_revert` / `revision_delete` | per-type permission `page_revisions` |
| `create` | forbidden (auto-provisioned) |
| `delete` (and default) | forbidden |

Per-type permission keys come from `AssociationPagePermissions::getBundleOperations()` (only returned
when the type uses the `association_page` handler): `page_update` and `page_revisions`, formatted by
the parent `AssociationPermissions::getBundlePermissionKey()`.

## Revision UI & routes

`AssociationPageHtmlRouteProvider` adds: canonical (`_entity_access: association_page.view`),
`revision-history` → `AssociationPageController::revisionOverview` (a revisions table; the revision log
message is rendered through `#markup` with `#allowed_tags = Xss::getHtmlTagList()`), `revision` view →
`revisionShow`, and `revision-revert` / `revision-delete` confirm forms. All revision routes require
`association_page.revision_*` entity access → `page_revisions`.

## Admin integration

`association_page.module`: `hook_local_tasks_alter` + `hook_menu_links_discovered_alter` +
`hook_entity_operation_alter` relocate the page's Field UI, form-display, view-display and Layout
Builder tasks/links onto the association type edit screen, gated by the core-style permissions
`administer association_page fields|form display|display`. The page-config field route
(`/admin/structure/association/{association_type}/page`, `_access: FALSE`) is only reachable via
`AssociationPageEnhancer` + `AssociationPageConfigAccess`, which permits it only when the type actually
uses this landing-page plugin.
