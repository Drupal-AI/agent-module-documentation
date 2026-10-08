# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Analyze** module (`analyze`, version 1.1.0 or newer) — the framework this plugs
  into.
- The **Key** module (`key`) — used to store your PostHog API credentials securely.
- A **PostHog** account and project API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/analyze_posthog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/analyze_posthog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze_posthog -y
```

This also enables the Analyze and Key modules if they are not already on. Next, follow
[Configuration](../configuration/index.md) to store your PostHog credentials and grant
the viewing permission.
