# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core only — there are no module dependencies and no PHP library
  requirements.

**Before you enable it:** make sure a real administrator account (with an
administrator role, not user 1) exists and can log in. Disabling user 1 without a
working replacement leaves nobody able to administer the site.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_user_1 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_user_1 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_user_1 -y
```

## Turn it on in settings.php

Enabling the module does **not** disable user 1 on its own — that's a deliberate
safety step. Once you've confirmed a working administrator account, add this line to
your site's `settings.php`:

```php
$config['disable_user_1.settings']['disable_user_1'] = TRUE;
```

This is often placed only in a production-specific settings file so the account stays
usable in local and staging environments.

## Verify it worked

With the flag set to `TRUE`, try to use the site as user 1 — it should be logged out
on any page it visits. Confirm that your genuine administrator account still works
normally. If you ever need user 1 back, set the value to `FALSE` (or remove the line).

**Recovery reminder:** `drush uli --uid=1` and Drush's user commands work below the
level this module intercepts, so command-line access remains your way back in even
while the account is disabled.
