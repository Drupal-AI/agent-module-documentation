<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, tracking snippet & visibility

Install/enable: `composer require drupal/advanced_mautic_integration` (pulls `mautic/api-library`
`^3.1 || ^4.0` and `drupal/token` `^1.15`), then `drush en advanced_mautic_integration`. Requires the
`token` module. Configure at **`/admin/config/services/adv-mautic`** (route
`advanced_mautic_integration.admin_settings_form`, permission `administer advanced mautic integration`).

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

`isVisible(?BubbleableMetadata)` returns FALSE immediately if `track.url` is empty. Otherwise it loads
the stored `visibility` config into a `ConditionPluginCollection` over `plugin.manager.condition`,
applies runtime contexts via `context.handler`/`context.repository`, and ANDs the results
(`resolveConditions($conditions, 'and')`). Missing-context ⇒ deny + `setCacheMaxAge(0)`; missing-value
⇒ deny (cacheable). The module *consumes* core condition plugins (request_path, user_role,
entity_bundle:node, language); it defines none of its own. The settings form's `buildVisibilityInterface()`
mirrors `block` module's UI (filtered via `getFilteredDefinitions('mautic', ...)`) and hides
`current_theme` / single-language `language`.

## How the tracker is attached — `hook_page_top` + placeholder (changed in 1.2.x)

`AdvancedMauticIntegrationHooks::pageTop(&$page_top)` (src/Hook/AdvancedMauticIntegrationHooks.php)
calls `VisibilityTracker::isVisible($bubbleable_metadata)`; when true it sets
`$page_top['advanced_mautic_integration_tracker']` to a render element with
`#lazy_builder => ['advanced_mautic_integration.tracker_placeholder:build', []]` and
`#create_placeholder => TRUE`, then applies the visibility cacheability to `$page_top`. The visibility
decision caches with the page; the tracker itself is built per-request by the placeholder, so a
visitor-naming default parameter does not take the page out of the Dynamic Page Cache. **This replaces
the 1.1.x `hook_page_attachments` path.** Full detail of the placeholder and the alter hook is in
[../hooks/hooks.md](../hooks/hooks.md).

`MauticScript::getTrackingSettings(?BubbleableMetadata)` builds the `drupalSettings.advancedMauticIntegration`
payload: `trackUrl`, the `track*` flags, `trackFilesExtensions`, `consentRequired` (cast to bool), and
`trackDefaultParameters` (a `stdClass` when none; otherwise the JSON `default_parameters` with tokens
replaced via `Token::replacePlain(..., ['clear' => TRUE], $bubbleable_metadata)` then `json_decode` +
`array_filter` to drop empties). The config is added as a cacheable dependency of the placeholder. No
inline `<script>` is emitted server-side — the loader is built entirely in JS from `drupalSettings`.

## Client behaviour — `js/tracking_events.js`

Library `tracking_events` (deps `core/drupal`, `core/drupalSettings`, `core/once`). It reads settings
into a `state` object (`required`/`consent` are tri-states), defines
`Drupal.advancedMauticIntegration.consent()/hasConsent()` and `Drupal.mt_send()` as soon as the file is
parsed, and defines behavior `advancedMauticIntegrationTrackingEvents`. `readSettings()` runs on parse
and again on the first attach (and on AJAX attaches that bring new settings), because with BigPipe the
settings can arrive after the library. `loadTracker()` creates Mautic's `window.mt` queue and appends a
`<script async src="<trackUrl>/mtc.js">` once. `Drupal.mt_send(extraParams)` de-dupes by URL and
`dispatch()`es `mt('send','pageview', {...defaults, ...extraParams})`, subject to consent (queued while
undecided/pre-settings, dropped on refusal). On attach it fires a pageview when `trackPageviews` is on
and binds `mousedown`/`keyup`/`touchstart` on every `<a>` to classify the href as
internal-download / mailto / tel / outbound and send the matching event per the enabled flags.
