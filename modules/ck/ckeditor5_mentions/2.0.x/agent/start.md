<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Mentions (ckeditor5_mentions) — agent index

CKEditor 5 `@`/`#`-style mention autocomplete for Drupal. Site builders define
`mention_feed` config entities (marker + target entity type/bundle + optional static
items); typing the marker in a CKEditor 5 field opens a dropdown filled over AJAX from a
JSON endpoint, and picking a result inserts `<span class="mention" data-mention>` markup.

- **Machine name:** `ckeditor5_mentions` — package `CKEditor5`.
- **Core:** `^9.4 || ^10 || ^11`. No declared module or composer dependencies (relies on core `ckeditor5`, `editor`, `filter`). License GPL-2.0-or-later.
- **Configure:** route `entity.mention_feed.collection` → `/admin/config/content/mention-feed`.

## Provides

- **Config entity** `mention_feed` (`src/Entity/MentionFeed.php`): fields `marker`,
  `minimum_characters`, `entity_type`, `entity_bundle`, `feed_callable`, `feed_items[]`.
  admin_permission `administer mention_feed`. Default feeds installed: `mention` (@/user),
  `hashtag` (#/taxonomy_term:tags), `select` (+/node:article).
- **CKEditor 5 plugin** `ckeditor5_mentions_mention` (PHP `src/Plugin/CKEditor5Plugin/Mention.php`,
  JS `mention.Mention` + `mentionsIntegration.MentionsIntegration`): configurable per text
  format — enabled feeds, `dropdown_limit`, `commit_keys`. Allows `<span class="mention" data-mention>`.
- **Routes** (`ckeditor5_mentions.routing.yml`): `ckeditor5_mentions.annotations`
  (`GET /ckeditor5/api/annotations`, `_permission: mention users`, JSON) → autocomplete;
  the `entity.mention_feed.*` admin CRUD routes (`_permission: administer mention_feed`).
- **Permissions** (`ckeditor5_mentions.permissions.yml`): `mention users`, `to be mentioned`.
- **Controller** `MentionAutocompleteController::annotation()` — queries the feed's entity
  type by label/name/mail CONTAINS and returns `{id: marker+label, link: ''}` results.
- **Services** (`ckeditor5_mentions.services.yml`): `data_provider.mentions`
  (`MentionDataProvider::getPrivilegedEditors()`), `mention_settings`, `mentions_helper`,
  `element.mentions_integration`, `config_handler.settings`, `mention_integrator`, `html_helper`.
- **Element process** `MentionsIntegration::processElement()` — attaches drupalSettings
  (annotations URL, enabled feeds, dropdown limit) to `text_format` elements for users with `mention users`.

## Solution docs

- [Mention feed entity & install/config](agent/config/mention-feed.md)
- [Autocomplete endpoint & CKEditor integration](agent/api/autocomplete.md)
