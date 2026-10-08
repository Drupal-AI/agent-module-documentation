<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Liveblog (liveblog) — agent index

**Live-blogging platform: a `liveblog` node type streaming `liveblog_post` entities to readers in real time via pluggable notification channels (Pusher).**

- **Version:** 2.0.x (2.0.0-alpha8)  ·  **Core:** ^10.2 || ^11
- **Entities:** `liveblog` node type + `liveblog_post` content entity (access handler `LiveblogPostAccessControlHandler`).
- **Routes:** post CRUD gated by `_entity_access` (`liveblog_post.view/update/delete`); `entity.liveblog_post.list` → `/liveblog/{node}/posts` (JSON, `_permission: access content`); admin settings `/admin/config/content/liveblog`.
- **Permissions:** `add|edit|delete|administer liveblog_post entity`, `administer liveblog settings`.
- **Plugins:** `@LiveblogNotificationChannel` (submodule `liveblog_pusher` provides the Pusher channel); REST resource `entity.liveblog_post`.
- **Depends on:** node, rest, taxonomy, views, simple_gmap, field, link, options, menu_ui, path, text, hal, serialization, language.

**Security:** the public post-list endpoint (`/liveblog/{node}/posts`, `access content`) returns only **published** posts — the query hard-codes `status=1` with `accessCheck()` and 404s on non-liveblog nodes; `liveblog_post` `view` access is `allowed()` by design (posts render on the public node). No unauthenticated write path (create/edit/delete are permission-gated). Low-severity note: `LiveblogListController::getList` (src/Controller/LiveblogListController.php:93-113) does not check the parent node's own view access/publish state before listing its published posts, so posts of an unpublished liveblog node may still be enumerable.

See [api/stream.md](api/stream.md) and [plugins/notification-channels.md](plugins/notification-channels.md).