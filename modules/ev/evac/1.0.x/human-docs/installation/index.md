# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **`egulias/email-validator`** PHP library (`^3` or `^4`) — Composer pulls it
  in automatically as a dependency.
- Optional: the PHP **`intl`** extension, required only if you want to use the
  **spoof-checking** validation.

There are no module dependencies and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/evac -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`egulias/email-validator` library and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/evac -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en evac -y
drush cr
```

The **cache rebuild** matters: Email Validator Customizer replaces core's
`email.validator` service at container-build time, so you need `drush cr` after
enabling (and after changing whether the replacement is active) for the swap to take
effect.

> **Note on the service swap.** The module only replaces core's validator if core
> still owns it. If another module has already overridden `email.validator`, that
> override wins and evac leaves it alone.

Next, choose how strict validation should be — see
[Configuration](../configuration/index.md).
