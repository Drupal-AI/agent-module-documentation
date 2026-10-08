# Installation

## Requirements

Hello World has no specific requirements beyond Drupal core:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

There are no Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/helloworld -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helloworld -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helloworld -y
```

## Verify it worked

Log in, look for the new **Hello World** menu link, and click it. Seeing the
greeting page render confirms the module installed and enabled correctly. There is
no configuration to do afterward.
