<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Mautic Integration (advanced_mautic_integration) — agent index

Integrates Drupal with **Mautic** (open-source marketing automation). Two halves: (1) embeds the
Mautic `mtc.js` tracking snippet on Condition-API-selected pages + a link/download tracking library;
(2) wraps the Mautic REST API (`mautic/api-library`, Basic Auth) and syncs Drupal users → Mautic
contacts on user insert/update. Package `Statistics`. Depends on **`token`**. Core `^10 || ^11`.
Installed 1.0.0-beta2. No config schema, no Drush, no new plugin types (it *consumes* core Condition
plugins). License GPL-2.0-or-later.

## Solution docs
- **Settings form, config object keys, tracking snippet & visibility** → [config/settings.md](config/settings.md)
- **API wrapper service + user→contact synchronizer (custom API usage)** → [api/api.md](api/api.md)

## What it actually provides (from source)
- **1 route / 1 permission**: `advanced_mautic_integration.admin_settings_form` at
  `/admin/config/services/adv-mautic`, `_permission: 'administer advanced mautic integration'`
  (`*.routing.yml`, `*.permissions.yml`), menu link under *Configuration → Services*
  (`*.links.menu.yml`). Config route id is the `configure` value.
- **4 services** (`*.services.yml`):
  - `advanced_mautic_integration.visibility` → `VisibilityTracker` — decides whether the snippet is
    shown, by resolving stored Condition plugins (`plugin.manager.condition`).
  - `advanced_mautic_integration.script` → `MauticScript` — builds the inline `mtc.js` loader string
    and the `drupalSettings` tracking config.
  - `advanced_mautic_integration.api` → `MauticApiWrapper` (implements `MauticApiWrapperInterface`) —
    `getApi($context)` returns a `\Mautic\Api\Api` bound to the configured URL + Basic Auth.
  - `advanced_mautic_integration.user_synchronizer` → `UserSynchronizer`
    (implements `UserSynchronizerInterface`) — `push()`, `getLeadIdForUser()`, `convertUserToLead()`,
    `getLeadByParameter()`.
- **1 config object**: `advanced_mautic_integration.settings` (`track.*`, `api.*`, `visibility`).
- **1 form**: `Form\MauticAdminSettingsForm` (extends `ConfigFormBase`).
- **1 library**: `advanced_mautic_integration/tracking_events` (`js/tracking_events.js`, deps
  `core/drupal`, `core/once`) exposing `Drupal.mt_send()` and `Drupal.behaviors.advancedMauticIntegrationTrackingEvents`.
- **Hooks** (`*.module`): `hook_help`, `hook_page_attachments` (injects the script when
  `VisibilityTracker::isVisible()` is true), `hook_user_insert`/`hook_user_update` (calls the
  synchronizer, errors caught + logged to the `advanced_mautic_integration` channel).
- **No** entities, no config schema files, no `config/install`, no submodules, no Drush.
