# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No required contrib modules and no third‑party PHP libraries.
- A **Sender.net account** with a valid **API access token** — the integration
  cannot connect without one.

## Install with Composer

From the project root:

```bash
composer require drupal/sender_net -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sender_net -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sender_net -y
```

## After enabling

1. Obtain an API access token from your Sender.net account.
2. Enter it (and the API base URL) on the settings form — see
   [Configuration](../configuration/index.md).
3. Place the **Sender.net Subscription Block** from **Structure → Block Layout**.

## Verify it worked

Go to **Configuration → System → sender.net**. Once you have saved a valid token
and base URL, the form should be able to load the available groups for you to
choose from.
