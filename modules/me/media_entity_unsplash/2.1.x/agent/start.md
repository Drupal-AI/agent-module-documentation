<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity: Unsplash — agent index

A **media source for using Unsplash images as media entities**: editors search the Unsplash library
(autocomplete) or paste a photo ID/URL, and the module fetches the photo through the Unsplash API,
stores a local thumbnail image, and generates the photographer attribution. Version **2.1.0**
(branch `2.1.x`). Core `^11.3 || ^12`.

## Shape

- **Media source plugin** `unsplash` (`src/Plugin/media/Source/Unsplash.php`), extending `MediaSourceBase`.
  Source field is `string` (`field_media_unsplash`, holds the photo ID/URL). Metadata attributes: `id`,
  `description`, `photographer_name`, `photographer_username`, `photographer_url`, `attribution`.
- **Fetcher service** `media_entity_unsplash.unsplash_fetcher` (`src/UnsplashFetcher.php`) wraps the
  `unsplash/unsplash` PHP SDK (`Unsplash\HttpClient`, `Photo::find()`, `Search::photos()`) and caches
  responses in a dedicated `unsplash` cache bin (90-day expiry).
- **Autocomplete controller** (`src/Controller/UnsplashAutocompleteController.php`) at route
  `media_entity_unsplash.autocomplete` (`/api/media-entity-unsplash/autocomplete`): proxies an Unsplash
  photo search and returns JSON rows for the media add/edit form.
- **Media Library add form** `src/Form/UnsplashMediaLibraryAddForm.php` (extends `AddFormBase`).
- **Hooks** (`src/Hook/MediaEntityUnsplashHooks.php`, OOP `#[Hook]` + `#[LegacyHook]` shims in
  `.module`): attach autocomplete to the ID field on add/edit forms, show a thumbnail preview on edit,
  and on `entity_presave` copy the downloaded thumbnail into `field_media_unsplash_image`.

## Config & fields

- Source config keys (`config/optional/media.type.unsplash.yml`, schema `config/schema/…schema.yml`):
  `access_key`, `secret_key`, `utm_source`, `generate_thumbnails`, `thumbnails_directory`
  (`public://unsplash_thumbnails`), `height`, `width`. Both `access_key` and `secret_key` are required
  on the media type source configuration form.
- Fields on the `unsplash` media type: `field_media_unsplash` (ID/URL source field),
  `field_media_unsplash_image` (downloaded image), `field_media_unsplash_attribution` (auto-populated
  photographer credit, `text_long`).
- Access: uses the standard per-bundle media permissions (`create unsplash media`,
  `edit any/own unsplash media`); the module ships no `.permissions.yml` of its own. The autocomplete
  route is gated to holders of those permissions via a `_custom_access` check.
- `.install`: update 8201 removes a deprecated `use_unsplash_api` key; update 8202 adds the attribution
  field and `utm_source` to existing Unsplash media types.

## Diff 2.0.x → 2.1.x

- **Core requirement raised** to `^11.3 || ^12` (was `^10.3 || ^11`); Drupal 10 is dropped, Drupal 12 is
  supported. Stable **2.1.0** release (the documented 2.0.x branch was `2.0.0-alpha2`).
- **Dependencies broadened** beyond `image` to also declare core `media_library`, `path`, and `user`.
- **Third-party PHP SDK**: `composer.json` requires `unsplash/unsplash` (pinned dev-master commit); the
  fetcher uses it directly.
- **Attribution field** `field_media_unsplash_attribution` and an `attribution` metadata attribute,
  auto-populated with the "Photo by … on Unsplash" credit; new `utm_source` config for the tracking
  parameter in attribution links (update 8202).
- **In-Drupal search**: the autocomplete controller/route lets editors search Unsplash from the add/edit
  form instead of only pasting an ID/URL.
- Hook implementations converted to the OOP `#[Hook]` attribute style with `#[LegacyHook]` shims.
