<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Pixabay - agent index

Entity Browser widget that searches the Pixabay API and imports results as image media.
Depends on `media` + `entity_browser`. Configure key at `/admin/config/media/pixabay`.

Key files:
- `src/Api/PixabayApiService.php` - Guzzle GET to `https://pixabay.com/api/?<query>` (TLS verified by default).
- `src/Plugin/EntityBrowser/Widget/Pixabay.php` - widget: search (`validate()`), download via
  `system_retrieve_file()` in `prepareEntities()`, extension validation, media creation.
- `src/Form/PixabayApiConfigForm.php` - stores API key in `media_pixabay.admin.config` (plain config).

Permissions: `administer pixabay settings`. Config route: `media_pixabay.admin.config`.
Security: download URL comes from server-side API result (checkbox `#return_value`), not client input;
extensions validated against media type; API key is plain config (no Key entity). Version dir `3.0.x`.
