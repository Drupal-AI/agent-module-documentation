# Installation

## Requirements

Views moderation state weights needs:

- **Drupal 10.3 or 11** and **PHP 8.1 or newer** (the module's Composer
  requirements are `drupal/core: ^10.3 || ^11` and `php: >=8.1`).
- Core's **Content Moderation** (`content_moderation`), **Views** (`views`), and
  **Workflows** (`workflows`) modules enabled. Drupal enables these as dependencies
  when you turn this module on. You also need at least one workflow assigned to a
  moderated entity type for the Views handlers to appear.

There are no third-party libraries or contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/views_moderation_state_weights -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_moderation_state_weights -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_moderation_state_weights -y
```

On enable, the module reads your existing Content Moderation workflows and builds
its internal weights table. From then on there is nothing to configure — the
**Moderation state weight** field and sort become available in the Views UI for any
moderated entity type. See the [overview](../index.md) for how to add one to a view.
