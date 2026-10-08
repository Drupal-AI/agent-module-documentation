# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) — provides the contact forms whose fields
  you'll override.
- Core's **Field UI** module (`field_ui`) — provides the Manage fields interface
  the overrides appear on.

Drupal enables both dependencies automatically when you turn on this module.
There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_default_fields_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_default_fields_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_default_fields_override -y
```

## Verify it worked

Go to **Structure → Contact forms**, edit one of your forms, and open its **Manage
fields** tab. Alongside any fields you've added, you should now see the default
**name**, **email**, **subject** and **message** fields available to edit. See
[Configuration](../configuration/index.md) for what you can change on each.
