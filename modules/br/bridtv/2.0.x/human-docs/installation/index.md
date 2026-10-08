# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Media** module (`media`) — Brid.TV depends on it and Drupal will enable
  it automatically as a dependency.
- A **Brid.TV account** with the identifiers and API credentials the integration
  needs.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bridtv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bridtv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bridtv -y
```

Core Media is enabled automatically as a dependency if it is not already on.

## Store your Brid.TV credentials as a secret

Brid.TV credentials (API keys, tokens, and any partner/player identifiers you must
keep private) are secrets — never hard‑code them in settings or commit them to
configuration. With DDEV, save the value into an environment variable that DDEV
loads into the web container:

```bash
ddev dotenv set .ddev/.env --bridtv-api-key=your-real-key-here
ddev restart
```

The flag `--bridtv-api-key` becomes the variable `BRIDTV_API_KEY`. Keep
`.ddev/.env` out of version control. Reference the variable from your site
configuration rather than pasting the raw value into a settings form.
