# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`). Drupal 9 and
  Drupal 10 releases older than 10.6 are not supported by this 2.0.x release.
- Drupal core's **Media** module (`media`), which Drupal enables automatically as
  a dependency.
- A **Calaméo account** with API access, so you can obtain the API key and API
  secret key the module needs. The credentials come from the Calaméo Developers &
  API page (`https://developer.calameo.com/content/api`).

There are no contributed‑module dependencies and no third‑party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_calameo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_calameo -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_calameo -y
```

Core's Media module is enabled automatically if it is not already on.

## Configure the required API credentials

This release will report a configuration **error** on the status report until the
Calaméo API credentials are set. Go to
`/admin/config/media/media_entity_calameo` and enter your Calaméo **API Key** and
**API Secret Key** (both required), then save.

## Verify it worked

Confirm the Calaméo settings form appears at
`/admin/config/media/media_entity_calameo`. Then visit **Structure → Media types
→ Add media type** (`/admin/structure/media/add`) and confirm that **Calaméo** is
offered in the **Media source** dropdown. Full step‑by‑step setup is in the
[main guide](../index.md).
