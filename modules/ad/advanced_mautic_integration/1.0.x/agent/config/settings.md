<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, tracking snippet & visibility

Install/enable: `composer require drupal/advanced_mautic_integration` (pulls `mautic/api-library`),
then `drush en advanced_mautic_integration`. Requires the `token` module. Configure at
**`/admin/config/services/adv-mautic`** (route `advanced_mautic_integration.admin_settings_form`,
permission `administer advanced mautic integration`).

## Config object: `advanced_mautic_integration.settings`

Written by `Form\MauticAdminSettingsForm::submitForm()`. There is **no `config/schema`** and **no
`config/install`** shipped — the object is created on first save. Keys:

- `track.url` — Mautic base URL (used to build `<url>/mtc.js`). Empty ⇒ tracking disabled.
- `track.pageviews`, `track.outbound`, `track.mailto`, `track.tel`, `track.files` — booleans.
- `track.files_extensions` — pipe-separated extension list/regex (e.g. `pdf|doc|zip`).
- `track.default_parameters` — a JSON string sent with each event; Token-enabled (default seeds
  `{"email":"[current-user:mail]"}`).
- `api.url` — Mautic API endpoint (e.g. `https://mautic.example.com/api`). Empty ⇒ API disabled.
- `api.user`, `api.password` — Basic Auth credentials.
- `api.synchronize_user` — bool; enables user→contact sync.
- `api.user_lead_mapping` — newline list of `drupal_field|mautic_field` pairs.
- `visibility` — Condition-plugin configuration array (block-style).

`buildForm()` renders three fieldsets (JS snippet, API, visibility). `validateForm()` trims URLs,
requires them to pass `UrlHelper::isValid($url, TRUE)`, validates `track.default_parameters` as JSON,
enforces the `field|field` mapping format, and — when an API URL is set — requires user/password
(re-using the stored password when the field is left blank, since the `#type => 'password'` field is
not re-populated).

## Visibility — `VisibilityTracker` (service `advanced_mautic_integration.visibility`)

`isVisible(BubbleableMetadata)` returns FALSE immediately if `track.url` is empty. Otherwise it loads
the stored `visibility` config into a `ConditionPluginCollection` over `plugin.manager.condition`,
applies runtime contexts via `context.handler`/`context.repository`, and ANDs the results
(`resolveConditions($conditions, 'and')`). Missing-context ⇒ deny + `setCacheMaxAge(0)`; missing-value
⇒ deny (cacheable). The module *consumes* core condition plugins (request_path, user_role,
entity_bundle:node, language); it defines none of its own. The settings form's `buildVisibilityInterface()`
mirrors `block` module's UI and hides `current_theme` / single-language `language`.

## How the snippet is attached — `MauticScript` + `hook_page_attachments`

`advanced_mautic_integration_page_attachments()` (in `.module`) calls `VisibilityTracker::isVisible()`;
when true it:
- sets `drupalSettings.advancedMauticIntegration` = `MauticScript::getTrackingSettings()` (the
  `track*` flags + `trackDefaultParameters`, with tokens replaced via `Token::replacePlain()` and
  empty values filtered out),
- attaches library `advanced_mautic_integration/tracking_events`,
- adds an inline `html_head` `<script>` whose value is `MauticScript::getScript()` — the standard
  Mautic loader IIFE that injects `<track.url>/mtc.js` and defines the global `mt()` queue.

Config is added as a cacheable dependency in all three methods, so edits invalidate page cache.

## Client behaviour — `js/tracking_events.js`

Library `tracking_events` (deps `core/drupal`, `core/once`). Defines
`Drupal.behaviors.advancedMauticIntegrationTrackingEvents` and a reusable `Drupal.mt_send(extraParams)`
that de-dupes by URL and calls `mt('send','pageview', params)`. On attach it fires a pageview when
`trackPageviews` is on and binds `mousedown`/`keyup`/`touchstart` on every `<a>` to classify the href
as internal-download / mailto / tel / outbound and send the matching event per the enabled flags.
