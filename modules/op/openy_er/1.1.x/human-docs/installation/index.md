# Installation

> **This release will not enable without a workaround.** The module declares a
> dependency on `plugin`, meaning the contrib project
> [`drupal/plugin`](https://www.drupal.org/project/plugin) — but it ships no
> `composer.json`, so Composer does not pull `drupal/plugin` in, and `drush en
> openy_er` fails with *"missing its dependency module plugin."* Require
> `drupal/plugin` explicitly, as shown below, before enabling.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — part of Drupal core.
- The contrib **Plugin** module (`drupal/plugin`) — declared as a dependency but
  **not pulled in automatically**; you must require it yourself.

## Install with Composer

From the project root, require both this module **and** `drupal/plugin`:

```bash
composer require drupal/openy_er drupal/plugin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Requiring `drupal/plugin` in the same command is the key
step that lets the module enable.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openy_er drupal/plugin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openy_er -y
```

With `drupal/plugin` present, this now succeeds. If you still see a *"missing its
dependency module plugin"* error, it means `drupal/plugin` was not installed —
require it as shown above and try again.

## Verify it worked

Open any entity reference field's configuration page under Field UI and look at the
**Reference method** selector. You should now see **Default (Open Y)** (and related
Open Y handlers) as options alongside the standard *Default* handler. Selecting one
and exporting the field config — then confirming the exported config no longer
depends on individual bundle configs — confirms the module is working. See the
["How to use it"](../index.md#how-to-use-it) section of the overview for the full
migration steps.
