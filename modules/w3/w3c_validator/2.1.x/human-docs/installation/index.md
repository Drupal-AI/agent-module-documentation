# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **`rexxars/html-validator`** PHP library (`^2.3.0`) — installed
  automatically as a Composer dependency of the module, so you don't add it
  yourself.
- Access to a **W3C Markup Validator endpoint**. You can use the public
  `validator.nu` / `validator.w3.org` service for light use, but for anything more
  than occasional checks a self-hosted `w3c_markup_validator` instance is strongly
  recommended (the public service is rate-limited, and the module warns when you
  point it at one).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/w3c_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`rexxars/html-validator` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/w3c_validator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en w3c_validator -y
```

## Next steps

Head to [Configuration](../configuration/index.md) to set the validator endpoint
(and decide on the token and admin-pages options) before running your first
validation batch.
