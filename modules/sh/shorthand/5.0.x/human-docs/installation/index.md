# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **Text** module (`text`), which Drupal enables automatically as a
  dependency.
- A **Shorthand account** and an **API token** from that account (you enter it in
  the module's settings — see [Configuration](../configuration/index.md)).
- Optional: the [Metatag](https://www.drupal.org/project/metatag) module, if you
  want a story's meta tags copied onto the host entity.

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/shorthand -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/shorthand -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shorthand -y
```

## The example submodule (optional)

Shorthand ships one submodule, **shorthand_example** (`shorthand_example`), which
creates a ready-made **Shorthand story** content type already wired up with a
Shorthand field. It is the fastest way to see a story render — enable it if you
want a working example to start from:

```bash
drush en shorthand_example -y
```

> Note: the Drush clean-up command (`drush shorthand:clean-up`) looks for a
> `field_shorthand` field on `shorthand_story` nodes, but the example submodule
> actually creates a field named `field_shorthand_story`. Double-check your
> bundle and field names before running the clean-up command so it does not
> delete downloaded stories it cannot see as "in use".

Once enabled, continue to [Configuration](../configuration/index.md) to enter
your API token and download your first story.
