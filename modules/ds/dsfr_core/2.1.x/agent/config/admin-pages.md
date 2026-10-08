<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Core — admin pages & routes

All routes are in `dsfr_core.routing.yml`. The settings/theme/get-started/fields pages are handled
by `DsfrController` and `FieldsController` (`src/Controller/`). Menu links live in
`dsfr_core.links.menu.yml` under **Structure → DSFR** (parent `system.admin_structure`).

## Routes and permissions (verbatim from routing.yml)

| Route | Path | Controller | `_permission` |
|---|---|---|---|
| `dsfr_core.settings` | `/admin/dsfr` | `DsfrController::settingsModules` | `administer dsfr_core settings` |
| `dsfr_core.theme` | `/admin/dsfr/theme` | `DsfrController::theme` | `administer dsfr_core settings` |
| `dsfr_core.fieldmanage` | `/admin/dsfr/fields/{slug}` (slug default `block_content`) | `FieldsController::fieldsData` | `administer dsfr_core settings` |
| `dsfr_core.getstarted` | `/dsfr/get-started` | `DsfrController::getStarted` | `administer dsfr_core settings` |
| `dsfr_core.test_form` | `/dsfr/test/form` | `\Drupal\dsfr_core\Form\TestForm` | `administer dsfr_block settings` |

(Icon/pictogram routes are in [../browser/icons-pictograms.md](../browser/icons-pictograms.md).)
`configure` in `info.yml` points to `dsfr_core.settings`. The only permission this module defines is
`administer dsfr_core settings` (`dsfr_core.permissions.yml`); `administer dsfr_block settings` and
`access administration pages` are defined by other modules / core.

## `DsfrController::settingsModules()` — the `/admin/dsfr` landing
- Re-checks `administer dsfr_core settings` in code (returns `null` if absent) on top of the route
  permission.
- Uses `dsfr_core.tools` to: build the fields-manage link; call `checkTheme()` /
  `checkThemeActivated()` and add a warning message if the DSFR theme is missing or inactive; build
  get-started/icons/pictograms links; and `checkModules()` for `dsfr_menu`, `dsfr_paragraph`,
  `dsfr_twig_components` (each returns `check` + route links).
- Returns `['#theme' => 'dsfr_settings', '#dsfr' => $dsfr]` → `templates/dsfr-settings.html.twig`.

## `DsfrController::theme()` — `/admin/dsfr/theme`
- If the DSFR theme is present (`checkTheme()['missing'] == false`) returns a `RedirectResponse` to
  `system.theme_settings_theme` for theme `dsfr`; otherwise returns `null`. Pure redirect helper.

## `DsfrController::getStarted()` — `/dsfr/get-started`
- If the DSFR theme is present returns `['#theme' => 'dsfr_get_started']`
  (`templates/dsfr-get-started.html.twig`); otherwise `['#markup' => t('DSFR Theme is missing')]`
  (static translated string, no user data).

## `FieldsController::fieldsData($slug = 'block_content')` — `/admin/dsfr/fields/{slug}`
- Re-checks `administer dsfr_core settings` in code (returns `null` otherwise).
- Delegates to `dsfr_core.fieldManage`→`checkFieldsStorage($slug)`, which returns an HTML string
  listing every DSFR field and whether its `FieldStorageConfig` exists for that entity type, and
  wraps it as `['#type' => 'markup', '#markup' => ...]`. Read-only report — it does **not** create
  fields (installation is done programmatically by sibling modules; see field tooling doc).
- Both controllers also expose an `access(AccountInterface $account)` method returning
  `AccessResult::allowedIfHasPermission($account, 'administer dsfr_core settings')` (helper for other
  callers; the routes themselves are gated by `_permission`).

Templates for these pages: `templates/dsfr-settings.html.twig`, `templates/dsfr-get-started.html.twig`
(theme hooks registered in `dsfr_core_theme()`; see [../api/services-hooks.md](../api/services-hooks.md)).
