<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, tracking snippet & visibility

Install/enable: `composer require drupal/advanced_mautic_integration` (pulls `mautic/api-library`
`^3.1 || ^4.0` and `drupal/token` `^1.15`), then `drush en advanced_mautic_integration`. Requires the
`token` module. Configure at **`/admin/config/services/adv-mautic`** (route
`advanced_mautic_integration.admin_settings_form`, permission `administer advanced mautic integration`).

![Advanced Mautic Integration settings form](../../../../../../../screenshots/advanced_mautic_integration/1.1.x/settings-form.png)

## Config object: `advanced_mautic_integration.settings`

Written by `Form\MauticAdminSettingsForm::submitForm()`. A `config/schema/advanced_mautic_integration.schema.yml`
and a `config/install/advanced_mautic_integration.settings.yml` (all-empty defaults, `consent_required: false`,
`visibility: {}`) ship with the module. Keys:

- `track.url` — Mautic base URL (used to build `<url>/mtc.js` in JS). Empty ⇒ tracking disabled. Trimmed
  of surrounding slashes on save.
- `track.pageviews`, `track.outbound`, `track.mailto`, `track.tel`, `track.files` — booleans.
- `track.files_extensions` — pipe-separated extension list/regex (e.g. `pdf|doc|zip`).
- `track.default_parameters` — a JSON string sent with each event; Token-enabled (form default seeds
  `{"email":"[current-user:mail]"}`).
- `track.consent_required` — bool; when TRUE the client holds the tracker until a consent manager
  reports the decision (see [consent.md](consent.md)).
- `api.url` — Mautic API endpoint (e.g. `https://mautic.example.com/api`). Empty ⇒ API disabled.
- `api.user`, `api.password` — Basic Auth credentials.
- `api.synchronize_user` — bool; gates the user→contact sync (checked in the user hooks).
- `api.user_lead_mapping` — newline list of `drupal_field|mautic_field` pairs.
- `visibility` — Condition-plugin configuration array (block-style).

`buildForm()` renders three fieldsets (JS snippet, API, visibility). `validateForm()` trims URLs,
requires them to pass `UrlHelper::isValid($url, TRUE)`, validates `track.default_parameters` as JSON,
enforces the `field|field` mapping format (blank lines skipped), requires the extension list when
`track_files` is on and the mapping when `api_synchronize_user` is on, and — when an API URL is set —
requires user/password (re-using the stored password when the `#type => 'password'` field is left
blank, since it is not re-populated).

## Visibility — `VisibilityTracker` (service `advanced_mautic_integration.visibility`)

`isVisible(BubbleableMetadata)` returns FALSE immediately if `track.url` is empty. Otherwise it loads
the stored `visibility` config into a `ConditionPluginCollection` over `plugin.manager.condition`,
applies runtime contexts via `context.handler`/`context.repository`, and ANDs the results
(`resolveConditions($conditions, 'and')`). Missing-context ⇒ deny + `setCacheMaxAge(0)`; missing-value
⇒ deny (cacheable). The module *consumes* core condition plugins (request_path, user_role,
entity_bundle:node, language); it defines none of its own. The settings form's `buildVisibilityInterface()`
mirrors `block` module's UI (filtered via `getFilteredDefinitions('mautic', ...)`) and hides
`current_theme` / single-language `language`.

## How the snippet is attached — `MauticScript` + `hook_page_attachments`

`AdvancedMauticIntegrationHooks::pageAttachments()` (src/Hook/AdvancedMauticIntegrationHooks.php)
calls `VisibilityTracker::isVisible()`; when true it:
- sets `drupalSettings.advancedMauticIntegration` = `MauticScript::getTrackingSettings()` — the
  `track*` flags, `trackUrl`, `trackFilesExtensions`, `consentRequired`, and `trackDefaultParameters`
  (tokens replaced via `Token::replacePlain()`, then `json_decode` + `array_filter` to drop empties),
- attaches library `advanced_mautic_integration/tracking_events`.

No inline `<script>` is emitted server-side (unlike 1.0.x): the loader is built entirely in JS from
`drupalSettings`. Config is added as a cacheable dependency, so edits invalidate page cache.

## Client behaviour — `js/tracking_events.js`

Library `tracking_events` (deps `core/drupal`, `core/drupalSettings`, `core/once`). It reads settings
into a `state` object, defines `Drupal.advancedMauticIntegration.consent()/hasConsent()`, and defines
behavior `advancedMauticIntegrationTrackingEvents`. `loadTracker()` creates the Mautic `mt()` queue and
appends a `<script async src="<trackUrl>/mtc.js">`. `Drupal.mt_send(extraParams)` de-dupes by URL and
`dispatch()`es `mt('send','pageview', params)` (subject to consent). On attach it fires a pageview when
`trackPageviews` is on and binds `mousedown`/`keyup`/`touchstart` on every `<a>` to classify the href
as internal-download / mailto / tel / outbound and send the matching event per the enabled flags.
