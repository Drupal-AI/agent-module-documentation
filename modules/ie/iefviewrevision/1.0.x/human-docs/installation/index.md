# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Inline Entity Form** module (`inline_entity_form`) — the required
  dependency this add‑on extends.

There are no third‑party PHP library requirements.

## Install with Composer

Note that the Composer package name differs from the module's machine name. From
the project root:

```bash
composer require drupal/iefviewrevision -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Inline Entity Form if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/iefviewrevision -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `ief_view_revision` (different from the package
name):

```bash
drush en ief_view_revision -y
```

Drupal enables the required Inline Entity Form module automatically as a
dependency.

## Verify it worked

Edit content that uses an Inline Entity Form widget referencing nodes. Beside
each referenced item's Edit and Remove buttons you should now see a **Revisions**
link that opens the node's revision history in a new tab.
