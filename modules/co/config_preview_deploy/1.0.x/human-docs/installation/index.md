# Installation

## Requirements

- **Drupal 10.3 or newer, or 11** (`core_version_requirement: ^10.3 || ^11`) — the core
  configuration **checkpoint** API it relies on requires a recent core version.
- Core's **System** module (`system`) — always present.
- **[Simple OAuth](https://www.drupal.org/project/simple_oauth)** (`simple_oauth`) — provides
  the OAuth 2.0 authentication that authorises deployments.
- **[Key](https://www.drupal.org/project/key)** (`key`) — stores the OAuth client secret.

Two modules are recommended alongside it:
[Config Checkpoint UI](https://www.drupal.org/project/config_checkpoint) (a UI for reverting
to generated checkpoints) and
[Config Ignore](https://www.drupal.org/project/config_ignore) (to exclude
environment‑specific config from deployment).

## Install with Composer

From the project root:

```bash
composer require drupal/config_preview_deploy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Simple OAuth, Key, and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_preview_deploy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_preview_deploy -y
```

Drupal enables Simple OAuth and Key at the same time if they are not already on. You will
install the module on **both** the preview environment and the production environment, since
each plays a role in the deploy flow.

## Verify it worked

Log in as an administrator and visit
`/admin/config/development/config-preview-deploy`. If the dashboard loads, the module is
installed. Then continue to [Configuration](../configuration/index.md) to set up the OAuth
trust between preview and production and to grant the deployment permissions — the module
does nothing useful until that trust is in place.
