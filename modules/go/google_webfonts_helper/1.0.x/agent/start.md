<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Webfonts Helper (google_webfonts_helper) — agent index

Self-hosts Google Fonts. An admin adds `google_webfont` config entities; on save the module
downloads the chosen font files from the **google-webfonts-helper** service
(`https://gwfh.mranftl.com`), extracts them into the site's files, generates the `@font-face`
CSS, and exposes each font as a dynamic asset library `google_webfonts_helper/<entity_id>`
you attach where you want the font used. Purpose is GDPR/privacy (no visitor request reaches
Google) plus performance.

- **No `composer` deps beyond core** except `symfony/finder` (`^4.4|^5.0|^6.2|^7.0`); no
  Drupal module dependencies. Core `^9 || ^10 || ^11`.
- **Configure route:** `entity.google_webfont.collection` → `/admin/config/system/google-webfonts-helper`.
- Defines **1 permission**, **no drush commands**, **no plugin types**. Provides config schema.
- Newest release on this branch is **8.x-1.0-alpha14** (alpha — no stable release exists).

## Do X → read

- **Add / manage a self-hosted font (the main task)** → [configure/fonts.md](configure/fonts.md)
- **Change where font files are written (`fonts_path`)** → [configure/settings.md](configure/settings.md)
- **Who can administer fonts** → [permissions/permissions.md](permissions/permissions.md)
- **Attach the generated font library / the CSS template** → [theme/library.md](theme/library.md)
- **Trigger a download or generate CSS from code (services)** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Config entity type: `google_webfont` (config prefix `google_webfonts_helper.google_webfont.*`).
- Settings config object: `google_webfonts_helper.settings`, key `fonts_path`
  (default `public://google-webfonts-helper`).
- Permission: `administer google_webfonts_helper` (also the entity `admin_permission`).
- Routes: `entity.google_webfont.collection|add_form|edit_form|delete_form`,
  `google_webfonts_herlper.settings` (note the misspelled route id `herlper`).
- Services: `google_webfonts_helper.rest_api`, `.font_downloader`, `.style_generator`,
  `.font_manager`, `.file_system_manager`, cache bin `cache.google_webfonts_helper`.
- Theme hook: `google_webfonts_helper_style` (template
  `google-webfonts-helper-style.html.twig`). Dynamic libraries via
  `hook_library_info_build()`, one per font entity.
- External service base URL: `https://gwfh.mranftl.com` (`RestApi::BASE_URL`).
