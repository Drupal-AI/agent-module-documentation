<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Simplify (webform_simplify) — agent index

Trims Webform's admin UI for content editors and gates each webform settings section behind its
own granular permission. Depends on `webform >= 6.1`. Version **1.3.0**, core `^8 || ^9 || ^10 || ^11`.
Configure at `/admin/structure/webform/simplify` (permission `configure webform simplify`); config
object `webform_simplify.settings`. Nothing changes until an admin configures it.

## Two distinct mechanisms — do not conflate them

**1. Hiding (cosmetic, config-driven).** No enforcement; just removes controls from the UI.
- **Help** — `WebformSimplifyServiceProvider` decorates `webform.help_manager` with
  `WebformSimplifyHelpManager`, which returns empty help/index when `disable_help` is set.
- **Element edit form** (`hook_form_webform_ui_element_form_alter` → `WebformElementAlter`) — hides
  tabs, "features", and conditional-logic states/triggers/operators by setting `#access = FALSE`
  or removing option keys. Each element type has a `WebformSimplifyElement` plugin
  (`getFeatures()`, `getTabs()`, `getFeaturePropertyMap()`); the `_defaults` plugin (`Defaults::ID`
  = `_defaults`) supplies fallbacks for every element. Container fields hide themselves when all
  children become inaccessible.
- **Settings forms** — `WebformSettingsAlter` (confirmation types), `WebformFormSettingsAlter`
  (form sub-tabs), `WebformSubmissionsSettingsAlter` (submission sub-tabs), `WebformAccessSettingsAlter`
  (access roles/users/permissions). The access form swaps role checkboxes to the
  `webform_simplify_roles` element (`Element/WebformSimplifyRoles.php`), which **disables** but
  preserves pre-selected role values so a bypass user's settings are not clobbered.

**2. Enforcement (real access control).** `EventSubscriber/WebformRouteSubscriber` (RoutingEvents::ALTER)
rewrites the `_permission` requirement on the core webform routes `entity.webform.settings*` and
`entity.webform.handler*` to the module's granular permissions (see below). This is **ANDed** with
Webform's existing `_entity_access: webform.update`, so it only ever tightens access. It also turns
`entity.webform.settings` into `WebformGeneralSettingsController` — a redirect that sends the user to
the first settings tab they can actually access, or throws 403 if none. A new
`entity.webform.settings_general` route serves the general tab.

## Bypass logic — `webform_simplify_can_bypass()` (in `.module`)
- Users with the **`administrator`** role and **user 1** (when super-user is enabled) bypass ALL
  simplification, UNLESS `simplify_super_user` config is TRUE.
- Everyone else bypasses only with the **`bypass webform simplification`** permission (restricted).
- When a user can bypass, every `alter()` returns early → they see the full, unmodified Webform UI.

## Permissions (`webform_simplify.permissions.yml`)
- `configure webform simplify` — access the module's settings form.
- `edit any webform settings` (restricted; security warning) — umbrella, OR-ed into every gated route.
- `edit any webform general / form / submission / confirmation / asset / access / handler settings`
  — per-section gates on the settings/handler routes (not marked restrict-access, but still require
  `webform.update` entity access).
- `edit any webform element settings` (restricted) — declared for element-form gating.
- `bypass webform simplification` (restricted).

## Key files
- `webform_simplify.module` — 5 `hook_form_FORM_ID_alter` + `hook_local_tasks_alter` + bypass helper.
- `webform_simplify.services.yml` / `.routing.yml` / `.permissions.yml`.
- `src/WebformElementAlter.php` — the element-form hiding engine (tabs/features/conditions).
- `src/Plugin/WebformSimplifyElement/*` — one plugin per element type; base is
  `WebformSimplifyElementBase` (feature→property map), `TextBase` adds text-specific features.
- `src/EventSubscriber/WebformRouteSubscriber.php` + `src/Controller/WebformGeneralSettingsController.php`.
- `src/Form/WebformSimplifySettingsForm.php` — the config UI; `js/settings_form.js` cascades the
  `_defaults` checkboxes to every element's checkboxes.

## Guidance
- **Hiding ≠ forbidding.** A hidden control is still reachable via config export, `drush config:set`,
  another admin, or a site without the module. For a hard "must not edit handlers", rely on the
  permission gating (mechanism 2) or Webform's own permissions — not the cosmetic hiding.
- Default config hides nothing (`config/install/webform_simplify.settings.yml` is empty). The module
  is inert until configured; enabling it does not by itself restrict any existing admin.

## Security
Reviewed; no vulnerability found. Route changes tighten (AND) access rather than loosen it; all
config/output is admin-controlled and escaped (role names via `Html::escape`); alters only remove
controls (`#access = FALSE`) and never emit user data raw. See usage.md for the operator-facing model.
