# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- A **development environment** — this module is not intended for production.

There are no third-party Composer or PHP library requirements.

> **Project status:** Log Context is currently marked **unsupported** with no
> further development planned. It's still useful as a local debugging aid, but
> don't build anything that depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/log_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/log_context -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en log_context -y
```

## Verify it worked

Open your browser's developer console and interact with the site (trigger some Ajax
or open a modal). You should see the `context` variable logged each time
`Drupal.attachBehaviors` runs. Disable the module when you've finished debugging.
