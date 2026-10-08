# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- **Smart Content** (`smart_content`).
- The **Lytics** Drupal module (`lytics`), already installed and configured with a
  valid Lytics API token in its settings (`lytics.settings`). That token must have
  access to read the Lytics **schema** and **account settings**.

There are no third-party Composer packages or PHP libraries required beyond those
modules.

## Install with Composer

First make sure the core Lytics module is installed and configured. Then, from the
project root:

```bash
composer require drupal/smart_content_lytics -W
```

The Composer package name (`drupal/smart_content_lytics`) matches the module's
machine name (`smart_content_lytics`). The `-W` (`--with-all-dependencies`) flag
lets Composer install Smart Content and Lytics and update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_content_lytics -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_content_lytics -y
```

## Verify it worked

Open a Smart Content Decision Block and start authoring a segment. If everything is
wired up, you should be able to see and select your allowlisted Lytics attributes
among the available conditions. If they don't appear, re-check that the core Lytics
module is configured with a token that can read the schema and account settings.
