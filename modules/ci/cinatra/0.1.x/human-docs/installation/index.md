# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Node** (`node`) and **User** (`user`) modules — part of a standard
  Drupal install.
- **A Cinatra instance you can reach**, with the assistant turned on. See
  [cinatra.ai](https://www.cinatra.ai) to learn about and host Cinatra. With an
  older instance the panel shows an "update Cinatra" notice instead of the
  assistant.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cinatra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (You can also place the module under
`modules/custom/cinatra/`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cinatra -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cinatra -y
```

## Verify it worked

Go to **Configuration → Web services → Cinatra**
(`/admin/config/services/cinatra`) and confirm the settings form loads with a
"Connect with Cinatra" option. Then continue to
[Configuration](../configuration/index.md) to connect to your instance and grant
editors the assistant permission — the panel doesn't appear until both are done.
