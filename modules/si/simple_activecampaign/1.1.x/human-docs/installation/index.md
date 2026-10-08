# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **testmonitor/activecampaign** PHP library, which the module uses to talk to
  the ActiveCampaign API. It is installed automatically when you require the module
  with Composer, so there is nothing extra to download by hand.
- An **ActiveCampaign account** with an API URL and API key.

Note that this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_activecampaign -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the required `testmonitor/activecampaign`
library. Installing this module **with Composer is important** — it is how the API
library reaches your codebase.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_activecampaign -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_activecampaign -y
```

## After installing

The module does nothing until you connect it to ActiveCampaign and place the block:

1. Enter your **API URL and API key** at **Configuration → Web services →
   ActiveCampaign**.
2. Place and configure the **ActiveCampaign** block at **Structure → Block layout**.

See [Configuration](../configuration/index.md) for both steps. Keep your API key
out of version control — prefer storing it in an environment variable (or a Key
entity) rather than pasting a long-lived secret into configuration that gets
exported.
