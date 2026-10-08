# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`).
- The [Paragraphs Browser](https://www.drupal.org/project/paragraphs_browser)
  module (`paragraphs_browser`) — the module whose configuration this one makes
  deployable.
- **Drush**, since this module is driven entirely by Drush commands.

There are no third‑party Composer or PHP library requirements beyond the Drupal
modules above.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_browser_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Paragraphs
Browser dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_browser_deploy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_browser_deploy -y
```

## Verify it worked

Confirm the module's Drush commands are available:

```bash
drush list | grep paragraphs-browser-deploy
```

You should see `paragraphs-browser-deploy:deploy` and
`paragraphs-browser-deploy:change` listed. With an images folder in place (files
named after each paragraph type's machine name), run
`drush paragraphs-browser-deploy:deploy` and check that the Paragraphs Browser
palette now shows the updated images.
