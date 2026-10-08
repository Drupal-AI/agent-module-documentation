# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). There is
  **no Drupal 11 release** of this project.
- No other modules or libraries are required — pwd_reset has no dependencies.

## Install with Composer

`pwd_reset` is the module provided by the **`passwordpolicy`** project, so you
require that project (not a `pwd_reset` package):

```bash
composer require drupal/passwordpolicy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/passwordpolicy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the module by its machine name, `pwd_reset`:

```bash
drush en pwd_reset -y
```

There is nothing to configure afterwards — the module starts customising the
password-reset page immediately.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pwd_reset`.
2. Trigger a password reset for a test account (**People → Edit → Reset password**,
   or the "Reset your password" form) and open the reset link. The landing page
   should now be titled **"Reset password"**, show the password guidelines under
   the password field, and label the submit button **"Login"**. Setting a new
   password that fails the complexity rule should produce a validation error, and a
   successful reset should log you out and send you to the login form.
