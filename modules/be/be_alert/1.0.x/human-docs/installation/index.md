# Installation

## Requirements

- **Drupal core `^10 || ^11`**.
- A **BE-Alert account and API credentials** from the Belgian BE-Alert service —
  the module has nothing to connect to without them.

There are no Composer library or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/be_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/be_alert -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en be_alert -y
```

## Store the API credentials securely

Do not put BE-Alert credentials in code or in exported configuration. Store the
secret in an environment variable and reference it from Drupal. With DDEV:

```bash
ddev dotenv set .ddev/.env --be-alert-api-key=<value>
ddev restart
```

Keep `.ddev/.env` out of version control. After enabling the module, grant its
permission under **People → Permissions** and configure the connection under
**Configuration** as described in the [overview](../index.md#how-to-use-it).
