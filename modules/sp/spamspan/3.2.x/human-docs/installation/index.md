# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`; the Composer
  package also permits 9.5).
- Core's **Filter** module (`filter`) — part of core and enabled automatically as a
  dependency.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/spamspan -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spamspan -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spamspan -y
```

Enabling the module makes the **SpamSpan email address encoding filter** available on
your text formats and adds the **Email SpamSpan** field formatter and the `|spamspan`
Twig filter. It defines no permissions of its own — configuring it uses core's
**Administer filters** permission.

## Next steps

Enabling the module doesn't obfuscate anything yet — you have to turn the filter on for
the text formats you use. See [Configuration](../configuration/index.md).
