# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Link** module (`link`) — this is the only dependency, and Drupal
  enables it automatically as a dependency when you turn on this module.
- A **Martinus partner account** so you have a partner ID to enter. Register at
  <https://partner.martinus.sk>. (This is not a technical requirement for
  installing the module, but the formatter is only useful once you have an ID.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/martinus_partner_link_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/martinus_partner_link_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en martinus_partner_link_formatter -y
```

## Verify it worked

Go to the **Manage display** tab of any entity bundle that has a Link field. The
format drop‑down for that field should now list **Martinus Partner Link
Formatter**. Select it, enter your partner ID in the formatter settings, and save
— rendered Martinus links will carry your partner ID.
