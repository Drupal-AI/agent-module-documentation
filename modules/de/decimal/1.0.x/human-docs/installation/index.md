# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1||^10||^11`).
- Core's **Field** module (`field`) — part of a standard Drupal install, and
  enabled automatically as a dependency.
- The **`brick/math`** Composer package, used for big-decimal arithmetic. It is
  bundled with / pulled in by the module when you install it via Composer.

There are no front-end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/decimal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `brick/math`
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/decimal -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decimal -y
```

## Verify it worked

Go to any bundle's **Manage fields** screen (for example **Structure → Content
types → *(your type)* → Manage fields**), click **Add field**, and confirm that
**Decimal** appears in the list of available field types. Add it to a bundle, save
some content with a precise decimal value, and check that it stores and displays
exactly as entered. See [How to use it](../index.md#where-it-lives-and-how-to-use-it)
in the main guide for the full field-setup steps.
