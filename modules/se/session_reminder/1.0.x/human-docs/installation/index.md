# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **User** module (`user`), part of a standard Drupal install.
- No third-party Composer or PHP library requirements.
- Your site's session settings must allow expiry: the `cookie_lifetime` value in
  `services.yml` must be set, and `gc_maxlifetime` must **not** be `0` (if it is,
  session data never expires and the reminder cannot work — the settings page will
  warn you).

## Install with Composer

From the project root:

```bash
composer require drupal/session_reminder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/session_reminder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en session_reminder -y
```

Then clear the cache so the changes take effect:

```bash
drush cr
```

## Configure it

Once enabled, head to **Configuration → People → Session Reminder**
(`/admin/config/session-reminder`) to set the warning threshold, choose which roles
see the modal, and style its appearance. See [Configuration](../configuration/index.md).

## Verify it worked

Log in as a user in one of the selected roles and wait until the session approaches
the warning threshold you set (or lower the threshold temporarily to test). The
reminder modal should appear, with a button to extend the session. If no modal
appears, check that `cookie_lifetime` is set correctly and `gc_maxlifetime` is not
`0`.
