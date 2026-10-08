# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`).
- A **core patch** — "Allow to merge AjaxCommands in AjaxResponse"
  ([Drupal.org issue #3343670](https://www.drupal.org/project/drupal/issues/3343670))
  — applied to `drupal/core` / `drupal/core-recommended`. The live‑update behavior
  depends on it.

There are no third‑party Composer or PHP library requirements beyond the core
patch.

## Install with Composer

From the project root:

```bash
composer require drupal/layoutbuilder_extras_live_update -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layoutbuilder_extras_live_update -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

### Apply the core patch

The module needs the AjaxResponse merge patch from issue #3343670. The usual
approach is to add it under the `extra.patches` section of your project's
`composer.json` (using `cweagans/composer-patches`), pointing at the patch for
your Drupal core version, then run `composer update -W` to apply it.

## Enable the module

```bash
drush en layoutbuilder_extras_live_update -y
```

## Verify it worked

Open a Layout Builder‑enabled entity, configure a section, and change one of its
radio/select/checkbox controls — the layout should update live, without saving. If
nothing updates, re‑check that the core patch from issue #3343670 was applied. See
[Configuration](../configuration/index.md) for the settings form and permission.
