<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mautic API wrapper & user→contact synchronizer

Two services back the API half. Both read the `advanced_mautic_integration.settings` config object
(see [../config/settings.md](../config/settings.md)).

## `MauticApiWrapper` — service `advanced_mautic_integration.api`

Class `Drupal\advanced_mautic_integration\MauticApiWrapper` (final, implements
`MauticApiWrapperInterface`). Single method:

```
getApi(string $api_context): \Mautic\Api\Api
```

It lazily builds a `\Mautic\Auth\ApiAuth->newAuth(['userName'=>api.user,'password'=>api.password],
'BasicAuth')` (Basic Auth only — no OAuth), then returns `(new MauticApi())->newApi($api_context,
$auth, $config->get('api.url'))`. `$api_context` is any Mautic library context, e.g. `contacts`,
`campaigns`. Custom usage:

```php
$api = \Drupal::service('advanced_mautic_integration.api')->getApi('contacts');
$api->create(['email' => 'someone@example.com', 'firstname' => 'John']);
```

## `UserSynchronizer` — service `advanced_mautic_integration.user_synchronizer`

Class `Drupal\advanced_mautic_integration\UserSynchronizer` (final, implements
`UserSynchronizerInterface`; deps: config.factory, the API wrapper, `current_user`, `request_stack`).
Methods:

- `push(UserInterface $user)` — builds lead data via `convertUserToLead()`; if empty, no-op. Resolves
  the Mautic contact id via `getLeadIdForUser()`; `edit()`s that contact if found, else `create()`s a
  new one (against the `contacts` context).
- `getLeadIdForUser(UserInterface): ?string` — for the **current** user, first reads the Mautic
  `mtc_id` cookie from the request; otherwise (or if absent) looks the contact up by email via
  `getLeadByParameter()`.
- `convertUserToLead(UserInterface): array` — splits `api.user_lead_mapping` on newlines, each line
  `drupal_field|mautic_field`; for every mapped Drupal field the user *has*, copies `->value` into the
  Mautic-keyed array.
- `getLeadByParameter($parameter): ?array` — `getApi('contacts')->getList($parameter)`, returns the
  first `contacts` row or NULL.

## Trigger — user insert/update hooks (`.module`)

`hook_user_insert` and `hook_user_update` both call
`advanced_mautic_integration.user_synchronizer->push($user)` inside a try/catch; any exception is
logged (error) to the `advanced_mautic_integration` channel and swallowed, so a failed sync never
blocks the user save. Sync only does anything when `api.user_lead_mapping` yields data and the API
credentials/URL are configured. (The hooks fire on every user save regardless of the
`api.synchronize_user` flag — that flag only governs the settings-form UI state.)

## Notes

- Requires the `mautic/api-library` Composer package (`dev-main`, per composer.json — the maintainer
  pins main due to a Psr/Log issue in the 3.1.0 tag).
- The `mtc_id` cookie path only works when Mautic is same-scheme/CORS-configured so the cookie is
  readable by Drupal, per the settings-form help text.
