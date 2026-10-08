# Installation

> **Development tool.** Development Assistant is designed so it can be uninstalled
> on production — enable it while building and testing, and remove it before or
> during a production deploy.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No hard module dependencies are declared, but the module is intended to work
  **alongside the Browser Development module**, whose configuration it consumes —
  install that too if you want the full workflow.
- No third-party PHP library requirements.

This project is **not** covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/development_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/development_assistant -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en development_assistant -y
```

There is nothing to configure after enabling. Grant the module's permission to your
developer roles under **People → Permissions** if needed.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep development_assistant
```

Since there is no settings page, the browser-development conveniences it provides
are available once it (and Browser Development) are enabled.
