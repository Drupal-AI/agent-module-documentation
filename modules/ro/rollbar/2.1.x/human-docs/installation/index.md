# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Rollbar PHP SDK** (`rollbar/rollbar`, `^4.0`) — Composer installs this
  library for you.
- A **Rollbar account** with a project, which gives you two access tokens: a
  server token (scope `post_server_item`) and a client token (scope
  `post_client_item`).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/rollbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the Rollbar SDK and
update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rollbar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rollbar -y
```

There are no submodules.

## Supply your tokens safely

Rollbar access tokens are secrets, so keep them out of exported configuration. The
recommended pattern is to store each token in an environment variable and override
the config value in `settings.php`:

```php
// settings.php
$config['rollbar.settings']['access_token'] = getenv('ROLLBAR_SERVER_TOKEN');
$config['rollbar.settings']['access_token_frontend'] = getenv('ROLLBAR_CLIENT_TOKEN');
```

With DDEV you can store the values with
`ddev dotenv set .ddev/.env --rollbar-server-token=<value>` (never commit
`.ddev/.env`), then `ddev restart` so the container picks them up. See the project
`AGENTS.md` for the full secrets workflow.

Alternatively you can just paste the tokens into the settings form — but then they
live in your database configuration and any config export. The environment‑variable
approach is safer, especially across production/staging/dev.

After enabling, head to [Configuration](../configuration/index.md) to finish
setup — remember that **nothing is sent to Rollbar until you turn the module on**.
