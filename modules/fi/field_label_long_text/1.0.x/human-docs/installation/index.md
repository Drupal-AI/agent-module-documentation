# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Field** module (`field`) — part of Drupal core and normally already
  enabled.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_label_long_text -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_label_long_text -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_label_long_text -y
```

## Verify it worked

Open the module's settings form under **Configuration** (route
`field_label_long_text.admin_settings`, at a path such as
`/admin/config/field_label_long_text`). Choose a label input type and, if using a
text field, a raised character limit, then save — see
[Configuration](../configuration/index.md). Afterwards, edit a field and confirm
its label input honours your chosen type and limit.
