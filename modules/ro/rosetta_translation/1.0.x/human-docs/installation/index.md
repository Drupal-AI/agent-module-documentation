# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **A running Rosetta backend server** that you host yourself. The module is the
  client side only; it needs a configured backend to talk to. See the
  [project page](https://www.drupal.org/project/rosetta_translation) and the
  upstream `au5ton/rosetta` guidelines for standing one up.
- The module automatically retrieves the `au5ton/rosetta` GitHub client project
  based on the version you choose on the settings form, so no separate PHP library
  install is required.

## Install with Composer

From the project root:

```bash
composer require drupal/rosetta_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rosetta_translation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rosetta_translation -y
```

## Verify it worked

Go to **Configuration → Regional and language → Rosetta Translation**
(`/admin/config/regional/rosetta-translation`). If the settings form loads, the
module is installed. It won't actually translate anything until you complete the
[configuration](../configuration/index.md) — filling in your server endpoint and
adding the drop‑down element to a Twig template.
