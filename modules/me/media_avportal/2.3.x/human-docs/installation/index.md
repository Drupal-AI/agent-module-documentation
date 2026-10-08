# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) — this module extends it and is the only Drupal
  dependency.
- **Outbound network access** from your site to the EU AV Portal, since media are fetched
  and referenced remotely rather than stored locally. If the portal is unreachable, the
  referenced media will not be available (there is no local fallback copy).

## Install with Composer

From the project root:

```bash
composer require drupal/media_avportal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_avportal -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_avportal -y
```

## Verify it worked

Go to **Structure → Media types → Add media type** (`/admin/structure/media/add`). The **AV
Portal** media source should be available to choose. Create a media type with it, then add a
media item and paste an AV Portal video page URL into the resource field to confirm the
resource is fetched and displayed. Setting up the media type and the metadata‑refresh Drush
command is covered in "How to use it" in the [overview](../index.md).
