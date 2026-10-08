<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Keycloak SSO, sign-out, i18n & role mapping

All of these live under a Keycloak client's `settings` (schema
`openid_connect.client.plugin.keycloak`). Toggle in the client edit form or in config.

## Single sign-on / sign-out

| key | type | meaning |
|---|---|---|
| `keycloak_sso` | bool | replace the Drupal login form with a redirect to Keycloak |
| `keycloak_sign_out` | bool | Drupal logout also ends the Keycloak session (single sign-out) |
| `check_session.enabled` | bool | detect a Keycloak-side logout and end the Drupal session |
| `check_session.interval` | int | seconds between session checks (JS `keycloak-session.js`) |

Routes `keycloak/login` and `keycloak/logout` are the SSO entry/exit endpoints; the route
subscriber redirects Drupal's login to Keycloak when `keycloak_sso` is on.

## Internationalisation

`keycloak_i18n`:
- `enabled` (bool) — forward the active Drupal language to Keycloak login screens.
- `mapping` — sequence of `{langcode, target}` mapping Drupal langcodes to Keycloak locale codes.
`keycloak_locale_param` — the query-param name Keycloak expects for the locale (default `kc_locale`).

## Group → role mapping (`keycloak_groups`)

Automatically grant/revoke Drupal roles from a Keycloak token claim:

| key | meaning |
|---|---|
| `enabled` | turn automatic role assignment on |
| `claim_name` | the token claim holding the user's groups/roles (e.g. `groups`) |
| `split_groups` | split nested paths like `/a/b/c` into individual values |
| `split_groups_limit` | limit nesting depth when splitting |
| `rules` | ordered list of mapping rules (evaluated by weight) |

Each rule in `rules` (a sequence):

| field | meaning |
|---|---|
| `id` | rule id |
| `role` | Drupal role machine name to grant/revoke |
| `action` | what to do on match (add / remove role) |
| `operation` | how to evaluate the pattern (e.g. equals, starts_with, regex) |
| `pattern` | the value/pattern matched against the claim |
| `case_sensitive` | bool |
| `weight` | evaluation order |
| `enabled` | bool |

Example (config fragment):

```yaml
settings:
  keycloak_groups:
    enabled: true
    claim_name: groups
    split_groups: true
    rules:
      - id: editors
        role: editor
        action: add
        operation: equals
        pattern: /editors
        case_sensitive: false
        weight: 0
        enabled: true
```

The matching logic is `KeycloakRoleMatcherTrait` used by the `keycloak` plugin.
