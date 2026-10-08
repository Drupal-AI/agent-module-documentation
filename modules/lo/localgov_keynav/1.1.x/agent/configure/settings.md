<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring LocalGov KeyNav

## Permissions
- `Use LocalGov keynav` — users with this permission receive the shortcut library (unless they opted out).
- `Add LocalGov Keynav shortcuts` — required to reach the settings form.

## Settings form
Route `localgov_keynav.settings` → `admin/config/user-interface/localgov-keynav` (`Drupal\localgov_keynav\Form\SettingsForm`). It edits `localgov_keynav.settings`, notably `custom_keynav_patterns` (a textarea of custom key-sequence patterns).

## Per-user control
A boolean field `localgov_keynav` is added to user accounts (config `field.field.user.user.localgov_keynav`). When checked it **disables** KeyNav for that user. `localgov_keynav_preprocess_page()` attaches the `localgov_keynav/keynav` library and `drupalSettings.localgovKeyNav` only when the user has `Use LocalGov keynav` and the field is not set. `localgov_keynav_entity_field_access()` restricts view/edit of that field to permitted users.

## Sequences
Default sequences ship in `js/keynav-sequences.json`; `js/keynav.js` reads settings from `drupalSettings.localgovKeyNav` and performs navigation client-side.
