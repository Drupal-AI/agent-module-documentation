# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** (`language`) and **Interface Translation** (`locale`)
  modules — both are dependencies and are enabled automatically.
- A **multilingual site**: at least two configured languages, so there's something
  to negotiate between.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/user_account_language_negotiation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/user_account_language_negotiation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_account_language_negotiation -y
```

On install the module seeds locale translations of the standard language names, so
each language displays in its own native translation.

## Next steps

Enabling the module makes the **User account saver** plugin available, but you
still need to switch it on for a language type. Go to **Configuration → Regional
and language → Detection and selection** and enable it — the
[Configuration](../configuration/index.md) guide explains how. There are no
submodules.
