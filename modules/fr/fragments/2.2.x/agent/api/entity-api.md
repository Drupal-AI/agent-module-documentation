# Entity API — routes, controller, storage, forms, hooks, revisions

The module ships **no `*.routing.yml`**. All routes are generated from the two entity types plus the
custom `FragmentHtmlRouteProvider`. The `fragment` content entity is defined in
`src/Entity/Fragment.php` (`@ContentEntityType`), the `fragment_type` config bundle in
`src/Entity/FragmentType.php` (`@ConfigEntityType`).

## Entity type `fragment`

- Class `Drupal\fragments\Entity\Fragment` extends `RevisionableContentEntityBase`, implements
  `FragmentInterface` (which extends `ContentEntityInterface`, `RevisionLogInterface`,
  `EntityChangedInterface`, `EntityOwnerInterface`).
- Tables: `fragment` (base), `fragment_field_data` (data), `fragment_revision` (revision),
  `fragment_field_revision` (revision data).
- Keys: `id`, revision `vid`, bundle `type`, label `title`, `uuid`, uid `user_id`, `langcode`,
  status `status`. Revision-metadata keys: `revision_user`, `revision_created`, `revision_log_message`.
- Flags: `show_revision_ui = TRUE`, `translatable = TRUE`, `admin_permission = "administer fragment entities"`,
  `bundle_entity_type = fragment_type`, `field_ui_base_route = entity.fragment_type.edit_form`,
  `common_reference_target = TRUE` (so it appears as an entity-reference target).
- `preCreate()` defaults `user_id` to the current user. `preSave()` falls back the owner to the
  anonymous user (`uid 0`) when none is set, and copies the owner into the revision author when the
  revision user is empty.

Handlers: `storage` = `FragmentStorage`, `view_builder` = core `EntityViewBuilder`, `list_builder` =
`FragmentListBuilder`, `views_data` = `Entity\FragmentViewsData`, `translation` =
`ContentTranslationHandler`, `access` = `FragmentAccessControlHandler`, forms
`default/add/edit` = `FragmentForm`, `delete` = `FragmentDeleteForm`, `route_provider[html]` =
`FragmentHtmlRouteProvider`.

## Entity type `fragment_type` (bundle)

Config entity, `config_prefix: fragment_type`, `config_export: {id, label, description}`,
`admin_permission = "administer fragment types"`, `route_provider[html]` = core
`AdminHtmlRouteProvider`. Config schema `config/schema/fragments_item_type.schema.yml` keys the
`fragments.fragment_type.*` config (`id`, `label`, `uuid`, `description`). Links include an
`auto-label` template (`/admin/structure/fragment-types/{fragment_type}/auto-label`) that is only wired
to a working form when the `auto_entitylabel` module is installed.

## Routes

Generated names/paths (verified at runtime, Drupal 11.x):

| Route name | Path | Access requirement |
|---|---|---|
| `entity.fragment.collection` | `/admin/content/fragments` | perm `access fragments overview` |
| `entity.fragment.canonical` | `/fragment/{fragment}` | `_entity_access: fragment.view individual` |
| `entity.fragment.add_page` | `/fragment/add` | `_entity_create_access` |
| `entity.fragment.add_form` | `/fragment/add/{fragment_type}` | `_entity_create_access` |
| `entity.fragment.edit_form` | `/fragment/{fragment}/edit` | `_entity_access: fragment.update` |
| `entity.fragment.delete_form` | `/fragment/{fragment}/delete` | `_entity_access: fragment.delete` |
| `entity.fragment.version_history` | `/fragment/{fragment}/revisions` | perm `access fragment revisions` |
| `entity.fragment.revision` | `/fragment/{fragment}/revisions/{fragment_revision}/view` | perm `access fragment revisions` |
| `entity.fragment.revision_revert` | `/fragment/{fragment}/revisions/{fragment_revision}/revert` | perm `revert all fragment revisions` |
| `entity.fragment.revision_delete` | `/fragment/{fragment}/revisions/{fragment_revision}/delete` | perm `delete all fragment revisions` |
| `fragment.revision_revert_translation_confirm` | `/fragment/{fragment}/revisions/{fragment_revision}/revert/{langcode}` | perm `revert all fragment revisions` |
| `entity.fragment_type.collection` | `/admin/structure/fragment-types` | perm `administer fragment types` |
| `entity.fragment_type.add_form` | `/admin/structure/fragment-types/add` | perm `administer fragment types` |
| `entity.fragment_type.edit_form` | `/admin/structure/fragment-types/{fragment_type}/edit` | `_entity_access: fragment_type.update` |
| `entity.fragment_type.delete_form` | `/admin/structure/fragment-types/{fragment_type}/delete` | `_entity_access: fragment_type.delete` |

