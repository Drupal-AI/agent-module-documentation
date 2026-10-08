<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent Mode — settings, injection, and gtag flow

## Install & enable

```bash
composer require drupal/consent_mode
drush en consent_mode -y
drush cr
```

No dependencies beyond Drupal core. On install the module is **active** and, because
`consent_mode_enabled` defaults to `1` with every signal `0`, it immediately emits an
all-**denied** default consent state. Uninstall (`drush pmu consent_mode -y`) removes the config
object and stops the injection. Only pair it with a CMP/banner that sends the *update* call —
otherwise the site denies forever (compliant, but analytics stay near zero).

## Config object

Single object **`consent_mode.consent_mode_config`**, install defaults in
`config/install/consent_mode.consent_mode_config.yml`. **All keys are booleans; there is no
`config/schema/` — nothing formally types them** (`provides_config_schema: false`).

| Key | Default | Meaning |
|---|---|---|
| `consent_mode_enabled` | `1` | Master switch. When falsy the hook attaches nothing. |
| `ad_personalization` | `0` | `granted` when set, else `denied`. |
| `ad_storage` | `0` | `granted` when set, else `denied`. |
| `ad_user_data` | `0` | `granted` when set, else `denied`. |
| `analytics_storage` | `0` | `granted` when set, else `denied`. |
| `functionality_storage` | `0` | `granted` when set, else `denied`. |
| `personalization_storage` | `0` | `granted` when set, else `denied`. |

Config-export example (grant analytics only):

```yaml
# consent_mode.consent_mode_config.yml
consent_mode_enabled: 1
ad_personalization: 0
ad_storage: 0
ad_user_data: 0
analytics_storage: 1
functionality_storage: 0
personalization_storage: 0
```

## Form, route, permission

- Form: `\Drupal\consent_mode\Form\ConsentModeConfigForm` (extends `ConfigFormBase`,
  `getFormId()` = `consent_mode_config_form`, `getEditableConfigNames()` =
  `['consent_mode.consent_mode_config']`). `buildForm()` renders seven `#type => 'checkbox'`
  elements; the six signal checkboxes use `#states` to show only while `consent_mode_enabled` is
  checked. `submitForm()` writes all seven `$form_state->getValue()` results back and saves.
- Route: `consent_mode.consent_mode_config_form`, path **`/admin/config/consent_mode`**,
  `_form` = the class above, requirement **`_permission: 'access consent mode config'`**,
  `options: { _admin_route: TRUE }` (`consent_mode.routing.yml`).
- Menu link: `consent_mode.links.menu.yml` places it under `system.admin_config_system`
  (*Configuration → System*), weight 99.
- Permission: `access consent mode config` (`consent_mode.permissions.yml`), described
  *"Allow access to the config form of this module"*. It is **not** flagged `restrict access`, so
  it can be granted to a non-admin role.

## How the script is injected and reaches gtag

`consent_mode_page_attachments_alter(array &$page)` in `consent_mode.module` runs on every page.
If `consent_mode_enabled` is truthy it coerces each signal to a string and hands them to JS via
`drupalSettings` — it does **not** build inline `<script>` markup from config:

```php
$consentModeAdStorage = $config->get('ad_storage');
$consentModeAdStorage = $consentModeAdStorage ? 'granted' : 'denied';
// … same ternary for the other five signals …

$page['#attached']['drupalSettings']['consent_mode'] = [
  'ad_personalization'      => $consentModeAdPersonalization,
  'ad_storage'              => $consentModeAdStorage,
  'ad_user_data'            => $consentModeAdUserData,
  'analytics_storage'       => $consentModeAnalyticsStorage,
  'functionality_storage'   => $consentModeFunctionalityStorage,
  'personalization_storage' => $consentModePersonalizationStorage,
];
$page['#attached']['library'][] = 'consent_mode/consent_mode';
```

The library `consent_mode` (`consent_mode.libraries.yml`) sets **`header: true`** so
`js/consent_mode.js` loads early in `<head>`. That static file defines `gtag()` and calls:

```js
gtag("consent", "default", {
  ad_personalization: drupalSettings.consent_mode.ad_personalization,
  ad_storage: drupalSettings.consent_mode.ad_storage,
  ad_user_data: drupalSettings.consent_mode.ad_user_data,
  analytics_storage: drupalSettings.consent_mode.analytics_storage,
  functionality_storage: drupalSettings.consent_mode.functionality_storage,
  personalization_storage: drupalSettings.consent_mode.personalization_storage,
  security_storage: "granted",
  wait_for_update: 500
});
gtag("set", "ads_data_redaction", true);
gtag("set", "url_passthrough", false);
```

So `security_storage`, `wait_for_update`, `ads_data_redaction` and `url_passthrough` are fixed in
the script and not configurable. The six variable signals only ever carry the literal strings
`granted`/`denied`, delivered through Drupal's JSON-encoded `drupalSettings`.

## How updates propagate to gtag

This module emits only the **default** state; it never calls `gtag('consent','update')`. When a
visitor changes their choice, a CMP/banner (Cookiebot, Usercentrics, GTM, custom JS) is responsible
for the `update` call. Because Consent Mode's script runs in `<head>` with `wait_for_update: 500`,
Google tags hold up to 500 ms for that update before applying the defaults. Changing the module's
own checkboxes only alters the *default* the next page emits.
