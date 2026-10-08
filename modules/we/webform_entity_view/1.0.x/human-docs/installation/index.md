# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Webform** module (`drupal/webform`, version `^5.6 || ^6`) — this is the only
  dependency, and Drupal enables it automatically when you turn on Webform Entity View.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_entity_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the Webform
module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_entity_view -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_entity_view -y
```

That's all it takes. The new **Entity View** element becomes available in the Webform
builder immediately. There is no required configuration and no settings page — see
[Configuration](../configuration/index.md) for how to add and set up the element on a form.
