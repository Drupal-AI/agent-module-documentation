<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Drupal Roles consumer plugin

Class `Drupal\authorization_drupal_roles\Plugin\authorization\Consumer\DrupalRolesConsumer`,
extends `ConsumerPluginBase`. It is the consumer half of an `authorization_profile`.

- **Plugin id:** `authorization_drupal_roles` — set a profile's `consumer` field to this.
- **Label:** "Drupal Roles".
- **Settings (`consumer_config`):** none. The form says "There are no settings for Drupal roles."
- **Target creation:** allowed (`$allowConsumerTargetCreation = TRUE`) — it can create a role
  that doesn't exist yet when `synchronization_actions.create_consumers` is on.

## Mapping rows (`consumer_mappings`)

Each row is `{ "role": <value> }`, index-aligned with the profile's `provider_mappings`.
`<value>` is one of:

| Value | Meaning |
|---|---|
| a role machine id (e.g. `editor`) | grant that specific role when the paired provider mapping matches |
| `none` | map to nothing (a matched proposal grants no role) — the row is a no-op |
| `source` | **wildcard**: map any matched proposal straight to a like-named role (dynamic). Use with caution |

Reserved names `none` and `source` cannot be used as literal role ids (that is the module's
documented limitation). The `authenticated` role is excluded from the row's select options.

## Behaviour

- `grantSingleAuthorization()` — adds the role to the user (`$user->addRole()`) and records,
  per profile, which roles it granted via the `authorization_drupal_roles.manager` service.
- `revokeGrants()` — removes only roles this module previously granted for that profile and
  that are no longer in the current grant set (manual roles are untouched). Runs when
  `synchronization_actions.revoke_provider_provisioned` is on.
- `createConsumerTarget()` — creates the `user_role` entity if missing, using a sanitized id.
- Role-id sanitization: transliterate to lowercase, non-`[a-z0-9_.]` → `_`.

## Example consumer half of a profile

```php
"consumer" => "authorization_drupal_roles",
"consumer_config" => [],
"consumer_mappings" => [["role" => "editor"], ["role" => "source"]],
```

See the parent for the full profile entity and provider side:
[../../../../../1.5.x/agent/configure/authorization.md](../../../../../1.5.x/agent/configure/authorization.md).
