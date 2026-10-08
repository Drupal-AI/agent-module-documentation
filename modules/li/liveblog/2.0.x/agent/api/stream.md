<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Post stream endpoints

**Public list** — `entity.liveblog_post.list`,
`GET /liveblog/{node}/posts` (`_format: json`, `_permission: access content`,
`node: \d+`). Handled by `LiveblogListController::getList()`:

- 404s unless `$node->bundle() == 'liveblog'`.
- Query params: `items_per_page` (default 10), `created` (timestamp cursor),
  `created_op` (`<` or `>`, default `>`), `sort_order` (`ASC`/`DESC`, default
  `DESC`).
- Query filters `status = 1` (published only), matches
  `liveblog.entity.nid == node`, sorts by `created`, ranges to the page, and
  runs `->accessCheck()`. Each post is rendered and returned as JSON with the
  libraries/commands needed for the front end.
- **Note:** it does not re-check the parent node's view access before listing;
  it relies on the posts themselves being published.

**Edit form as JSON** — `entity.liveblog_post.edit_form_json`,
`/liveblog_post/{liveblog_post}/edit` (`_format: json`,
`_entity_access: liveblog_post.update`) → `LiveblogController::getFormAsJson()`
returns the edit form wrapped by `LiveblogRenderer` (ajax commands + libraries).

**Entity CRUD** — canonical/edit/delete routes all use `_entity_access`
(`liveblog_post.view|update|delete`). `LiveblogPostAccessControlHandler`:
`view` → allowed (shown on the public node page); `update`/`delete`/create →
`edit|delete|add liveblog_post entity` permissions.

**REST** — `rest.resource.entity.liveblog_post` exposes the post entity via the
core REST module for headless posting.
