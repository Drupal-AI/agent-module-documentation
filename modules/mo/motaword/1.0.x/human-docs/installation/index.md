# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0** or newer.
- A **MotaWord account** with an **Active** project, and an **Active token** for
  that project (found on the project page in your MotaWord dashboard —
  [sign up](https://www.motaword.com/)).

There are no other Drupal module dependencies and no third-party PHP libraries to
install manually.

> **Note:** this module is **not covered** by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/motaword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/motaword -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en motaword -y
```

Enabling the module does not start translating on its own — you must paste your
Active token first. See [Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep motaword
```

Then, after entering your Active token (next page), load a front-end page and
confirm the injected language switcher appears and switching language serves the
translated version.
