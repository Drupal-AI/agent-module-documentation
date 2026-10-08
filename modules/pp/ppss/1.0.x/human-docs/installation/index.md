# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which this module depends on and Drupal will
  enable automatically.
- An account with the payment gateway you intend to use, and its API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/ppss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ppss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ppss -y
```

## Verify it worked

After enabling, grant the **`administer ppss`** permission to your administrator
role at **People → Permissions**, then head to the module's settings to pick a
gateway and enter its credentials — see [Configuration](../configuration/index.md).
Once configured, place the pay button block through **Structure → Block layout**
and confirm it appears for users who hold the **`view ppss button`** permission.
