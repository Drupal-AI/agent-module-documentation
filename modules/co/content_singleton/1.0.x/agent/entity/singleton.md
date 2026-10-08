<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# content_singleton — the entity, constraint, access, permissions, hooks

Source: `src/Entity/ContentSingleton.php`, `src/Plugin/Validation/Constraint/*`,
`src/ContentSingletonAccessControlHandler.php`, `src/ContentSingletonPermissions.php`,
`src/ContentSingletonHelper.php`, `src/Hook/*`, `src/ContentSingletonViewsData.php`.

## The content entity

`ContentSingleton` (`#[ContentEntityType(id: 'content_singleton')]`) extends
`EditorialContentEntityBase`. Keys: `id`, `revision_id`, bundle `type`, `label`, `langcode`,
`uuid`, published `status`. `translatable: TRUE`, `show_revision_ui: TRUE`,
`bundle_entity_type: 'content_singleton_type'`, `admin_permission: 'administer content singletons'`.
Tables: `content_singleton`, `content_singleton_field_data`, `content_singleton_revision`,
`content_singleton_field_revision`. Revision metadata keys: `revision_user`, `revision_created`,
`revision_log`.

`baseFieldDefinitions()` adds/relabels: `label` (string, **required**, max 255, revisionable +
translatable, form weight -5) and `changed`. Publishing (`status`) and revision-log fields come
from the editorial base. `getLabel()`/`setLabel()` operate on `label`. `preSaveRevision()` carries
the previous revision-log message forward when saving without a new revision and with no new message.

Handlers: view builder = core `EntityViewBuilder`; `list_builder` = `ContentSingletonListBuilder`;
`views_data` = `ContentSingletonViewsData`; forms `default/add/edit` = `ContentSingletonForm`,
`delete` = core `ContentEntityDeleteForm`; `route_provider[html]` = `ContentSingletonRouteProvider`.
Entity `constraints: ['Singleton' => []]`. `field_ui_base_route: entity.content_singleton_type.edit_form`
(Manage fields/display live on the type edit form). Entity links include `collection`
(`/admin/content/singletons`), `canonical` (`/content-singleton/{id}`), add/edit/delete, and
`version-history`.

`ContentSingletonForm::save()` writes a status/log message and redirects to the collection; it
coerces a falsey `parent::save()` (non-default revision, e.g. a moderation draft) to `SAVED_UPDATED`
to honor the `int` return type.

## Singleton enforcement (the whole point)

`SingletonConstraint` (id `Singleton`, message `A @bundle_label singleton already exists.`) validated
by `SingletonConstraintValidator::validate()`: it queries the entity's storage for another entity of
the same `type`, excluding self (`id <> current`) when not new, and adds a violation if one exists.
So attempting to save a second entity of a bundle fails validation. (`ContentSingletonHelper` gives
the UI a positive check: `getExistingBundles()`, `getAllBundleIds()`, `hasAvailableBundles()`.)

## Access control

`ContentSingletonAccessControlHandler::checkAccess()`:
- `administer content singletons` → allowed for any operation (checked first).
- Otherwise, by operation: `view` → **allowed unconditionally if the entity is published**, else
  needs `view <bundle> content singleton`; `update` → `edit <bundle> content singleton`; `delete` →
  `delete <bundle> content singleton`; `view revision`/`view all revisions` →
  `view <bundle> content singleton revisions`; `revert` → `revert <bundle> …`; `delete revision` →
  `delete <bundle> …`. Adds the entity as a cacheable dependency.

`checkCreateAccess()`: returns neutral when no bundle is given; otherwise allowed if the account has
`edit <bundle> content singleton` **OR** `administer content singletons`. There is no separate
"create" permission — edit access on a not-yet-existing singleton is create access, and the
`Singleton` constraint stops a duplicate.

## Permissions

`content_singleton.permissions.yml`: static `administer content singletons` (restrict access) and
`access content singleton overview`; `permission_callbacks` →
`ContentSingletonPermissions::contentSingletonTypePermissions()`. Per bundle it generates six
(`buildPermissions()`): `view|edit|delete <id> content singleton` and
`view|revert|delete <id> content singleton revisions`.

## Hooks & integrations (`src/Hook/`)

- `ContentSingletonHooks::entityTypeBuild()` — when `mercury_editor` classes exist, sets a
  `mercury_editor` form class (`MercuryEditorContentSingletonForm`, an empty subclass of
  `ContentSingletonForm`) so bundles appear in ME.
- `ContentSingletonHooks::entityTypeAlter()` — when `content_moderation`'s `NodeModerationHandler`
  exists, overrides the `moderation` handler with it so the revision checkbox is forced TRUE for ERR
  (paragraphs) draft saves.
- `ContentSingletonThemeHooks` — `hook_theme` defines the `content_singleton` theme hook (template
  `content-singleton.html.twig`), `hook_theme_suggestions` adds view-mode/bundle suggestions, and
  `preprocessContentSingleton()` populates `content`/`view_mode`.

## Views

`ContentSingletonViewsData` extends core `EntityViewsData`; an optional admin listing view ships at
`config/optional/views.view.content_singleton_admin.yml` (installed only if Views is enabled).
