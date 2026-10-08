<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Login Switch

One config object: **`login_switch.settings`**. Configure route `login_switch.settings`
→ `/admin/config/people/login-switch` (permission: core `administer site configuration`).

## Keys

Three route groups share the same three keys, prefixed by `login`, `register`, `password`:

| Key | Type | Meaning |
|---|---|---|
| `<key>_disabled` | bool | Turn the override ON for this route. If false, the route is untouched. |
| `<key>_route` | string (path, no leading slash) | New path to move the route to. Empty ⇒ route is denied. |
| `<key>_noindex` | bool | Add `X-Robots-Tag: noindex` header when this route is rendered. |

Where `<key>` ∈ {`login` → `user.login`, `register` → `user.register`, `password` → `user.pass`}.

Shipped defaults (`config/install/login_switch.settings.yml`): all three `*_disabled` false,
all `*_route` empty, all `*_noindex` false (module does nothing until configured).

### Behaviour matrix (per route)

- `*_disabled = false` → route unchanged (path and access as core ships).
- `*_disabled = true`, `*_route = 'secret-login'` → the route's path becomes `/secret-login`.
- `*_disabled = true`, `*_route = ''` → the route gets requirement `_access: 'false'` (403/denied).
- `*_noindex = true` → independent of the above; adds the noindex response header on that route.

The submit handler trims leading/trailing `/` from any `*_route` value, then rebuilds the router.

## Via drush

```bash
# Move the login form to /secret-login and hide it from search engines.
drush cset login_switch.settings login_disabled true -y
drush cset login_switch.settings login_route 'secret-login' -y
drush cset login_switch.settings login_noindex true -y
# Fully disable public registration (deny access):
drush cset login_switch.settings register_disabled true -y
drush cset login_switch.settings register_route '' -y
drush cr   # REQUIRED: rebuild the router / clear caches for new paths to resolve
```

Read back: `drush cget login_switch.settings`.

## Via settings.php (per-environment override)

```php
$config['login_switch.settings']['login_disabled'] = TRUE;
$config['login_switch.settings']['login_route'] = 'secret-login';
```

Note: overriding `login_route` alone is not enough — the matching `login_disabled` must be
TRUE for the route subscriber to apply the change.

## Config schema

`login_switch.schema.yml` types every `*_route` as `path` and every `*_disabled`/`*_noindex`
as `boolean`, so values are validated as part of `login_switch.settings`.
