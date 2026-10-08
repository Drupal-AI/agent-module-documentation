<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a **Pixabay** widget to an Entity Browser so editors can search the Pixabay stock-image API and import chosen images as media entities.

---

An admin sets the Pixabay API key at `/admin/config/media/pixabay` (`PixabayApiConfigForm`, permission `administer pixabay settings`); the key is stored in the `media_pixabay.admin.config` config object (plain config, not a Key entity). The widget plugin `Drupal\media_pixabay\Plugin\EntityBrowser\Widget\Pixabay` is added to an entity browser and configured with a target image media type, allowed extensions (loaded from the media type's source field), image size and upload location (supports the `[PIXABAY_SEARCH_TERM]` token). On search, `PixabayApiService::apiCall()` (`src/Api/PixabayApiService.php`) issues a Guzzle GET to `https://pixabay.com/api/?<query>` with the key; results are cached 24h. Selected images are downloaded in `prepareEntities()` via core `system_retrieve_file()` from the Pixabay-returned URL (checkbox `#return_value` holds the URL server-side, so users select among API results rather than supplying arbitrary URLs), then a media entity is created owned by the current user. Extensions are validated in `validate()` against both the widget config and the media type field before saving. Only one Pixabay widget per entity browser is supported. Security note: TLS verification uses Guzzle defaults (enabled); the API key sits in plain config; the download URL originates from the trusted Pixabay API response, not user input.

---

- Let editors add royalty-free Pixabay stock photos without leaving the entity reference/media form.
- Search Pixabay by keyword from inside an Entity Browser modal.
- Import a selected Pixabay image as a reusable image media entity.
- Store imported files under a configurable path, e.g. `public://Pixabay/[PIXABAY_SEARCH_TERM]/`.
- Pick the download resolution (180/340/640/1280, or full-HD/original with full API access).
- Restrict imported files to the media type's allowed extensions.
- Populate a media `pixabay_url` link field with the original Pixabay page URL when present.
- Cache Pixabay search results for 24 hours per search term to respect API rate limits.
- Tag imported images' alt text with the Pixabay tags returned by the API.
- Centralise the Pixabay API key in one admin form.
- Use tokens (via the token module) in the upload location path.
- Provide a stock-image source alongside other entity browser widgets (upload, view, etc.).
- Warn editors when the widget's allowed extensions drift from the media type's.
- Attribute imported media to the importing user (`uid` = current user).
- Build curated media libraries seeded from Pixabay searches.
- Limit who can change the API key via the `administer pixabay settings` permission.
