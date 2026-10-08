# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Webform** module, version **^6.0** (`drupal/webform`). This is a hard dependency and
  Composer pulls it in.
- A **Salesforce Pardot** (Account Engagement) account with a **Form Handler** set up, so you
  have an endpoint URL to post to and know its expected field names.
- **Cron** running on the site — submissions are delivered from a queue when cron runs, not
  immediately.

There are no third-party PHP library requirements (the module uses Drupal's core HTTP client).

## Install with Composer

From the project root:

```bash
composer require drupal/webform_pardot -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Webform and updates shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/webform_pardot -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_pardot -y
```

Enabling it also enables Webform if needed. Nothing is sent to Pardot until you add the
handler to a webform — see [Configuration](../configuration/index.md).
