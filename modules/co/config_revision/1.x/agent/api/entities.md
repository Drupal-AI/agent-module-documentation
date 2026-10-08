<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities, storage, forms, routes & services

## `config_revision` (content entity)

`src/Entity/ConfigRevision.php`, `@ContentEntityType`, extends `EditorialContentEntityBase`,
implements `ConfigRevisionInterface` (adds `EntityChangedInterface`, `RevisionLogInterface`,
`EntityOwnerInterface`, `EntityPublishedInterface`). Key annotation facts:

- `bundle_entity_type = config_revision_type`, `translatable = FALSE`.
- Tables: `base_table = config_revision`, `revision_table = config_revision_revision`.
- Entity keys: id=`id`, revision=`revision_id`, uuid=`uuid`, bundle=`type`, label=`name`,
  published=`status`, owner=`user_id`. Revision-metadata keys: `revision_user`,
  `revision_created`, `revision_log`. `admin_permission = administer config_revision`.
- Handlers: `storage` = `src/Storage.php` (empty `SqlContentEntityStorage` subclass), `access` =
  `src/AccessControlHandler.php`, route providers `html` = `src/RouteProvider.php` and `revision`
  = `src/RevisionRouteProvider.php`, `list_builder` = `src/ListBuilder.php`, `views_data` =
  `src/ViewsData.php` (empty `EntityViewsData` subclass), forms `edit`/`default` =
  `src/Form/EntityForm.php`, `delete` = core `ContentEntityDeleteForm`, `revision-revert` =
  `src/Form/RevisionRevertForm.php`, `revision-delete` = core `RevisionDeleteForm`.

Base fields (`baseFieldDefinitions()`): `name` (string ≤255, required, revisionable — holds the
target config entity id), `config` (`map`, required, revisionable — the raw `$entity->toArray()`),
`changed` (changed timestamp), plus owner and editorial (status) fields from the base class/traits.

Helpers: `loadConfigRevisionByConfigId(string $config_id)` loads by the `name` property;
`getConfigMap(): MapItem` returns the `config` field's first item; `getConfigRevisionType():
EntityReferenceItem` returns the `type` field's first item.

## `config_revision_type` (config entity / bundle)

`src/Entity/ConfigRevisionType.php`, `@ConfigEntityType`, extends `ConfigEntityBundleBase`,
implements `ConfigRevisionTypeInterface` (adds `EntityDescriptionInterface`). `config_prefix =
type`, `bundle_of = config_revision`, `admin_permission = administer config_revision type`.
`config_export = { id, label, description }`. Access handler is core
`EntityAccessControlHandler`; route provider is core `DefaultHtmlRouteProvider`. One bundle exists
per opted-in config entity type; the settings form creates/deletes these.

## Route providers

- `src/RouteProvider.php` (`DefaultHtmlRouteProvider`): pins the **collection** route to
  `_permission: administer config_revision`; marks add/edit/delete-form routes `_admin_route`.
- `src/RevisionRouteProvider.php` (`RevisionHtmlRouteProvider`): pins the **version-history** route
  to `_permission: administer config_revision`; marks the version-history, revision-view and
  revision-revert routes `_admin_route`. (The view/revert/delete revision routes otherwise keep
  core's `_entity_access` requirements → resolved by the access handler below.)

Entity links (from the annotation): `collection` `/admin/content/config-revision`, `canonical`
`/config-revision/{config_revision}`, `add-form`, `edit-form`, `delete-form`, `version-history`
`/config-revision/{config_revision}/revisions`, `revision`, `revision-revert-form`,
`revision-delete-form`. Local tasks in `config_revision.links.task.yml`; the settings menu link is
in `config_revision.links.menu.yml`.

## Access handler

`src/AccessControlHandler.php` extends `EntityAccessControlHandler`. `checkAccess()`:
`view all revisions` / `view revision` / `revert` / `delete revision` → require
`administer config_revision`; `view` → admins, or `isPublished()` AND `view config_revision`;
anything else → parent. It also overrides `access()` and `createAccess()`.

## Forms

- `src/Form/AdminSettingsForm.php` — `ConfigFormBase`, form id `config_revision_settings_form`,
  edits `config_revision.settings`. See [../config/settings.md](../config/settings.md).
- `src/Form/EntityForm.php` — `ContentEntityForm`; on save logs and messages
  "created"/"updated".
- `src/Form/RevisionRevertForm.php` — extends core `RevisionRevertForm` (a confirm form). Builds a
  YAML `Diff` table (current config vs the chosen revision) via injected `diff.formatter` and the
  `system/diff` library; `submitForm()` writes the stored revision's config map back onto the live
  config object (`configFactory()->getEditable($name)->setData(...)->save(TRUE)`) and resets the
  target storage cache.

## Hooks & services

- `config_revision.module` → `src/EntityHooks.php` (`ContainerInjectionInterface`; injects
  `entity_type.manager`, `current_user`, `datetime.time`). `entityPostSave()` records a new
  revision for opted-in config entities; `entityPostDelete()` removes the revision record. See
  [../config/settings.md](../config/settings.md).
- `config_revision.services.yml` defines only the logger channel
  `logger.channel.config_revision` (used by `EntityForm`).

No plugin types, no Drush commands, no libraries of its own.
