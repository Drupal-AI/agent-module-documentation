# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Drupal core's **Media** module (`media`), which Drupal enables automatically as
  a dependency.
- A **Calaméo account** with API access, so you can obtain the API key and API
  secret key the module needs.

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

## Verify it worked

Go to `/admin/config/media/media_entity_calameo` and confirm the Calaméo API
credentials form appears — that is where you enter your API key and secret. Then
visit **Structure → Media types → Add media type**
(`/admin/structure/media/add`) and confirm that **Calaméo** is offered in the
**Media source** dropdown. Full step‑by‑step setup is in the
[main guide](../index.md).
