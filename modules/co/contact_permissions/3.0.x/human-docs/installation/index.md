# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) — the only dependency, enabled
  automatically by Drupal. Specifically, this module governs core's *personal*
  contact form feature.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_permissions -y
```

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`) and confirm the new
personal-contact-form permission (for example **Have a personal contact form**)
appears. See [Configuration](../configuration/index.md) for assigning it to the
right roles.
