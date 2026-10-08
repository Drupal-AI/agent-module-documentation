<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Persistent Login

## Config object — `persistent_login.settings`

```yaml
lifetime: 30              # integer, days a persistent login stays valid. 0 = never expires
extend_lifetime: false    # renew from last use instead of from creation (only meaningful when lifetime > 0)
max_tokens: 0             # max remembered logins per user. 0 = unlimited
login_form:
  field_label: 'Remember me'   # the checkbox label (translatable)
cookie_prefix: 'PL'       # prefix of the persistent-login cookie name
```

Those are the install defaults. Schema: `config/schema/persistent_login.schema.yml`.
Config translation is wired up (`persistent_login.config_translation.yml`), so
`login_form.field_label` is translatable per language.

## Read / write with Drush

```bash
drush cget persistent_login.settings
drush cset persistent_login.settings lifetime 90 -y
drush cset persistent_login.settings extend_lifetime 1 -y
drush cset persistent_login.settings max_tokens 5 -y
drush cset persistent_login.settings login_form.field_label 'Stay signed in' -y
drush cset persistent_login.settings cookie_prefix 'MYAPP' -y
```

## Via the UI

*Configuration → System → Persistent Login* (`/admin/config/system/persistent_login`,
permission `administer site configuration`):

| Field | Notes |
|---|---|
| **Lifetime** | number, min 0. "Enter 0 for no expiration." |
| **Extend lifetime when used** | only visible when Lifetime ≠ 0; the submit handler forces it back to FALSE whenever lifetime is 0. |
| **Maximum Tokens** | number, min 0. 0 = no limit. When exceeded, the oldest tokens are deleted at login time. |
| **Form Label** | required; the login-form checkbox text. |
| **Cookie Prefix** | required; validated against `/^[-_a-z0-9]+$/i` and rejected if it matches `/^S?SESS$/`. |

## Required site setting

`services.yml` must give PHP session cookies a browser-session lifetime, otherwise the module
reports an error on `/admin/reports/status`:

```yaml
parameters:
  session.storage.options:
    cookie_lifetime: 0
```

If you use a reverse-proxy cache (Varnish), exclude requests carrying the persistent-login
cookie from cache hits.

## How the cookie is named

`CookieHelper::getCookieName()`:

1. start from `cookie_prefix` (default `PL`);
2. on HTTPS, insert `S` after any `__Secure-`/`__Host-` prefix (`PL` → `SPL`), mirroring core's
   `SESS`/`SSESS` behaviour;
3. append the site's session name with its leading `S?SESS` stripped, i.e. the hash part of
   `SESS<hash>`.

So on an HTTPS site with session cookie `SSESSabc123` the persistent cookie is `SPLabc123`.

**Changing `cookie_prefix` invalidates every existing persistent login** (the form's own
description says "All users will be required to login if this value is changed").

## Verify the live state

```bash
drush cget persistent_login.settings
# how many active tokens exist, per user:
drush php:eval '
  $rows = \Drupal::database()->select("persistent_login", "pl")
    ->fields("pl", ["uid"])->execute()->fetchCol();
  print_r(array_count_values($rows));
'
# tokens for one user, via the service:
drush php:eval '
  $u = \Drupal\user\Entity\User::load(1);
  print count(\Drupal::service("persistent_login.token_manager")->getTokensForUser($u)) . "\n";
'
```

## Gotchas

- The config key is `login_form.field_label` (nested), not `field_label`.
- `extend_lifetime` is silently coerced to FALSE when `lifetime` is 0.
- `max_tokens` is enforced **when a new token is created**, not retroactively.
- The module has no permission of its own; the settings form uses core's
  `administer site configuration`, and `/user/{uid}/persistent-logins` uses
  `_entity_access: user.update`.
- Uninstalling drops the `persistent_login` table (standard `hook_schema` behaviour), so all
  remembered logins are lost.
