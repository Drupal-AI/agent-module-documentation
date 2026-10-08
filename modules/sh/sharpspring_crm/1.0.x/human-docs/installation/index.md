# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Webform** module. It is not listed as a hard dependency in the module's
  metadata, but the whole feature works through Webform handler plugins, so you need
  Webform installed and a webform to attach the handlers to.
- A **SharpSpring account** with an account ID and a Public API secret key (from your
  SharpSpring account settings).

There are no third-party Composer packages or PHP library requirements beyond the
above.

## Install with Composer

From the project root:

```bash
composer require drupal/sharpspring_crm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Webform is not already in your project, add it too:

```bash
composer require drupal/webform -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharpspring_crm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharpspring_crm -y
```

Make sure Webform is enabled as well (`drush en webform -y`) if it was not already.

## Next step

Enter your SharpSpring credentials and attach a handler to a webform. See
[Configuration](../configuration/index.md).
