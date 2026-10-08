<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Access by Path (content_access_by_path) — agent index

info.yml name **"Content Access by Path"**, version **1.1.3**, package `Content`, core `^10 || ^11`.
Description: *"Restricts editing of content to specific sections for editors."* Depends on core
`field` and `taxonomy`. Ships one optional submodule, `content_access_by_path_admin_content`.

## What it does

Confines an editor to the parts of a site whose **node URL alias begins with a configured path**,
so a news team edits `/news/…` and other editors do not. The allowed sections for an editor are
driven by a **multi-value taxonomy reference field** on their user account.

The model has three moving parts, all created at install:

- A vocabulary `content_access_by_path` whose terms each carry a **`content_access_by_path`** text
  field — the section path(s), e.g. `news` or `news/sports` (a term's field is multi-value, so one
  term can list several paths).
- A **`content_access_by_path`** entity-reference field on the **user** entity, pointing at those
  terms (multi-value — a user can hold several sections). `hook_install()` places it on the default
  user form display as an autocomplete widget.
- A settings form listing the roles allowed to edit that user field.

## Enforcement (`content_access_by_path.module`)

- **`hook_node_access()`** — fires only for `update` and `delete`, and only when the acting user's
  `content_access_by_path` field has at least one value. For such a user it starts from
  `AccessResult::forbidden()`, then, for each section path taken from the user's terms (leading `/`
  added if missing), tests `strpos($alias, $section) === 0` against the node's alias
  (`path_alias.manager->getAliasByPath('/node/' . nid)`); on a match, access is allowed when the
  user is the node owner **or** holds `edit any <type> content` / `delete any <type> content`. The
  node owner is also allowed up front (so an editor is never locked out of their own content). Users
  whose field is empty get no opinion from the hook — normal Drupal access applies. Because this is
  entity-level node access, it governs the edit/delete surface generally (edit form, JSON:API/REST
  writes), not just the rendered page.
- **`hook_entity_field_access()`** — for `edit`/`delete` of the `content_access_by_path` field
  itself, allows only accounts whose roles intersect the configured `roles` list (config
  `content_access_by_path.settings`). This gates who may assign sections to users/terms.
- Cache metadata: the acting user, the node and each referenced term are added as cacheable
  dependencies, with `user` and `user.permissions` cache contexts.

## Submodule `content_access_by_path_admin_content`

`hook_views_query_alter()` on the `content` view (`/admin/content`): rewrites the query to only list
nodes the current sectioned user may edit — resolves each section path to node ids via a `LIKE`
prefix query on the `path_alias` table, unions in the user's own authored nodes, and shows an
empty-view message when nothing matches. This is a **listing filter only**; edit/delete are still
governed by the node-access hook above.

## Routes / config / permissions

- Route `content_access_by_path.settings` → `/admin/config/content/content-access-by-path`, form
  `SettingsForm`, permission **`Administer content access by path`** (note: the permission machine
  name is that capitalised, spaced string). Menu link under Configuration → Content.
- Config `content_access_by_path.settings` — key `roles` (sequence). Default install grants only
  `administrator`.
- No services, no Drush commands, no plugin types. Functional test coverage in
  `tests/src/Functional/ContentAccessTest.php`.
