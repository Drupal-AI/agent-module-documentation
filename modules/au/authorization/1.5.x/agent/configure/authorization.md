<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the `authorization_profile` config entity

Everything the module does is driven by **`authorization_profile`** config entities.
Manage them in the UI at `/admin/config/people/authorization/profile` (collection,
add, edit, delete). Global settings live at
`/admin/config/people/authorization/profile/settings` (route
`entity.authorization_profile.configuration_form`, the value of `info.yml` `configure`) —
that form has one key, `authorization.settings:authorization_message` (bool: show per-grant
status messages to the user at login). Admin access is gated by `administer site configuration`.

## Config entity shape

- **Entity type id:** `authorization_profile` (a `@ConfigEntityType`).
- **Config prefix / object name:** `authorization.authorization_profile.{id}`.
- **`config_export` fields** (what is persisted): `id`, `label`, `provider`,
  `provider_config`, `provider_mappings`, `consumer`, `consumer_config`, `consumer_mappings`,
  `synchronization_modes`, `synchronization_actions`.

| Field | Meaning |
|---|---|
| `id`, `label` | machine id + human label |
| `provider` | provider plugin id (e.g. an LDAP provider from `ldap_authorization`); `""` if none installed |
| `provider_config` | provider plugin settings (array, plugin-specific) |
| `provider_mappings` | sequence of provider match rules (what incoming proposals to match) |
| `consumer` | consumer plugin id (e.g. `authorization_drupal_roles`) |
| `consumer_config` | consumer plugin settings (array, plugin-specific; roles consumer has none) |
| `consumer_mappings` | sequence paired 1:1 with `provider_mappings` (what to grant on match) |
| `synchronization_modes` | mapping — when to act, e.g. `user_logon: user_logon` |
| `synchronization_actions` | mapping — `create_consumers` (create missing targets) and `revoke_provider_provisioned` (revoke stale grants) |

`status` (enabled) is a base config-entity key. A profile only runs when `status` is TRUE and
both its provider and consumer plugins resolve (`checkConditions()`).

## Create one with Drush (no UI)

The provider/consumer mappings are index-aligned: `consumer_mappings[i]` is granted when
`provider_mappings[i]` matches. This example builds a roles-only profile (no provider
installed) that maps to the `editor` role:

```php
drush php:eval '
$p = \Drupal::entityTypeManager()->getStorage("authorization_profile")->create([
  "id" => "ldap_to_roles",
  "label" => "LDAP to roles",
  "provider" => "",                          // e.g. an ldap_authorization provider id
  "provider_config" => [],
  "provider_mappings" => [],                 // provider-specific match rules
  "consumer" => "authorization_drupal_roles",
  "consumer_config" => [],
  "consumer_mappings" => [["role" => "editor"]],
  "synchronization_modes" => ["user_logon" => "user_logon"],
  "synchronization_actions" => [
    "create_consumers" => "create_consumers",
    "revoke_provider_provisioned" => "revoke_provider_provisioned",
  ],
]);
$p->save();
'
```

Read it back: `drush config:get authorization.authorization_profile.ldap_to_roles`, or
`drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("authorization_profile")->load("ldap_to_roles"); print $e->getConsumerId();'`.

## Notes

- **One provider + one consumer per profile.** The recommended pattern is one profile per
  provider/consumer combination; each profile is evaluated in isolation.
- A profile does nothing useful until an `@AuthorizationProvider` plugin is installed
  (e.g. via `ldap_authorization`) to supply proposals. Out of the box only the
  `authorization_drupal_roles` consumer ships.
- Config schema: `authorization.authorization_profile.*` in
  `config/schema/authorization_profile.schema.yml` (provider/consumer config and mappings use
  dynamic types keyed by the selected plugin id).
