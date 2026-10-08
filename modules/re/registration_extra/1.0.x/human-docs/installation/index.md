# Installation

## Requirements

Registration Extra needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The contributed **Registration** module (`registration`) — this is a hard
  dependency; Registration Extra only adds features to it.

There are no third‑party Composer or PHP library requirements.

> **Note:** this project is **not covered by Drupal's security advisory policy**.
> Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/registration_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the required Registration module if it isn't
present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/registration_extra -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en registration_extra -y
```

This enables **Registration** too if it is present but not yet enabled.

## Verify it worked

Go to **Structure → Registration types** and edit a registration type. You should
see the extra options Registration Extra adds (default confirmation message,
organizer emails, reminder template, and the organizer-notification toggle). See
[Configuration](../configuration/index.md) for what each one does.
