# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **paid Copyscape (Premium) subscription** with API access. The Copyscape API
  is not available to free accounts, so you must purchase a subscription and obtain
  your API username and API key before the module can do anything useful.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/copyscape -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/copyscape -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en copyscape -y
```

## Store your Copyscape API credentials securely

Your Copyscape API username and key are secrets — never hard‑code them into code or
commit them to version control. Keep them in an environment variable and reference
them from Drupal.

With DDEV, save the key into an env file and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --copyscape-api-key=<your-key>
ddev restart
```

The flag `--copyscape-api-key` becomes the environment variable
`COPYSCAPE_API_KEY`. Keep `.ddev/.env` out of version control.

You can then reference that variable from settings, or — if you use the
[Key](https://www.drupal.org/project/key) module — create a Key entity backed by
the environment variable so the credential never lives in your exported config.

## Verify it worked

Enable the module, then head to
[Configuration](../configuration/index.md) to enter your account details and pick
the fields to check. A quick sanity check is to save a node whose selected field
contains text you know exists elsewhere online — a properly configured module will
run it against Copyscape.
