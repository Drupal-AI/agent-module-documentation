# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Tamper** module (`tamper`) — this is the plugin framework the Read Time
  Calculator plugs into. In practice you also use it together with **Feeds** and
  **Feeds Tamper** so the plugin can be attached to a feed type's mapping.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feed_tamper_read_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Tamper and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feed_tamper_read_time -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feed_tamper_read_time -y
```

Drupal enables the Tamper dependency automatically. If you have not already, also
enable Feeds and Feeds Tamper so you can attach the plugin to an import:

```bash
drush en feeds feeds_tamper -y
```

## Verify it worked

Open one of your feed types at **Structure → Feed types → *(feed type)* →
Mapping**, open the Tamper settings for a source, and confirm that **Read Time
Calculator** appears in the list of available tamper plugins. If it does, the
module is installed and ready.
