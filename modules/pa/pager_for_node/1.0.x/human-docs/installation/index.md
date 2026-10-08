# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

Pager For Node is a simple module with **no module dependencies** beyond Drupal core, and
no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pager_for_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pager_for_node -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pager_for_node -y
```

## After installation

The pager is enabled **per content type**, not from one central settings page. Go to
**Structure → Content types**, edit the content type you want, open its **Pager for node
settings** tab, tick **Build a pager for this content type**, set the previous/next
labels, and save. Full steps are in the module's
[overview](../index.md#how-to-use-it).

## Verify it worked

After enabling the pager on a content type, view a node of that type — the previous/next
navigation links should appear, letting you browse to neighbouring nodes.
