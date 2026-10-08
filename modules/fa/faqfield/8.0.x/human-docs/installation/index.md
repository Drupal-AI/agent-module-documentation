# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), part of the standard Drupal install.
- The **jQuery UI Accordion** module (`drupal/jquery_ui_accordion`, `^2.0`), which
  Composer installs automatically as a dependency. It powers the default
  accordion display formatter.

There are no other Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/faqfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the jQuery UI
Accordion module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/faqfield -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en faqfield -y
```

This also enables the jQuery UI Accordion dependency. Once enabled, **FAQ Field**
is available as a field type when you add a field to a content type or other
fielded entity — see the **How to use it** section on the
[overview page](../index.md).
