# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image**, **Link**, **Node**, and **Path** modules (all part of the
  standard install).
- A **paid X/Twitter developer account** with access to the **v1.1 API**, and an
  application registered there so you have a **Consumer Key** and **Consumer
  Secret**. (Only v1.1 is supported — not v2.)
- The module installs its required third‑party libraries via Composer, so install
  it with Composer rather than by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/get_tweets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer download the required
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/get_tweets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en get_tweets -y
```

## Verify it worked

Go to **Configuration → Web services → Get Tweets**
(`/admin/config/services/get-tweets`). If the settings form loads, the module is
installed. Continue with [Configuration](../configuration/index.md) to add your
API credentials and set up feeds — nothing is imported until you do.
