# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules outside Drupal core are required.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_link_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_link_display -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_link_display -y
```

## Verify it worked

Go to the **Manage Display** tab of any fieldable entity type (for example a content
type). You should see a **Display Link** field in the disabled/hidden region. Move it
into a visible region, set its options, and save — the link then renders on that view
mode. See the ["How to use it"](../index.md) section for the formatter options.