`FragmentHtmlRouteProvider` (extends `AdminHtmlRouteProvider`):
- overrides `getCanonicalRoute()` to require the custom **`view individual`** operation so regular users
  cannot browse a fragment on its own page;
- overrides `getCollectionRoute()` to require `access fragments overview`;
- adds the five revision routes above.

> Operational note (not a security issue — fail-closed): the revision routes require the permissions
> `access fragment revisions`, `revert all fragment revisions` and `delete all fragment revisions`, but
> the module **does not declare these permissions anywhere** (they are absent from
> `fragments.permissions.yml` and `FragmentPermissions`). Because no role can be granted an
> undefined permission, the revision view/revert/delete routes are effectively reachable only by the
> superuser (uid 1). `FragmentController::revisionOverview()` additionally treats
> `administer fragment entities` as sufficient for the Revert/Delete links it renders, but the routes
> those links point to still gate on the undeclared permissions, so those actions 403 for a normal
> "administer fragment entities" user. If you need working revision UI for other roles, declare the
> three permissions in a small companion module.

## Controller

`Drupal\fragments\Controller\FragmentController` (services injected: `date.formatter`, `renderer`):
- `revisionShow($fragment_revision)` — loads a revision by id and returns the view-builder render array.
- `revisionPageTitle($fragment_revision)` — title callback.
- `revisionOverview(FragmentInterface $fragment)` — builds the revisions table; Revert/Delete links
  shown when the user has `revert all fragment revisions`/`delete all fragment revisions` **or**
  `administer fragment entities`.
- `loadFragmentRevision(int $fragment_revision): FragmentInterface`.

## Storage

`FragmentStorage extends SqlContentEntityStorage implements FragmentStorageInterface`. Extra methods
(all parameterized SQL against the revision tables):
- `revisionIds(FragmentInterface $entity): int[]`
- `userRevisionIds(AccountInterface $account): int[]`
- `countDefaultLanguageRevisions(FragmentInterface $entity): int`
- `clearRevisionsLanguage(LanguageInterface $language)`

## Forms

`FragmentForm` (default/add/edit) extends `ContentEntityForm`: defaults the "create new revision"
checkbox to TRUE, integrates `auto_entitylabel` (optional service
`auto_entitylabel.entity_decorator`, injected `NULL_ON_INVALID_REFERENCE`) to hide or make-optional the
`title` widget, moves `status` into a "Publishing status" vertical tab and `user_id` into "Authoring
information", attaches the `fragments/form` library, and redirects to `entity.fragment.collection` on
save. Other forms: `FragmentDeleteForm`, `FragmentRevisionDeleteForm`, `FragmentRevisionRevertForm`,
`FragmentRevisionRevertTranslationForm`, `FragmentTypeForm`, `FragmentTypeDeleteForm`.

## Hooks & services

- `hook_theme()` → theme hook `fragment` (render element `content`).
- `hook_theme_suggestions_fragment()` → `fragment__{view_mode}`, `fragment__{bundle}`,
  `fragment__{bundle}__{view_mode}`.
- `hook_help()` (`help.page.fragments`) renders `README.md`, via the `markdown` filter when available.
- Service: `logger.channel.fragments` (a logger channel).
- `FragmentViewsData` adds a "Fragment author" relationship on `user_id`, a `user_name` filter on
  `user_id`, and a `fragment_type` argument on `type`.

## Working with fragments from PHP

```php
$storage = \Drupal::entityTypeManager()->getStorage('fragment');

// Create + save (bundle = a fragment_type id you created).
$fragment = $storage->create(['type' => 'tip', 'title' => 'Opening hours']);
$fragment->set('field_body', '9–5, Mon–Fri');
$fragment->setPublished(TRUE);
$fragment->save();

// Render it in a given view mode.
$build = \Drupal::entityTypeManager()->getViewBuilder('fragment')->view($fragment, 'default');

// Reference it from another entity's entity_reference field targeting 'fragment'.
$node->set('field_fragments', ['target_id' => $fragment->id()]);
```
