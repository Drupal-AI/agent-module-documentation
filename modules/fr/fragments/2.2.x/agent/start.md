<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fragments (fragments) — agent index

Defines a **`fragment`** content entity type: fieldable, bundleable, revisionable and translatable
content that is designed to be **referenced/embedded elsewhere** rather than browsed on its own page.
It fills the gap between core block content (reusable but placed via block layout), paragraphs (fielded
but owned by a parent) and nodes (reusable but carrying a URL/listing/publishing apparatus). Bundles
are `fragment_type` config entities (like content types) configured at `/admin/structure/fragment-types`;
each fragment type gets its own fields via Field UI and its own set of per-type permissions. Editors
manage fragments from a listing at `/admin/content/fragments`, then reference them from other content
with an entity-reference field. There is a canonical page (`/fragment/{fragment}`) but it is deliberately
locked down — only editors with update/delete/admin rights may open a fragment on its own URL.

Everything is core-entity plumbing: a custom `route_provider` (`FragmentHtmlRouteProvider`) that adds the
revision routes and overrides canonical/collection access, a custom `access` handler
(`FragmentAccessControlHandler`) implementing the per-type view/create/update/delete logic, a dynamic
permission provider (`FragmentPermissions`), a Views-based admin screen that supersedes the default list
builder when **Views Bulk Operations** is installed, and optional integration with **Inline Entity Form**
and **Automatic Entity Label**.

- Depends on: nothing hard (no `dependencies:` in info.yml). Soft/suggested: `views_bulk_operations`,
  `inline_entity_form`, `auto_entitylabel` (only used when present). Core: `^10.3 || ^11`. PHP `>8.1`.
- Package: `Fragments`.
- Settings / `configure` route: **`entity.fragment_type.collection`** → `/admin/structure/fragment-types`
  (the fragment-type list; there is no module settings form).
- Permissions: yes — 3 static + 6 dynamic per fragment type (see [permissions/permissions.md](permissions/permissions.md)).
- Drush: none. Plugin types: none. Config schema: yes (`fragment_type` config entity).
- Provides one theme hook (`fragment`) and a JS library (`fragments/form`).

## What you'd do → where

- **Create a fragment type, add fields, set up displays / view modes** → [fields/fields.md](fields/fields.md)
- **Understand the base fields, entity keys, tables and how a fragment is themed/rendered** →
  [fields/fields.md](fields/fields.md)
- **Grant who-can-do-what (per-type view/create/edit/delete, the admin perms)** →
  [permissions/permissions.md](permissions/permissions.md)
- **Load/create/render fragments from code; routes, controller, storage, forms, revisions, hooks** →
  [api/entity-api.md](api/entity-api.md)

## Key facts (real machine names)

- Content entity: `fragment` (base_table `fragment`, data `fragment_field_data`, revision
  `fragment_revision`, revision-data `fragment_field_revision`; `show_revision_ui = TRUE`,
  `translatable = TRUE`, `common_reference_target = TRUE`). Bundle config entity: `fragment_type`
  (config_prefix `fragment_type`, `bundle_of = fragment`, `field_ui_base_route = entity.fragment_type.edit_form`).
- Entity keys: `id`, revision `vid`, bundle `type`, label `title`, `uuid`, uid `user_id`, `langcode`,
  status `status`.
- Handlers: storage `Drupal\fragments\FragmentStorage`, list `FragmentListBuilder`, views_data
  `Entity\FragmentViewsData`, access `FragmentAccessControlHandler`, route_provider(html)
  `FragmentHtmlRouteProvider`, forms `FragmentForm` (default/add/edit) + `FragmentDeleteForm`.
- Routes: `entity.fragment.collection` (`/admin/content/fragments`, perm `access fragments overview`),
  `entity.fragment.canonical` (`/fragment/{fragment}`, `_entity_access: fragment.view individual`),
  `entity.fragment.add_page` (`/fragment/add`), `entity.fragment.add_form` (`/fragment/add/{fragment_type}`),
  `entity.fragment.edit_form`, `entity.fragment.delete_form`, `entity.fragment.version_history`,
  `entity.fragment.revision`, `entity.fragment.revision_revert`, `entity.fragment.revision_delete`,
  `entity.fragment_type.collection` (`/admin/structure/fragment-types`, perm `administer fragment types`).
- Controller: `Drupal\fragments\Controller\FragmentController` (`revisionShow`, `revisionPageTitle`,
  `revisionOverview`, `loadFragmentRevision`).
- Service: `logger.channel.fragments`. Storage extras: `revisionIds()`, `userRevisionIds()`,
  `countDefaultLanguageRevisions()`, `clearRevisionsLanguage()`.
- Static permissions: `access fragments overview`, `administer fragment types`, `administer fragment entities`.
  Dynamic per type (via `FragmentPermissions::buildPermissionId($type,$op)` → `"$op $type fragments"`):
  `create`, `view`, `update`, `update own`, `delete`, `delete own`.
- Base fields: `title` (string 255, required, label), `status` (boolean, publishing), `user_id`
  (author, entity_reference→user), `created`, `changed`, `revision_translation_affected`.
- Theme hook `fragment` (render element `content`); suggestions `fragment__{view_mode}`,
  `fragment__{bundle}`, `fragment__{bundle}__{view_mode}`; template `templates/fragment.html.twig`.
- Library: `fragments/form` (`js/fragment-form.js`; deps `core/drupal.entity-form`, `core/drupalSettings`).
- Optional admin screen: `config/optional/views.view.fragments.yml` (view id `fragments`, page at
  `admin/content/fragments`) — installs only when `views_bulk_operations` is present.
