# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), part of the standard install.
- A **Stripe account** if you want to accept card donations (for the API keys and,
  optionally, webhooks).
- The **Paragraphs** module if you want to embed donation forms via Paragraphs
  (optional).
- **CiviCRM** if you plan to enable the `give_civicrm` submodule (optional).

## Install with Composer

From the project root:

```bash
composer require drupal/give -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/give -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en give -y
```

## Submodules

Give ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Give CiviCRM** | `give_civicrm` | Integrates donations with **CiviCRM**, so gifts recorded by Give flow into your CiviCRM contact/contribution records. Enable it only if you run CiviCRM. |

Enable it when you need it:

```bash
drush en give_civicrm -y
```

## Verify it worked

Open Give's settings (the *Configure* link on **Extend**, or under
**Configuration**). If the settings form loads, the module is installed. Nothing
can be collected until you configure a payment method — continue with
[Configuration](../configuration/index.md).
