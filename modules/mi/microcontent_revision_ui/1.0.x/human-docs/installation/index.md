# Installation

> **Before you install:** this module is **obsolete and unsupported**. Its features
> have been merged into the [Microcontent](https://www.drupal.org/project/microcontent)
> module itself (see
> [issue #3396780](https://www.drupal.org/project/microcontent/issues/3396780)). On a
> current site, use Microcontent's built-in revision support instead of this module.

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Microcontent** module (`microcontent`) — required.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/microcontent_revision_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Microcontent if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/microcontent_revision_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en microcontent_revision_ui -y
```

## Verify it worked

At **People → Permissions**, grant the microcontent revision permissions to an
appropriate role, then open a Microcontent item and confirm a revision/version-history
view is available and that viewing and reverting work as expected.
