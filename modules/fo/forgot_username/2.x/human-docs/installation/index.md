# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies. The site must be able to send email
(Drupal's mail system), since the module emails the username to the account
owner.

## Install with Composer

From the project root:

```bash
composer require drupal/forgot_username -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forgot_username -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forgot_username -y
```

## Verify it worked

As a logged‑out visitor, go to **`/user/username`**. You should see the
forgot‑username form. Enter the email of a test account and confirm the username
is emailed to that address.
