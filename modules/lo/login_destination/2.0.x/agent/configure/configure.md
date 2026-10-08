# Configure login destination rules & settings

## Routes

All under `/admin/config/people/login-destination`:

| Route | Path | Purpose |
|---|---|---|
| `login_destination.list` | `/` | List rules (the `configure` route) |
| `login_destination.add` | `/add` | Add a rule |
| `entity.login_destination.edit_form` | `/{login_destination}/edit` | Edit a rule |
| `entity.login_destination.delete_form` | `/{login_destination}/delete` | Delete a rule |
| `login_destination.settings` | `/settings` | Advanced settings form |

All routes require the `administer login destination settings` permission.

## The `login_destination` config entity (a "rule")

A rule is a `login_destination` config entity (config prefix `destination`, so stored as
`login_destination.destination.{machine_name}`). Fields (from `config_export` / the add/edit
form):

| Field | Meaning |
|---|---|
| `label` | Short human description (required) |
| `name` | Machine name / id (required) |
| `triggers` | One or more of `registration`, `login`, `one-time-login`, `logout` (required) |
| `destination_path` | Where to send the user (required) — see below |
| `pages_type` | `0` = all pages **except** those listed; `1` = **only** the listed pages |
| `pages` | One path per line, `*` wildcard; matched against internal path **and** alias |
| `language` | Restrict to one langcode; empty = all languages |
| `roles` | Roles to match; empty = **all** users. Only **one** role needs to match |
| `enabled` | Boolean; disabled rules are skipped |
| `weight` | Ordering — lower weight is evaluated first (sets priority) |

### Destination values (`destination_path`)

- An internal path (e.g. `/dashboard`) — stored as `internal:` URI.
- A node chosen by the entity-autocomplete field — stored as `entity:node/{nid}`.
- An external URL (e.g. `http://example.com`).
- `<front>` — the front page.
- `<current>` — the page the user came from (read from the `current` GET parameter).
- **Tokens** are supported (user + global); a token tree UI is shown. Tokens are replaced at
  redirect time via the token service.

## How matching works (priority)

On each trigger the `login_destination.manager` service loads all rules, sorts by weight, and
returns the **first** enabled rule whose trigger, roles, language and page conditions all match;
the user is redirected to that rule's destination. If no rule matches, Drupal's default
destination is used. Order rules by weight so the most specific rule wins.

Page conditions only work when the originating page is known. Forms and altered login/logout
links pass it via a `current` GET parameter; **custom login/logout links must add the `current`
parameter** to be matched on page.

## Advanced settings — `login_destination.settings`

Edit at `/admin/config/people/login-destination/settings` or via
`drush cset login_destination.settings <key>`. Defaults shown:

| Key | Default | Meaning |
|---|---|---|
| `preserve_destination` | `false` | If true, Drupal's own `?destination=` query takes priority over module rules (note: the login block redirect then stops working) |
| `immediate_redirect` | `false` | If true, redirect immediately after a one-time login link, **before** the password-change form |

Both are a `config_object` (schema `config/schema/login_destination.settings.yml`), so they
export/deploy with `drush config:export`.

## Programmatic trigger

External modules can force evaluation + redirect for a trigger:
`login_destination_perform_redirect($trigger, \Drupal\Core\Session\AccountInterface $account)`
(triggers: `login`, `logout`, `registration`, `one-time-login`).
