# Installation

## Requirements

Before you install, make sure you have:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module enabled. The **Media Library** module is not strictly
  required but is strongly recommended — the import and upload experience is built
  around the media library "Add media" flow.
- The **`bluebillywig/bb-sapi-php-sdk`** PHP library (version `^1.0`). You don't
  install this by hand — Composer pulls it in automatically when you require the
  module below.
- A **Blue Billywig account** with a publication subdomain and an API key ID +
  secret. Without these the module can't talk to the platform, so have them ready
  before you configure it.

## Install with Composer

From the project root:

```bash
composer require drupal/blue_billywig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, and it's what pulls in the `bluebillywig/bb-sapi-php-sdk`
library the module relies on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/blue_billywig -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blue_billywig -y
```

Drupal will enable core **Media** automatically if it isn't already on. There are
no submodules to choose from — Blue Billywig ships as a single module.

## Verify it worked

After enabling, go to **Reports → Status report**. The module registers a health
check there that calls the Blue Billywig API: until you've entered valid
credentials it will report an error, which is expected. Once you complete the
[Configuration](../configuration/index.md) step and save valid credentials, the
status report should turn green.
