# Installation

## Requirements

- **Drupal 10.3 or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`), enabled on any standard Drupal site.

There are no contributed‑module dependencies, no external libraries, no
third‑party APIs, and no external services.

## Install with Composer

From the project root:

```bash
composer require drupal/node_secure -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_secure -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_secure -y
```

No extra content types, text formats, or permissions need to be created.

## Verify it worked

After enabling, go to **Configuration → Content authoring → Node Secure**
(`/admin/config/content/node-secure`) and protect a content type (see
[Configuration](../configuration/index.md)). Then open a node of that type: the
**Delete** tab should be gone, and the delete button should no longer appear on
its edit form. Visiting the node's `/delete` URL directly should be denied.
