# Configure login protection

Config object: **`disable_login.settings`** (schema `config/schema/disable_login.schema.yml`).
The module ships **no `config/install`**, so all three keys are NULL until you save the form
or write config — meaning protection is off by default.

UI: *Configuration → Security → Disable Login Page* — route `disable_login.settings_form`,
path `/admin/config/security/disable-login`, permission **administer site configuration**.

## Keys

| Key | Type | Meaning |
|---|---|---|
| `disable_login` | boolean | master on/off for the protection |
| `querystring` | string | the query parameter **name** to look for (form defaults the field to `key` if empty) |
| `secret` | string | the required parameter **value** |

## How access is decided

`DisableLoginAccessCheck` runs on `user.login` and `user.login.http`:

- If `disable_login` is falsey → allowed (no protection).
- If truthy → it reads `request->get(querystring)` and compares to `secret` (after
  `hook_disable_login_key_alter()`); equal → allowed, otherwise **forbidden** (Access Denied).

So with `querystring = key`, `secret = abc123`:

```
/user/login              → 403 Access Denied
/user/login?key=abc123   → login form
```

Give staff the bookmarkable URL with the querystring.

## Enable via drush / config

```bash
drush cset disable_login.settings disable_login 1 -y
drush cset disable_login.settings querystring key -y
drush cset disable_login.settings secret abc123 -y
```

Or PHP:

```php
\Drupal::configFactory()->getEditable('disable_login.settings')
  ->set('disable_login', TRUE)->set('querystring', 'key')->set('secret', 'abc123')->save();
```

Read back: `drush cget disable_login.settings`.

## Escape hatch (locked out)

If you forget the key/value and cannot log in, the access checker has a documented manual
override: uncomment the `return TRUE;` line near the top of `hasValidSecretToken()` in
`src/Access/DisableLoginAccessCheck.php` (or simply disable the module via drush:
`drush pmu disable_login -y`, or set `disable_login` to 0 in config).
