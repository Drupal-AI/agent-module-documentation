# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- The contrib **Encrypt** module (`encrypt`) if you want content encrypted at
  rest. BurnAfter's service wires up Encrypt's encryption-profile manager, so
  install [`drupal/encrypt`](https://www.drupal.org/project/encrypt) and set up an
  encryption profile before you turn on the encryption option. (The dependency is
  used at runtime even though it is not declared in the module's `.info.yml`, so
  install it explicitly.)

## Install with Composer

From the project root:

```bash
composer require drupal/burnafter -W
```

To install Encrypt at the same time:

```bash
composer require drupal/burnafter drupal/encrypt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/burnafter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en burnafter -y
```

If you plan to use encryption, enable Encrypt too and configure an encryption
profile first:

```bash
drush en encrypt burnafter -y
```

After enabling, review the [Configuration](../configuration/index.md) page and
grant the *create*, *view*, and *administer* permissions to the right roles under
**People → Permissions**.
