Adds @/#-style mention autocompletion to CKEditor 5, suggesting matching entity labels (users, taxonomy terms, nodes, or a static list) from configurable "mention feeds".

---

CKEditor5 Mentions lets site builders define one or more `mention_feed` config entities, each with a trigger marker (such as `@`, `#`, or `+`), a target entity type and bundle to search, and an optional list of static feed items. On any CKEditor 5 field whose text format enables the "Mentions Configuration" plugin and one or more feeds, typing the marker opens an autocomplete dropdown populated over AJAX from a JSON endpoint (`/ckeditor5/api/annotations`). Selecting a suggestion inserts an inline `<span class="mention" data-mention>` element into the markup. Access is gated by two permissions: `mention users` controls who can use mentions and query the endpoint, and `to be mentioned` is a per-user opt-in used by the module's data-provider helper. Feeds and per-format behavior (enabled feeds, dropdown limit) are configured through an admin UI at `/admin/config/content/mention-feed` and the text-format editor settings.

---

- Add `@username` mentions of site users inside comment bodies or node fields.
- Add `#tag` autocompletion backed by taxonomy terms (e.g. the Tags vocabulary).
- Add `+article` autocompletion that suggests node titles of a chosen content type.
- Offer autocompletion of any entity type/bundle that exposes a label (users, terms, nodes, media, etc.).
- Provide a curated static list of mention targets via per-feed "Feed Items" without querying entities.
- Restrict who can insert mentions using the `mention users` permission on trusted editor roles.
- Let individual users opt in to being mentionable with the `to be mentioned` permission.
- Configure a custom trigger marker per feed (single character such as `@`, `#`, `+`, `!`).
- Set a minimum number of typed characters before the dropdown appears, per feed.
- Cap the number of autocomplete suggestions shown via the plugin's "Dropdown limit".
- Enable different feeds on different text formats (e.g. mentions on comments but not basic pages).
- Combine multiple feeds (users and tags) on the same editor by enabling several feeds.
- Insert mentions inside CKEditor 5 collaboration/comment editors where available.
- Search users by username substring during autocompletion.
- Add mention support to custom entity forms that render a `text_format` element.
- Style rendered mentions with CSS by targeting the `.mention` / `data-mention` markup.
- Manage feeds (add, edit, delete) through the `/admin/config/content/mention-feed` list UI.
- Ship default `@` (users), `#` (tags), and `+` (article nodes) feeds on install as starting points.
- Localize/label feeds with human-readable titles and descriptions shown in the plugin settings.
- Limit suggestions to a single bundle of an entity type (e.g. only "article" nodes).
- Auto-restrict suggestions to published entities for entity types that have a published key.
- Build mention-driven notification or linking workflows on top of the stored `data-mention` markup.
