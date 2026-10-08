# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Drupal core's **Contact** module (`contact`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Add Email To
  Contact.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/add_email_to_contact -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/add_email_to_contact -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en add_email_to_contact -y
```

There is no configuration. From now on, emails sent by core Contact forms include
the sender's email address. Send a test message to confirm.
