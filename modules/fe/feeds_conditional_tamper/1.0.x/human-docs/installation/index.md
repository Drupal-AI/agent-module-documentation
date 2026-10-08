# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Tamper** module (`tamper`).
- The **Feeds Tamper** module (`feeds_tamper`, version `^2.0`) — and, in turn, the
  Feeds module it builds on.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_conditional_tamper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Tamper, Feeds
Tamper, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_conditional_tamper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_conditional_tamper -y
```

Drupal enables the Tamper and Feeds Tamper dependencies automatically. Rebuild
the cache afterwards if the new plugins don't show up right away:

```bash
drush cr
```

## Verify it worked

Open a feed type at **Structure → Feed types → *(feed type)* → Mapping**, open the
Tamper settings for a source, and confirm that **Skip item on condition** and
**Skip value on condition** appear in the list of available tamper plugins.
