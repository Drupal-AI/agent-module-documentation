# Installation

## Requirements

- **Drupal 10.4+ or 11** (`core_version_requirement: ^10.4 || ^11`). If you run an
  older core (Drupal 8.8–10.3 or 9), use the module's 3.x branch instead; this
  guide covers the 4.0.x branch.
- Core modules **Node**, **Field**, and **Serialization** — Drupal enables these
  automatically as dependencies.
- The Composer library **`openagenda/sdk-php` >= 1.3.1** — pulled in automatically
  when you require the module with Composer. The module uses this SDK for all
  communication with the OpenAgenda API.
- An **OpenAgenda account** with a public key and at least one agenda (identified
  by its UID). You must be a member of any agenda you want to display.

## Install with Composer

From the project root:

```bash
composer require drupal/openagenda -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`openagenda/sdk-php` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openagenda -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openagenda -y
```

Drupal will enable the required core modules (Node, Field, Serialization) along
with it, and install the default **OpenAgenda** content type and field.

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) to enter your
OpenAgenda public key and connect an agenda. Once connected, use the default
**OpenAgenda** content type (or add an OpenAgenda field to your own type) and
confirm that the agenda's events render on the page.
