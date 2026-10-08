<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AT Internet SmartTag

Route: `/admin/config/system/atsmarttag/settings` (permission `administer atsmarttag`). All values are stored in the `atsmarttag.settings` config object and rendered into `drupalSettings.atsmarttag`.

## Loading the SmartTag library (`mode`)
- `url` — set `smarttag_url`; `ATSmartTagUtils::getLibraryInfoFromUrl()` registers it as an external header script.
- `file` — set `smarttag_file` (a managed file id); `getLibraryInfoFromFile()` serves it locally with `preprocess` aggregation.
- Optionally set `smarttag_library` to attach an additional named library.

## Analytics payload keys
- `site` — AT Internet site id.
- `collect_domain`, `collect_domain_ssl`, `secure` — collection endpoints.
- `disable_cookie`, `cookie_domain`, `cnil_exempt` — cookie / privacy behaviour.
- `label_type` — `path_alias` uses the current alias as page name; otherwise the resolved page title is used.
- `track.files` + `track.files_extensions` (large default extension regex in `ATSmartTagUtils::TRACKFILES_EXTENSIONS`), `track.mailto`, `track.outbound` — click tracking toggles.
- `chapters_from_breadcrumb` — when true, up to 3 `page_chapterN` values are built from the breadcrumb (home + empty-URL crumbs skipped).

## Extending
Implement `hook_atsmarttag_settings_alter(array &$settings)` to add or override any payload value before it is emitted.
