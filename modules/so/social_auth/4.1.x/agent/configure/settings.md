<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Social Auth

Two layers of config: **site-wide behavior** (`social_auth.settings`) and **per-provider
credentials** (`<network>.settings`, one per installed provider module).

## Site behavior — `social_auth.settings`

Schema `social_auth.settings` (`config/schema/social_auth.schema.yml`). Defaults from
`config/install/social_auth.settings.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `post_login` | string | `/user` | Path to redirect to after a successful login. Must start with `/`, `#`, or `?`. |
| `user_allowed` | string | `register` | `register` (register and login) or `login` (login only, no new accounts). |
| `redirect_user_form` | bool | `FALSE` | Send newly created users to the Drupal user edit form. |
| `disable_admin_login` | bool | `TRUE` | Block social login for user 1 (admin) — a security hardening. |
| `disabled_roles` | array | `[]` | Role machine names for which social login is disabled. |
| `auth` | sequence | `[]` | Per-implementer login-route settings (maintained by provider modules). |

```bash
drush config:get social_auth.settings
drush config:set social_auth.settings post_login /user/me -y
drush config:set social_auth.settings user_allowed login -y
drush config:set social_auth.settings disable_admin_login 0 -y
```

These are edited in the "Social Auth Settings" section of the **network settings form**
(below), not on a standalone page.

## Integrations page (the `configure` route)

`social_auth.integrations` → **`/admin/config/social-api/social-auth`** (controller
`SocialApiController::integrations`, permission `administer social api authentication`). Lists
every installed Social Auth provider and links to each provider's settings form.

## Per-provider settings form

`social_auth.network.settings_form` → **`/admin/config/social-api/social-auth/{network}`**
(`SocialAuthSettingsForm`). `{network}` is a Network plugin id (converted by the
`paramconverter.network` service). It writes to **the provider's own config object**
`"<network_id>.settings"` (e.g. `social_auth_google.settings`):

- `client_id`, `client_secret` (required) — from the OAuth app you register with the provider.
- `scopes` — extra scopes, comma-separated.
- `endpoints` — extra API endpoints to call on first auth (`endpoint|name` per line).
- `authorized_redirect_url` — read-only; the callback URL to paste into the provider console
  (`network->getCallbackUrl()`).

The same form also saves the six `social_auth.settings` values above.

## Login UI

- **Block:** place the "Social Auth Login" block (`social_auth_login`) — it renders the
  `login_with` theme hook with a link per installed network
  (`network.getRedirectUrl()` → `user/login/{network}`).
- **User edit form:** logged-in users see a "Social Authentications" table to link/unlink
  providers (`social_auth_form_user_form_alter`).

## External requirement

You cannot complete a real login without (1) a provider implementer module
(`composer require drupal/social_auth_<provider>`) and (2) an OAuth application registered on
the provider's side supplying the `client_id`/`client_secret`. The config keys, routes, block,
and profile entity above are all present and inspectable without the external service.
