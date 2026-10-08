# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/critique_and_review -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/critique_and_review -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en critique_and_review -y
```

Enabling the module does not change the front end yet — you need to configure the
settings, define Review Items, and place the review block. See
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Content authoring → Critique and Review Module Settings**.
If the settings form loads, the module is installed correctly and you can begin
configuring which content types are reviewable and what Review Items reviewers will
work through.
