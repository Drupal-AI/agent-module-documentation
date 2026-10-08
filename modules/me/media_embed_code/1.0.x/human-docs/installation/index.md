# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **Media** (`media`) and **Media Library** (`media_library`)
  modules. Drupal enables these automatically as dependencies when you turn on
  Media Embed Code.

There are no contributed‑module dependencies and no third‑party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_embed_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_embed_code -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_embed_code -y
```

Core's Media and Media Library modules are enabled automatically if they are not
already on.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`). You should see a new
**Embed Code** media type in the list. Then visit **Content → Media → Add media**
(`/admin/content/media`) and confirm that **Embed Code** appears as an option.

Before letting editors use it, review **People → Permissions**
(`/admin/people/permissions`) and grant the *Embed Code: Create/Edit* permissions
only to trusted, administrative roles — see the security note in the
[main guide](../index.md).
