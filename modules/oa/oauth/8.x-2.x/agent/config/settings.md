<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth: install, settings & consumer management

## Install & enable

```bash
composer require drupal/oauth   # (no composer.json ships; drupal.org packaging still resolves it)
drush en oauth -y
```

Only Drupal dependency is core **`system`** (`oauth.info.yml`). **Hard runtime requirement:**
the PHP **PECL `oauth` extension**. `oauth_requirements()` (`oauth.install`) checks
`class_exists('\OauthProvider')` and reports `REQUIREMENT_ERROR` ("OAuth module requires the
PECL OAuth library") when it is absent — the auth provider cannot verify signatures without it.

Install schema: `oauth_schema()` creates table **`oauth_nonce`** (`nonce` varchar_ascii(255) PK,
`timestamp` int). Update hooks: `oauth_update_8100` migrates any legacy `oauth_consumer` table
rows into `users_data`; `oauth_update_8101` (re)creates `oauth_nonce`.

## Config object `oauth.settings`

Default install config (`config/oauth.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `request_token_lifetime` | `'7200'` | Request-token lifetime in seconds. |
| `login_path` | `'user/login'` | Login page path (allows an alternate/mobile login page). |

There is **no `config/schema/`** in this module, so `oauth.settings` has no config schema
(strict config-schema tooling will flag it). `provides_config_schema` is therefore false.

## Admin settings form

- Route **`oauth.admin_form`** → `/admin/config/services/oauth`, permission **`administer oauth`**
  (menu link `oauth.admin_form` under *Configuration → Web services*).
- `OAuthSettingsForm` (a `ConfigFormBase`, form id `oauth_admin_form`, editable config
  `oauth.settings`) exposes two textfields: `request_token_lifetime` and `login_path`.
- `validateForm()` rejects a zero/non-integer `request_token_lifetime`
  (`intval(...)` must be truthy).

## Consumer credentials

Consumers are **not entities** — they are stored in core `users_data` under module key
`oauth`: the map key is the `consumer_key`, the value is
`['consumer_secret' => ..., 'key_hash' => sha1($consumer_key)]`.

- **List:** route `oauth.user_consumer` → `/user/{user}/oauth/consumer`
  (`OAuthController::consumers()`), also a user-profile task tab "OAuth Consumers"
  (`oauth.links.task.yml`). Renders a table of key / secret / delete-operation, cache-tagged
  `oauth:{uid}`.
- **Add:** route `oauth.user_consumer_add` → `/oauth/consumer/add/{user}`
  (`OAuthAddConsumerForm`). `submitForm()` generates a 32-char `consumer_key` and 32-char
  `consumer_secret` via `password_generator`, sets `key_hash = sha1($consumer_key)`, writes to
  `users_data`, invalidates cache tag `oauth:{uid}`, redirects to the list.
- **Delete:** route `oauth.user_consumer_delete` → `/oauth/consumer/delete/{user}/{key}`
  (`OAuthDeleteConsumerForm`, a `ConfirmFormBase`) — deletes the `users_data` entry and
  invalidates the tag.

### Access to the consumer routes

All three consumer routes use requirement `_oauth_access_check: 'TRUE'`, resolved by
`oauth.access_checker` (`CustomAccessCheck::access(UserInterface $user, AccountInterface
$account)`): allowed if the account has **`administer consumers`**, OR if it is the same user
(`$user->id() == $account->id()`) AND has **`access own consumers`**. All four module
permissions are `restrict access: TRUE`.

## Operating notes

- Two-legged only: there is no interactive request-token/authorize/access-token redirect flow
  in this version (`tokenHandler()` is a stub returning `OAUTH_OK`); a client authenticates with
  a consumer key/secret pair alone.
- Clients send `Authorization: OAuth ...` signed headers. See
  [../api/authentication-provider.md](../api/authentication-provider.md).
