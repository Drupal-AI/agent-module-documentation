# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Media** (and Image) modules.
- The **[Imagecache External](https://www.drupal.org/project/imagecache_external)**
  module — used to fetch and cache remote images from Cision.
- The **[Key](https://www.drupal.org/project/key)** module — used to store the
  Cision API username and password securely.
- A **Cision account** with API access (username and password for the
  Communications Cloud API).

Composer will pull in the contributed dependencies automatically when you require
the module.

## Install with Composer

From the project root:

```bash
composer require drupal/cision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
Key and Imagecache External dependencies alongside Cision.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cision -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cision -y
```

This enables Cision and its dependencies (Media, Imagecache External, Key).

## Configure the API credentials and block

Cision has no dedicated settings form; setup happens through the Key module and the
block system:

1. Create a Key named **`cision_username`** at
   **Configuration → System → Keys** (`/admin/config/system/keys/manage/cision_username`)
   holding your Cision API username.
2. Create a Key named **`cision_password`** at
   `/admin/config/system/keys/manage/cision_password` holding your Cision API
   password.
3. Place and configure the **Cision** block via **Structure → Block layout** or
   Layout Builder, choosing the search and time period to display.

> **Keep secrets out of code.** For the credential values, prefer an environment
> variable consumed by a Key entity rather than typing the password into a form
> that could end up in a configuration export. With DDEV you can store a value with
> `ddev dotenv set .ddev/.env --cision-password=<value>` and `ddev restart`, then
> back the Key with the `env` provider.

## Verify it worked

With both keys set and the block placed, view the page holding the Cision block as
a visitor — it should display the total mentions for your chosen search and period.
If it is empty or errors, re-check the two key values and confirm your Cision API
account is active.
