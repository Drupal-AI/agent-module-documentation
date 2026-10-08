# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **symfony/var-dumper** library, used to render state values. Composer pulls
  it in automatically with the command below.
- No dependency on the Devel module.

## Install with Composer

From the project root:

```bash
composer require drupal/manage_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`symfony/var-dumper` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/manage_state -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en manage_state -y
```

No configuration is necessary — the tool works as soon as it's enabled.

## Verify it worked

Go to **Configuration → Development → State**
(`/admin/config/development/state`). You should see the state variables overview,
listing the State API keys currently set on your site. From here, see
[Configuration](../configuration/index.md) for how to use it safely.
