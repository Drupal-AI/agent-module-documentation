<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure login protection

Config object: **`disable_login.settings`** (schema `config/schema/disable_login.schema.yml`,
type `config_object`). The module ships **no `config/install`**, so every key is NULL until you
save the settings form or write config — meaning protection is off by default.

UI: *Configuration → Security → Disable Login Page* — route `disable_login.settings_form`
(form `\Drupal\disable_login\Form\SettingsForm`), path `/admin/config/security/disable-login`,
permission **administer site configuration**. Menu link in `disable_login.links.menu.yml` under
`system.admin_config_security`.

## Keys

| Key | Type | Meaning |
|---|---|---|
| `disable_login` | boolean | master on/off for the protection |
| `allow_secret` | boolean | whether a secret-key URL bypass is permitted at all |
| `querystring` | string | the query parameter **name** to look for (form defaults the field to `key` when empty; shown only when `allow_secret` is checked) |
| `secret` | string | the required parameter **value** (shown only when `allow_secret` is checked) |

`SettingsForm::submitForm()` saves all four keys. `disable_login_post_update_enable_allow_secret()`
(in `disable_login.post_update.php`) sets `allow_secret` to TRUE on existing installs so upgrades
keep their previous bypass behavior.

## How access is decided

`\Drupal\disable_login\Access\DisableLoginAccessCheck::access()` runs on `user.login` and
`user.login.http` (attached by `DisableLoginRouteSubscriber::alterRoutes()` via the
`disable_login_access_check` requirement). Order of decisions:

1. Route not one of the two login routes → **allowed** (defensive; the checker is only wired to those two).
2. `disable_login` falsey → **allowed** (no protection).
3. `disable_login` on but `allow_secret` falsey → **forbidden** (login page blocked outright, no URL bypass).
4. Otherwise the page cache kill switch is triggered, then the core flood service is consulted:
   `userFloodControl->isAllowed('disable_login.failed_key_ip', user.flood:ip_limit, user.flood:ip_window)`.
   If the IP has exceeded the limit → **forbidden** for the rest of the window (even with the correct key).
5. It reads `request->query->get(querystring)`, applies `hook_disable_login_key_alter()` to the
   stored `secret`, and compares with `hash_equals($secret, $key_value)` (constant-time), requiring
   both to be non-empty. Match → **allowed**. Mismatch → registers a flood failure and returns **forbidden**.

So with `disable_login=1`, `allow_secret=1`, `querystring=key`, `secret=abc123`:

```
/user/login              → 403 Access Denied
/user/login?key=abc123   → login form
```

Give staff the bookmarkable URL with the querystring. Cache handling: the decision depends on
`disable_login.settings`, `user.flood`, the `url.query_args:<querystring>` cache context, and sets
max-age 0 once flood logic engages, so it is re-evaluated per attempt.

## Enable via drush / config

```bash
drush cset disable_login.settings disable_login 1 -y
drush cset disable_login.settings allow_secret 1 -y
drush cset disable_login.settings querystring key -y
drush cset disable_login.settings secret abc123 -y
```

Or PHP:

```php
\Drupal::configFactory()->getEditable('disable_login.settings')
  ->set('disable_login', TRUE)->set('allow_secret', TRUE)
  ->set('querystring', 'key')->set('secret', 'abc123')->save();
```

Read back: `drush cget disable_login.settings`.

## Escape hatch (locked out)

If you enable protection and then cannot reach the login page, disable it from the shell:

```bash
drush -y config-set disable_login.settings disable_login 0
# or uninstall entirely:
drush pmu disable_login -y
```

(An IP that tripped the flood limit is also released once the `user.flood:ip_window` elapses.)

## Settings form screenshot

![Disable Login Page settings form](../../../../../../../screenshots/disable_login/1.2.x/settings-form.png)
