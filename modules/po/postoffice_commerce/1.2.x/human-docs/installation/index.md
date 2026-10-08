# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Postoffice** module together with its **Compat** (`postoffice_compat`) and **Compat
  Theme** (`postoffice_compat_theme`) submodules.
- **Drupal Commerce** (`commerce`).

Composer resolves these dependencies for you with the `-W` flag below; the submodules are
enabled as dependencies when you turn on Postoffice Commerce.

## Install with Composer

From the project root:

```bash
composer require drupal/postoffice_commerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Postoffice and Commerce and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/postoffice_commerce -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en postoffice_commerce -y
```

Postoffice, Postoffice Compat, Postoffice Compat Theme, and Commerce are enabled as
dependencies.

## Turn it on for Commerce mail

After enabling, point Commerce's mail interface at the plugin:

```bash
drush config:set system.mail interface.commerce postoffice_commerce_mail
```

(If you use Commerce License, also run
`drush config:set system.mail interface.commerce_license postoffice_commerce_mail`.)

## Verify it worked

With Postoffice's transport configured, place a test order (or trigger an order‑receipt email)
and confirm the receipt is delivered as a themed Symfony message. See the
[manual setup guide](../index.md) for theming and the full command reference.
