<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BlueSky Integration (bsky) — agent index

Thin Drupal wrapper around the **`potibm/phluesky`** PHP library for posting to **BlueSky
(AT Protocol)**. Package `Integrations`. Core `^10 || ^11`, PHP 8.2 (library min). License
GPL-2.0-or-later. Version 1.0.0-alpha4 (version dir 1.0.x).

Hard dependency: **`key`** (Key module) for credential storage. The four action plugins extend
**ECA**'s `ConfigurableActionBase`, so **ECA is required at runtime** to use them even though it is
not declared in `bsky.info.yml`. Composer libs: `potibm/phluesky`, `nyholm/psr7`,
`php-http/guzzle7-adapter`.

- **Settings form, config object/schema, the credential (Key) model, and the admin route/permission** →
  [config/settings.md](config/settings.md)
- **The `bsky.post_service` service and the four ECA action plugins (how a post is built and sent)** →
  [api/post-service-and-actions.md](api/post-service-and-actions.md)

## What it actually provides (from source)

- **One service** `bsky.post_service` → `Drupal\bsky\PostService` (implements `PostServiceInterface`),
  args `@config.factory`, `@key.repository`. Wraps library `BlueskyApi` + `BlueskyPostService`.
- **One config form** `Drupal\bsky\Form\SettingsForm` at route `bsky.admin.config`
  (`/admin/config/services/bsky`), permission `administer site configuration`. Writes config
  object `bsky.settings` (`handle`, `app_key` = a Key entity id).
- **Four ECA action plugins** in `src/Plugin/Action/`:
  - `bsky_create_post` — `CreatePost` (build a `Post` from a message string).
  - `bsky_add_facets` — `AddFacets` (link handles/hashtags/URLs).
  - `bsky_add_image` — `AddImage` (attach an image path/URL + alt text).
  - `bsky_send_post` — `SendPost` (publish the `Post` via the API).
- **No** entities, **no** permissions of its own, **no** Drush, **no** hooks, **no** new plugin
  types. Config schema present (`config/schema/bsky.schema.yml`), incl. the four
  `action.configuration.bsky_*` mappings.

## Flow

`CreatePost` serializes a `potibm\Bluesky\Feed\Post` into an ECA token; `AddFacets`/`AddImage`
unserialize it, mutate it, re-serialize; `SendPost` unserializes and calls
`PostService::sendPost()` → `BlueskyApi::createRecord()`. Credentials come from `bsky.settings`
(handle + Key value); the library does the authenticated AT Protocol HTTP over a PSR-18 client.
