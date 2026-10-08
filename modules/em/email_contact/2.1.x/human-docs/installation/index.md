# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- An entity with a core **Email** field to apply a formatter to (nodes, users,
  taxonomy terms, media — anything with an email field).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/email_contact -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/email_contact -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_contact -y
```

## Optional: token support

If you install the **Token** module (`drupal/token`), the formatters' "additional
message" field supports token replacement (for example `[current-page:url]`). It's an
optional dependency — enable it only if you want tokens in your contact-form emails:

```bash
composer require drupal/token -W
drush en token -y
```

## Next step

The formatters are now available on any email field. Apply one on an entity's *Manage
display* screen — see [Configuration](../configuration/index.md).
