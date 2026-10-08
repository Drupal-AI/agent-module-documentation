# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`) — a hard dependency, used to store your Google API
  credentials. Drupal will enable it as a dependency.
- A **Google Places** account with an API key (see
  [Configuration](../configuration/index.md)).
- *Optional, for the AI Automator features:* the **AI** module and a configured
  chat provider.

## Install with Composer

From the project root:

```bash
composer require drupal/google_places -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_places -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_places -y
```

This also enables the Key module if it is not already on.

## Verify it worked

Go to **Configuration → Google Places → Settings**
(`/admin/config/google_places/settings`). If the settings form loads, the module
is installed — next, add your API key as described in
[Configuration](../configuration/index.md).
