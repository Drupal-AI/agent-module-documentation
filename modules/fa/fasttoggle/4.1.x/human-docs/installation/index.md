# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Node** (`node`) and **Comment** (`comment`) modules — both are
  dependencies and are enabled automatically as needed.
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/fasttoggle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fasttoggle -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fasttoggle -y
```

## Verify it worked

After enabling, grant the Fasttoggle permissions you need at **People →
Permissions** (see [Configuration](../configuration/index.md)). Then, as a user
with those permissions, view a piece of content or a comment: you should see
one‑click toggle links (such as *Publish* / *Unpublish*) that flip the setting
instantly without opening the edit form.
