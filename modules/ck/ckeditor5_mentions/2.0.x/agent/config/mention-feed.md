<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mention feeds: install, entity, config, permissions

## Install / enable
`drush en ckeditor5_mentions`. Requires core CKEditor 5 (`ckeditor5`, `editor`, `filter`);
no contrib deps. On install three default `mention_feed` config entities are created from
`config/install/`: `mention` (marker `@`, user/user), `hashtag` (marker `#`,
taxonomy_term/tags), `select` (marker `+`, node/article).

## The `mention_feed` config entity
Class `src/Entity/MentionFeed.php` (`@ConfigEntityType id = "mention_feed"`,
`config_prefix = "mention_feed"`, `admin_permission = "administer mention_feed"`).
Config-exported keys (schema in `config/schema/ckeditor5_mentions.schema.yml`,
`ckeditor5_mentions.mention_feed.*`):

- `id`, `label`, `description` — machine name, title, help text.
- `marker` (string, 1 char) — trigger character (`@`, `#`, `+`, …).
- `minimum_characters` (int 0–10) — chars typed before the dropdown opens.
- `entity_type` / `entity_bundle` — what to search; bundle optional (`- All -`).
- `feed_callable` (string) — present in schema/form (hidden field) but not consumed by the
  2.0.0 autocomplete controller; effectively inert.
- `feed_items` (sequence of strings) — extra static suggestions, one per line, each expected
  to begin with the feed's marker (e.g. `@siteadmin`).

Managed by `src/Form/MentionFeedForm.php` (`EntityForm`). `submitForm()` splits the
Feed Items textarea on `\r\n` into an array. Entity-type/bundle option lists come from
`ckeditor5_mentions_all_entity_types()` / `ckeditor5_mentions_get_entity_bundles()` in the
`.module` file (bundle select reloads via AJAX `reloadBundle()`).

## Routes & permissions
Admin CRUD (`ckeditor5_mentions.routing.yml`, all `_permission: administer mention_feed`):

- `entity.mention_feed.collection` → `/admin/config/content/mention-feed` (list builder
  `MentionFeedListBuilder`) — this is the module's `configure` route.
- `.add_form`, `.edit_form` (`/{mention_feed}`), `.delete_form` — add/edit/delete.

(The entity annotation also declares `/admin/structure/mention-feed*` link paths, but the
routing file registers the `/admin/config/content/...` paths; use the routing paths.)

Two functional permissions (`ckeditor5_mentions.permissions.yml`):
- `mention users` — required to use mentions and to reach the autocomplete endpoint; also
  gates whether `MentionsIntegration::processElement()` attaches the feed settings to editors.
- `to be mentioned` — per-user opt-in checked by `MentionDataProvider::getPrivilegedEditors()`.

## Enabling on a text format
Edit a text format/editor (`/admin/config/content/formats`) using CKEditor 5, enable the
**Mentions Configuration** plugin, tick the feeds under "Enabled mention feeds", and set the
"Dropdown limit" (5–50). Config schema `ckeditor5.plugin.ckeditor5_mentions_mention` stores
`dropdown_limit`, `commit_keys`, `mention_feeds_enabled`. The plugin allows the
`<span class="mention" data-mention>` element so stored mentions survive filtering.
