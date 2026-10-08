# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Mattermost** instance where you can create an **incoming webhook** for the
  target channel. You'll paste that webhook URL into the module's configuration.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mattermost_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mattermost_logger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mattermost_logger -y
```

## Verify it worked

Go to **Configuration → Web services → Mattermost Logger**
(`/admin/config/services/mattermost-logger/settings`), add a logging channel with a
valid Mattermost incoming‑webhook URL, and choose a severity to forward. Then
trigger a matching log message — for example from custom code:

```php
\Drupal::service('mattermost_logger')->error('my_module', 'Test alert');
```

A color‑coded message should appear in the configured Mattermost channel. See
[Configuration](../configuration/index.md) for the full field‑by‑field walkthrough.
