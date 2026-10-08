<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Managing popups

All builder routes require `administer noahs_page_builder`:

- Create: `/admin/structure/noahs/create-popup`
- List: `/admin/structure/noahs/popup-list`
- Edit (builder): `/noahs-admin/noahs-popup/{noahs_editor}/{type}`
- Preview (iframe): `/noahs/{noahs_preview}/{type}`
- Toggle status: `/admin/noahs-popups/{noahs_id}/toggle`
- Delete: `/admin/noahs-popups/{noahs_id}/delete`

Save endpoint: POST `/noahs-popup-admin/save-popup` (`NoahsPopupsBuildController::savePopupSettings`) reads a JSON body (`noahs_id`, `settings`, `page_settings`, `popup_settings`, `langcode`, `css`) and upserts into `noahs_page_builder_popups`. Its route declares both `_access:'TRUE'` and `_permission:'administer noahs_page_builder'`; Drupal ANDs requirements, so it remains admin-gated.

Public display: `GET /noahs-popup/render/{noahs_id}` (`access content`) loads the saved popup for the current language and returns generated HTML for front-end display.
