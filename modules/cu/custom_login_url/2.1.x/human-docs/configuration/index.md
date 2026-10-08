# Configuration

Custom Login Url has **no admin form and no configuration entity**. Everything is
controlled by one value in `settings.php`, so the secret path stays out of the
database and out of exported configuration.

## Set your secret login path

Add this to `sites/default/settings.php` (or your environment-specific settings
file), choosing your own hard-to-guess path:

```php
// The trailing slash is required — it is auto-appended if you leave it off.
$settings['custom_login_pattern'] = 'my_login_url/';
```

Then rebuild the route cache so the new paths take effect:

```bash
drush cr
```

With the example above, your login form moves to `/my_login_url/login` and the other
account pages move under `/my_login_url/…`.

## Rules for the value

- **Default (unset):** the pattern is `/user/`, so the site behaves normally until
  you set a value.
- **Trailing slash:** required. If you omit it (e.g. `'my_login_url'`), the module
  appends one automatically.
- **Empty or bare `/`:** not allowed — the module throws an error, because an empty
  pattern would be meaningless.
- **Per environment:** because it lives in `settings.php`, you can (and should) use
  a different path on dev, staging, and production. Rotate it quickly by editing the
  one value if you ever suspect it has leaked.

## What exactly moves

- **Every `/user/*` route** — login, password reset, register, profile edit, and so
  on — is relocated behind your prefix. For example `/user/password` becomes
  `/my_login_url/password`.
- **The login form** (`user.login`) lives at the pattern root plus `login`, i.e.
  `/my_login_url/login`.
- **The old `/user` page** is forced to return a hard **404**. It no longer redirects
  anonymous visitors to the login page, so a scanner can't use it to confirm a Drupal
  login exists.
- **Theming is preserved** — the module keeps Drupal's normal `page--user` and
  `page--user--login` template suggestions on the relocated pages, so your custom
  templates still apply.

## Things to watch out for

- **Obscurity, not hardening.** Anyone who discovers the path reaches the standard
  login form. Pair this with flood/rate limiting and two-factor authentication for
  real protection.
- **Hardcoded links break.** Any third-party link, bookmark, or redirect pointing
  at `/user/login` will now hit a 404. Update them to the new path.
- **Not in config export.** Because the value lives only in `settings.php`, it won't
  travel with `drush config:export` — document it as part of your deployment setup.
