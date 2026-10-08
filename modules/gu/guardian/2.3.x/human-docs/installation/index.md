# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other Drupal module dependencies and no special PHP libraries.
- A **working, monitored mailbox** for the guarded account, and the ability to edit
  **`settings.php`** — the guarded email is a required `settings.php` key, and the
  module refuses to run without a valid one.

## Set the required `settings.php` key first

Guardian 2.3.x reads the guarded account's email (and an optional idle timeout)
from `settings.php`, via Drupal's `Settings` API. Add this **before** enabling the
module:

```php
$settings['guardian_mail'] = 'admin@example.com'; // REQUIRED. A monitored mailbox or group address for user 1.
$settings['guardian_hours'] = 2;                   // Optional (default 2). Idle-session timeout, in hours.
```

- `guardian_mail` is **mandatory**. Guardian's status check raises a requirement
  *error* if it is empty or not a valid email, so the module effectively won't run
  without it. On install and on cron, Guardian pins user 1's `mail` and `init` to
  this value and nulls its password.
- `guardian_hours` sets the inactivity timeout: a guarded session older than
  `3600 × guardian_hours` seconds is destroyed on the next request, sending the
  user to `/user/password`.

Use a **shared inbox or group address** so access to the account doesn't depend on
one person. When someone leaves, revoking their webserver and inbox access is
enough to secure the account — there is no shared password to rotate.

## Install with Composer

From the project root:

```bash
composer require drupal/guardian -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/guardian -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en guardian -y
```

On enable, Guardian immediately applies its protection to user 1 (pins the mail,
nulls the password). Enabling and disabling the module also sends a notification
mail.

## Verify it worked

- **Check requirements:** visit **Reports → Status report** — if `guardian_mail`
  is missing or invalid, you'll see a Guardian error there.
- **Password login is gone:** confirm the guarded account can no longer log in with
  a password.
- **Both entry paths work:** request a reset at `/user/password` and confirm the
  mail arrives and logs you in; run `drush uli 1` and confirm the link works.

Don't rely on Guardian until at least one of the two entry paths is proven to work.
