<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & operation

## Install / enable

```
composer require drupal/eudonet   # (dev checkout: minimum-stability dev)
drush en eudonet -y
```

No module dependencies (info.yml `core_version_requirement: ^10.1 || ^11`, empty composer
`require`). Nothing runs until you configure credentials and drive the `eudonet` service from
code.

## Settings form

- Route `eudonet.eudonet_config_form` → `/admin/config/services/eudonet`
  (`eudonet.routing.yml`; admin route, `_admin_route: TRUE`).
- Menu link `eudonet.eudonet_config_form` under *Configuration → Services*
  (`system.admin_config_services`), weight 99 (`eudonet.links.menu.yml`).
- Form `Drupal\eudonet\Form\EudonetConfigForm` (extends `ConfigFormBase`), editable config
  `eudonet.eudonetconfig`.

Fields:

- **API base url** (`base_url`) — e.g. `https://xrm.eudonet.com/EudoAPI/`.
- **Authentication** (details, `#tree`): Subscriber login (required), Subscriber password
  (leave blank to keep existing), Base name (required), User login (required), User password
  (leave blank to keep existing), Language (select `LANG_00`..`LANG_05`, default `LANG_00`
  French), Product name.
- **Token information** (read-only/disabled): Expiration, Server date, Current token — populated
  from the cached `token_info`.
- **Try auth request** button (`::tryAuthenticationRequest`) — calls `eudonet->authenticate()`
  and reports success or the API error number/message.

On submit, empty password fields are preserved from the existing config (passwords are not
re-collected each save); `base_url` and the `authentication` mapping are saved.

## Config object & schema

Config name **`eudonet.eudonetconfig`** (`config/install/eudonet.eudonetconfig.yml` ships an empty
`eudonet:` default; schema `config/schema/eudonet.eudonetconfig.schema.yml`, type
`config_object`):

```yaml
eudonet: string
base_url: string
authentication:
  subscriber_login: string
  subscriber_password: string
  base_name: string
  user_login: string
  user_password: string
  language: string
  product_name: string
token_info:
  expiration: string
  server_date: string
  token: string
```

The `authentication` values are read by `Eudonet::getAuthenticationQuery()` as defaults;
`token_info` is written by `AuthenticationQueryResult` after each successful authentication and
read by `EudonetQueryBase::execute()` (auto-refresh when empty or within 2h of `expiration`).

## Operating notes

- Set `base_url` (with trailing slash) and all seven auth parameters, then use *Try auth request*
  to confirm connectivity before running queries from code.
- The session token is cached in config and reused across requests via the `x-auth` header; you
  normally never call `authenticate()` yourself — `execute()` refreshes as needed.
- Provides **no** permissions, Drush commands, entities, or blocks of its own. The only hook is
  `eudonet_help()` (help.page.eudonet).
