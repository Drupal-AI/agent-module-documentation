<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Web Doc content type, fields and displays

All defined as recipe config under `recipes/default/config/`. Manage after install at `/admin/structure/types/manage/webdoc`.

## Content type `webdoc`
`node.type.webdoc.yml`: label "Web Doc", `new_revision: true` (every save is a new revision), `preview_mode: 1` (preview optional), `display_submitted: true`. Description: "Use *Web Doc* to add documentation pages to the documentation section." Registered with Book via `book.settings` so a page can be placed in a book outline and can have Web Doc children.

## Body field
- `field.storage.node.body` — shared core `body` storage, type `text_with_summary`, cardinality 1, translatable.
- `field.field.node.webdoc.body` — instance on `node.webdoc`, label "Body", optional, `display_summary: true`. This is the only added field; title, author, dates, path and moderation come from base/other modules.

## Form display (`node.webdoc.default`)
Widgets, top to bottom: title (string textfield), body (`text_textarea_with_summary`, 9 rows / 3 summary rows), uid (entity_reference_autocomplete), created (datetime), path (pathauto alias), url_redirects, moderation_state (`moderation_state_default` — content_moderation), status (boolean checkbox). `promote` and `sticky` are hidden.

## View displays — Display Builder driven
The three view displays use `third_party_settings.display_builder` with `profile: default` (imported by the recipe as `display_builder.profile.default`). Display Builder — **not** Layout Builder — owns the layout; `manage_display` supports the display management UI.

- **default** (`node.webdoc.default`): sources = the body field (`field_formatter:node:webdoc:body` → `text_default`, label hidden) and a `block` source `book_navigation` (Book navigation block, "all pages"). Content region renders title (h2, linked), links, body. `created` and `uid` hidden.
- **full** (`node.webdoc.full`): same source set (body `text_default` + `book_navigation` block); same title/links/body layout. The `node.full` view mode ships disabled (`status: false`) — enable it to use per-mode overrides.
- **teaser** (`node.webdoc.teaser`): sources = title (`title` formatter, linked h2) and body (`text_summary_or_trimmed`, trim 300 in the source / 600 in the content region). Used for listings; `created`/`uid` hidden.

## URL aliases (pathauto)
`pathauto.pattern.webdoc`: pattern `web-doc/[node:book:parents:join-path]/[node:title]`, scoped to bundle `webdoc`, weight -5. A page nested in a book gets an alias mirroring its book path, e.g. `/web-doc/getting-started/installation`.

## Permissions / who can author
The recipe grants the `content_editor` role: `create webdoc content`, `edit own webdoc content`, `delete own webdoc content`, `view webdoc revisions`, plus book perms (`access book list`, `add content to books`, `create new books`). Administrators author via the usual node permissions. Anonymous receives nothing from the recipe.

## Editor workflow
1. Go to `/node/add/webdoc`, enter a title and body.
2. Under "Book outline", create a new book or attach the page under an existing Web Doc parent.
3. Save — a revision is created, the pathauto alias is generated from the book path, and the page renders via Display Builder with a Book navigation block.

## Screenshots
Manage-fields for the created Web Doc type (`/admin/structure/types/manage/webdoc/fields`):

![Web Doc content type — Manage fields, showing the Body field](../../../../../../../screenshots/webdoc/12.0.x/webdoc-manage-fields.png)

The Web Doc create form (`/node/add/webdoc`) with title, body, and Book outline:

![Web Doc node add form](../../../../../../../screenshots/webdoc/12.0.x/webdoc-node-add.png)
