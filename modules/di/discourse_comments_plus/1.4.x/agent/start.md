<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Discourse comments (+) (discourse_comments_plus) — agent index

Integrates a Discourse forum with Drupal: publishes nodes as Discourse topics, embeds their
replies as node comments, and lets visitors reply via Discourse SSO. Version **1.4.9**, core
`^10.3 || ^11.0`, license GPL-2.0-or-later. Project security-advisory coverage: **not-covered**.

## Dependencies
- Core `field` (only hard dependency; declared in `.info.yml`). `composer.json` has no `require`.
- Optional soft integrations (checked with `moduleExists`, not required): `token` (footer
  template tokens), `domain` / `domain_config` (per-domain absolute image URLs + config cache
  suffix).

## What it provides
- **Base field** `discourse_plus_field` on all node bundles (`hook_entity_base_field_info` in
  `.module`; field type `Plugin/Field/FieldType/DiscourseField.php`). Columns: `topic_id`,
  `topic_url`, `comment_count`, `push_to_discourse`, `category`. Widget
  `discourse_plus_widget` (`Plugin/Field/FieldWidget/DiscourseWidget.php`), formatter
  `comment_count_plus_formatter` (`Plugin/Field/FieldFormatter/CommentCountFormatter.php`).
  `hook_install` also creates a separate `field_discourse_plus` field storage and migrates data
  from the legacy `discourse_comments` module if present.
- **Blocks**: `discourse_comment_plus_block` (embeds a topic's posts under a node) and
  `latest_comments_plus_block` (recent replies across topics) — `Plugin/Block/*`.
- **Routes** (`.routing.yml`): settings form `discourse_comments_plus.discourse_comments_settings_form`
  (`/admin/config/discourse_comments_plus/discourse_comments_settings`, perm
  `administer site configuration`); SSO endpoint
  `discourse_comments_plus.discourse_comments_plus_sso` (`/discourse-comments/sso`, perm
  `access content`, `no_cache: TRUE`). No custom permissions file, no config schema.
- **Service** `discourse_comments_plus.discourse_api_client`
  (`DiscourseApiClient`) — Guzzle wrapper for the Discourse REST API + logger channel
  `logger.channel.discourse_comments_plus`.
- **Drush command** `fetch:latest_comments_plus` (alias `fetch_comments_plus`) —
  `Commands/FetchLatestComments.php`, registered via `drush.services.yml`.
- **Forms**: settings (`Form/DiscourseCommentsSettingsForm.php`), in-page reply form
  (`Form/DiscourseCommentForm.php`). **SSO controller**:
  `Controller/DiscourseCommentsSSOController.php`.
- Config object `discourse_comments_plus.discourse_comments_settings` (default values in
  `config/install/`). Templates in `templates/`.

## Solution docs
- Configuration & operation: [`agent/config/settings.md`](config/settings.md)
- Node → topic push, SSO reply flow, blocks, service & Drush: [`agent/api/integration.md`](api/integration.md)
- Field type / widget / formatter: [`agent/fields/discourse_field.md`](fields/discourse_field.md)
