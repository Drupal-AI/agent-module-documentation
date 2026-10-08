<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON endpoints & extension hook

All endpoints require `?site_guardian_key=<key>` and the module activated (see configure doc).
`no_cache: TRUE`, `_auth: ['cookie']` (authorization is the key, not login).

## `GET /site_guardian/status_report`

Route `site_guardian.endpoint.status_report` → `SiteGuardianController::getSiteStatusReport()`.
Returns `SystemManager::listRequirements()` (the same data as `/admin/reports/status`: Drupal/PHP/DB
versions, cron, warnings, etc.) as JSON, **merged** with anything returned by
`hook_site_guardian_status()` implementations.

## `GET /site_guardian/enabled_modules_and_updates`

Route `site_guardian.endpoint.enabled_modules_and_updates` →
`SiteGuardianController::listEnabledModulesAndUpdates()` →
`SiteGuardianService::getEnabledModulesAndUpdates()`. Returns each enabled project (core, contrib,
custom, features-generated) with version + computed update status, by borrowing core `update` logic
(`update.compare`, `update_calculate_project_update_status`, `ProjectCoreCompatibility`). Equivalent to
`/admin/reports/updates`. May trigger an `update_fetch_data()` refresh if release data is stale.

Example: `https://example.com/site_guardian/enabled_modules_and_updates?site_guardian_key=<key>`

## Extending — `hook_site_guardian_status()`

```php
/**
 * Add custom info to the Site Guardian status_report endpoint.
 *
 * @return array
 *   Keyed array merged into the status_report JSON (same shape as a
 *   hook_requirements() entry: title, value, severity, description).
 */
function mymodule_site_guardian_status(): array {
  return [
    'mymodule_health' => [
      'title' => 'My module health',
      'value' => 'OK',
      'severity' => REQUIREMENT_INFO,
    ],
  ];
}
```

Invoked via `moduleHandler->invokeAll('site_guardian_status')` and `array_merge`d into the status
report response.
