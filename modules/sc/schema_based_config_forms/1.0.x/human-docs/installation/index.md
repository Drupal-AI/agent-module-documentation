# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).

There are no other module dependencies and no third-party PHP libraries to
install. (Optional type submodules may add support for further data types — enable
those only if you need the extra types.)

> **Heads up on security coverage:** this module is *not* covered by Drupal's
> security advisory policy, and at the time of writing it is a beta release. That
> is normal for a developer toolkit, but worth knowing before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_based_config_forms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_based_config_forms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_based_config_forms -y
```

Once enabled, the base class it provides is available to your custom modules.
There is no configuration UI — see the [main guide](../index.md) for how to use
it from code.
