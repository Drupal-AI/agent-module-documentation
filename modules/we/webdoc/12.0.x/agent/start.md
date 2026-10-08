<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Doc (webdoc) — agent index

Version **12.0.1** (dir `12.0.x`). Core `^11.4 || ^12`. License GPL-2.0-or-later. Part of the Webship `web*` suite. Maintainer: Webship.

A **recipe-only config bundle**: it ships no services, routes, permissions, plugins or config schema. Its only PHP is `webdoc.install` (`webdoc_install()`), which — unless config is syncing — applies `recipes/default` via `RecipeRunner`. Everything the module "does" is the config that recipe provisions.

## Dependencies
- info.yml hard dependency: `display_builder:display_builder_entity_view`.
- composer `require` (minus core): `drupal/book ~3.0`, `drupal/manage_display ~3.0`, `drupal/pathauto ~1.0`, `drupal/display_builder ^1.0@beta`.
- The recipe `install`s: `book`, `node`, `menu_ui`, `manage_display`, `pathauto`, `text`, `display_builder`, `display_builder_entity_view`, `display_builder_ui`, then `webdoc`.

## What it provisions
- Node type `webdoc` ("Web Doc") — new revisions on, optional preview, submitted info shown; registered with Book (`book.settings` allowed_types).
- Field `body` (text_with_summary) on `node.webdoc` + reused `field.storage.node.body`.
- View modes `node.teaser` and `node.full`; a default form display; three view displays (default/full/teaser) driven by **Display Builder** (`profile: default`) rendering body + a `book_navigation` block.
- Pathauto pattern `webdoc`: `web-doc/[node:book:parents:join-path]/[node:title]`.
- Grants to role `content_editor`: create/edit-own/delete-own webdoc content, view webdoc revisions, access book list, add content to books, create new books.

## No configure route
No settings form. Manage the created type at `/admin/structure/types/manage/webdoc` and its displays via Display Builder after install.

## Solution docs
- [recipe/default.md](recipe/default.md) — what `recipes/default` installs and provisions, key by key.
- [content-type/webdoc.md](content-type/webdoc.md) — the Web Doc type, body field, view modes, displays, pathauto and how an editor uses it.
