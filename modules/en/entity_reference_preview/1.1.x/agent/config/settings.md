<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, settings form, routes, permissions & manual controls

## Install / enable

`drush en entity_reference_preview`. No hard module dependencies; Views integration is registered only
if Views is enabled (`hook_install()` sets `views.settings` `display_extenders.entity_preview`).

## Config object — entity_reference_preview.settings

Install defaults (`config/install`): `enableDraftIndicator: true`, `enableToolbarIntegration: true`.
Schema (`config/schema`, type `config_object`): both booleans.

## Settings form — SettingsForm

`src/Form/SettingsForm.php`, route `entity_reference_preview.settings` at
`/admin/config/content/entity-reference-preview` (menu link under *Configuration → Content*), perm
`administer entity_reference_preview configuration`. Checkboxes:
- **Enable Draft Indicator** → `enableDraftIndicator`. On change, invalidates cache tag `erp_draft_indicator`.
- **Enable Toolbar Integration** → `enableToolbarIntegration`. On change, invalidates `erp_toolbar`.

## Permissions (entity_reference_preview.permissions.yml)

- `administer entity_reference_preview configuration` — `restrict access: true`; the settings form and
  the "Preview Detector" block (`PreviewDetectorBlock::blockAccess()`).
- `request entity_reference_preview preview` — the manual start/stop controls.
- `view entity_reference_preview indicator` — see the draft indicator.

## Manual preview controls

- **Route** `entity_reference_preview.controls` at `/admin/config/content/entity-reference-preview/controls`
  → `PreviewActionsForm` (`src/Form/PreviewActionsForm.php`), perm `request entity_reference_preview preview`.
  Start/Stop submit buttons call `CookiePreviewDetector::start()`/`stop()` (session flag). The form
  reports the current status and, when preview is driven by another detector (e.g. `rendered_entity`),
  hides the controls and shows which method is active. Standard Drupal FAPI form (CSRF-protected).
- **Toolbar** `PreviewDetectorToolbar` (`src/PreviewDetectorToolbar.php`) — added via
  `hook_toolbar_alter()` only when `enableToolbarIntegration` is on; shows a "Preview" tab colored by
  state and, for users with the request-preview permission, a "Change" link to the controls route
  (with `destination`).
- **Block** `entity_reference_preview_preview_detector` ("Preview Detector", category *Editorial*) —
  embeds `PreviewActionsForm`; block access requires `administer entity_reference_preview configuration`.

## Libraries

`entity_reference_preview.libraries.yml`: `indicator` (`css/indicator.css`) and `preview_controls`
(`css/controls.css`). No external/JS library dependencies.
