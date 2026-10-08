# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5||^11`).
- Core's **Layout Discovery** (`layout_discovery`) and **Path** (`path`) modules —
  Drupal enables these automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

> **Not production‑ready yet.** The 3.0.x branch is a complete rewrite with **no
> upgrade path from 2.x**. The maintainers ask that you not run it in production
> until there is a stable release — but testing and feedback are welcome.

## Core patch requirement

The AJAX‑form behaviour in 3.0.x is affected by a core bug
([#2897377](https://www.drupal.org/project/drupal/issues/2897377)). Until that is
fixed in core, add the patch to your `composer.json` patches (using
`cweagans/composer-patches`):

```json
"drupal/core": {
  "#2897377: data-drupal-selector random value": "https://www.drupal.org/files/issues/2022-09-23/core-2897377-55.patch"
}
```

## Install with Composer

From the project root:

```bash
composer require drupal/homebox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/homebox -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en homebox -y
```

## Submodules

Homebox ships two optional submodules — enable the ones you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Homebox Portlet Type: Block** | `homebox_portlet_type_block` | Lets ordinary Drupal blocks be used as Homebox portlets. This is the one most sites want, since it's what makes the block system available on a dashboard. |
| **Homebox Portlet Type: Examples** | `homebox_portlet_type_examples` | Example portlet types, useful for exploring how portlets work and as a starting point for building your own. |

For example:

```bash
drush en homebox_portlet_type_block -y
```

## Verify it worked

After enabling, review Homebox's permissions at **People → Permissions**
(`/admin/people/permissions`) and create a Homebox page as described in "How to
use it" in the [overview](../index.md). Visit the page as a user with access — you
should be able to add portlets and drag them into a custom arrangement that
persists across visits.
