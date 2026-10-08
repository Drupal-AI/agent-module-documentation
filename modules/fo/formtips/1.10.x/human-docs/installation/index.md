# Installation

## Requirements

Form Tips is lightweight and has no hard dependencies:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements.

It has one *optional* integration:
[`form_placeholder`](https://www.drupal.org/project/form_placeholder). If that
module is enabled, Form Tips automatically wires in its library so descriptions
can also become input placeholders — no extra configuration needed.

## Install with Composer

From the project root:

```bash
composer require drupal/formtips -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/formtips -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formtips -y
```

Form Tips starts converting form descriptions into tooltips on non-admin pages
immediately. To adjust the trigger, width, excluded fields, themes, and hover
timing, see the *How to use it* section on the [overview page](../index.md) —
those settings live at **Configuration → User interface → Form Tips**.
