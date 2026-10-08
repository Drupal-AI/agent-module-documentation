# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Token](https://www.drupal.org/project/token) module (`token`) — this
  module extends it, so Token must be present and enabled.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/categorized_token_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Token is not already in your project, add it too:
`composer require drupal/token`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/categorized_token_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en categorized_token_filter -y
```

Enabling the module also enables Token if it isn't already on.

## Verify it worked

Open any admin form that offers a **Browse available tokens** link and click it.
Instead of a single long token list, you should now see a categorized filter
(Global types, entity types, and Other) that loads quickly even on sites with many
entities. There is no configuration to do.
