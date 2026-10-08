# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) and **Node** module (`node`), both part of a
  standard Drupal install and enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_label_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_label_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_label_visibility -y
```

## Grant the permission

The settings page is gated by the **Administer Field Label Visibility**
permission, which is restricted by default. Grant it to the roles that should
manage label visibility at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Go to **Configuration → User interface → Field Label Visibility**
(`/admin/config/user-interface/field-label-visibility`). If the settings page
loads and lists your content types, the module is installed. Continue to
[Configuration](../configuration/index.md) to enable the controls on a content
type and start customizing labels.
