<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Creating and configuring popups

## Permissions
Grant as appropriate: `view popup entity`, `add popup entity`, `edit popup entity`, `delete popup entity`, and `administer popup entity` (the entity admin permission, which also short-circuits access checks in `PopupAccessControlHandler`).

## Create a popup
Add at `/popup_entity_popup/add`. Manage the list at `/admin/content/popup_entity_popup`; global settings at `/admin/structure/popup_entity_popup_settings`.

## Per-popup display fields
Read in `template_preprocess_popup_entity_popup()`:
- `width` / `height` — rendered as inline `width: N%` / `height: N%`.
- `position_x` / `position_y` — default `middle`; added as `popup_<x>` / `popup_<y>` classes.
- `open_delay` — ms before the popup shows (JS `setTimeout`).
- `times_to_show` — max impressions before it stops (0 = always); tracked in cookie `<id>_popup_count`.
- `cookies_expiration` — minutes the impression cookie lives.
- `breakpoints` — selected theme breakpoints; their media queries are joined and matched client-side so the popup only appears at matching widths.

## Visibility & rendering
`hook_page_bottom()` loads all published popups, keeps those passing `EntityContentVisibilityChecker::isVisible()`, and renders them with the `full` view mode. Template suggestions: `popup_entity_popup__<view_mode>` and `popup_entity_popup__<id>__<view_mode>`. Cache contexts/tags from the visibility service and theme are merged.

## Notes
- Popup body is composed of ordinary fields, so it is sanitized by the fields' formatters.
- Set `status` (published) to activate a popup; unpublish to remove it without deleting.
