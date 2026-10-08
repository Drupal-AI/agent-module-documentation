<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & operation

## Install / enable
`drush en discourse_comments_plus -y`. Requires core `field`. On install
(`discourse_comments_plus_install`) the module creates the `field_discourse_plus` field storage
and, if the legacy `discourse_comments` module is present, migrates its `field_discourse` data on
`node_field_data`/`node_field_revision` into the `discourse_plus_field__*` columns and deletes the
old field. A revisionable/translatable base field `discourse_plus_field` is attached to every node
bundle via `hook_entity_base_field_info`. Uninstall deletes the field + storage.

## Settings form
Route `discourse_comments_plus.discourse_comments_settings_form` →
`/admin/config/discourse_comments_plus/discourse_comments_settings`, permission
`administer site configuration` (`_admin_route`), also linked from the config Services menu
(`.links.menu.yml`). Handler: `Form\DiscourseCommentsSettingsForm` (a `ConfigFormBase`).

## Config object
Single editable object `discourse_comments_plus.discourse_comments_settings` (defaults in
`config/install/`). **There is no config schema shipped** (`provides_config_schema: false`), so
these keys are untyped:

| Key | Meaning |
|-----|---------|
| `base_url_of_discourse` | Public Discourse URL (no trailing slash), required. |
| `checkbox_internal_base_url_of_discourse` | Whether a separate internal URL is used. |
| `internal_base_url_of_discourse` | Internal/proxy Discourse URL for server-side API calls. |
| `sso_secret` | DiscourseConnect shared secret (HMAC key), required. |
| `api_key` | Discourse API key used for all server-side calls, required. |
| `api_user_name` | Discourse API username, required. |
| `cache_lifetime` | Minutes; used as block `max-age` and latest-comments cache TTL (default 60). |
| `footer_template` | Full-HTML text_format value appended to pushed posts (node tokens). |
| `default_category` | Default Discourse category id for new topics. |
| `overridden_default_category_content_types` | Content types that override the default category. |
| `overridden_default_category_options` | Per-content-type category id overrides. |
| `content_types_enabled_for_discourse` | Content types where "Push to Discourse" defaults on. |

Server-side API calls prefer `internal_base_url_of_discourse` (when set) for the request host, but
build public links (topic URLs, avatars) from `base_url_of_discourse` — see
`DiscourseApiClient::__construct` (`$this->baseUrl` vs `$this->publicUrl`).

## Category loading
When base URL + API key + username are all set, `buildForm` calls
`DiscourseApiClient::getCategories()` (`GET /categories.json`, cached 12h) to populate the default
category select and per-content-type overrides. A "Refresh Category List" AJAX button
(`refreshCategoriesCallback`) tests *unsaved* credentials by calling
`DiscourseApiClient::setTemporaryCredentials()` / `restoreOriginalCredentials()` around a fresh
fetch. The `token` module, if enabled, adds a token browser to the footer template field.

## Operating notes
- Categories cache 12h; latest-comments and topic blocks respect `cache_lifetime`.
- Warm the latest-comments cache with `drush fetch:latest_comments_plus` (alias
  `fetch_comments_plus`) — run it from cron/scheduler; it invalidates the
  `latest_comment_plus_block` cache tag.
- Blocks to place: `discourse_comment_plus_block` on node pages, `latest_comments_plus_block`
  anywhere. Optional field formatter `comment_count_plus_formatter` prints the stored reply count.
- If `domain` is enabled, node body `/sites/...` image `src` values are rewritten to the node's
  domain host before push; otherwise the current request host is used.
