# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- The **Rules** module (`rules`) and the **Token** module (`token`) — both are
  required dependencies. Drupal enables them automatically when you turn on
  Rules Token (install them with Composer first if they are not already
  present).

There are no third-party PHP library requirements. Optionally, the module also
recognises tokens from the **Custom Tokens** and **Custom Tokens Plus** modules
if you have them installed.

## Install with Composer

From the project root:

```bash
composer require drupal/rules_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Rules and Token
(and update any shared dependencies) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/rules_token -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rules_token -y
```

This also enables Rules and Token if they were not already on. The module ships
no submodules and adds no configuration page — the new action and conditions
appear directly in the Rules builder.
