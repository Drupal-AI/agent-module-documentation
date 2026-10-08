<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `users_jwt.config` — `max_expiration`

## Schema

```yaml
users_jwt.config:
  type: config_object
  mapping:
    max_expiration:
      type: int
      label: 'The maximum allowed lifetime for a user JWT (seconds).'
```

The module ships **no `config/install`**, so `users_jwt.config` does not exist on a fresh
site until something creates it (a form this module doesn't provide, `drush cset`, or code).

## Set it

```bash
drush cset users_jwt.config max_expiration 3600 -y
```

```php
\Drupal::configFactory()->getEditable('users_jwt.config')->set('max_expiration', 3600)->save();
```

## Read it back

```bash
drush cget users_jwt.config max_expiration
```

## Important: this value is currently not enforced

There is no settings form, and — as of this module version —
`Drupal\users_jwt\Authentication\Provider\UsersJwtAuth::authenticate()` never reads
`users_jwt.config`. The actual, hard-coded rule it enforces is:

```php
if (!isset($payload->iat, $payload->exp) || ($payload->exp - $payload->iat > 24 * 3600)) {
  // rejected
}
```

i.e. every JWT must carry `iat`/`exp` and the lifetime must be **≤ 24 hours**, unconditionally.
The source even flags this as a `@todo` ("provide a config for maximum token lifetime").
Treat `max_expiration` as a **declared but not-yet-wired** setting: it validates and
round-trips through config exactly as documented above, but setting it does **not** change
what tokens the provider will accept. Don't rely on it to cap token lifetime below 24 hours
in production — only shortening `exp - iat` on the issuing side does that.

## Delete it (reset to default/unset)

```bash
drush cdel users_jwt.config -y
```
