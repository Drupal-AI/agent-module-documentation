# Installation

## Requirements

- **Drupal 11 only** (`core_version_requirement: ^11`). This 2.0.x release does not
  run on Drupal 10.
- The **Pathauto** module
  ([`pathauto`](https://www.drupal.org/project/pathauto)) — required.
- Core's **Node** (`node`) and **Path** (`path`) modules — required, and part of
  core.

**Strongly recommended:** the
[Redirect](https://www.drupal.org/project/redirect) module. Because moving a page
changes its URL and every descendant's, automatic redirects on alias change are
effectively a prerequisite for using hierarchical URLs safely.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pathauto_entity_parent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Pathauto (and its
Token dependency) and update any shared dependencies as needed. Consider adding
Redirect at the same time:

```bash
composer require drupal/pathauto_entity_parent drupal/redirect -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pathauto_entity_parent -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pathauto_entity_parent -y
```

Drupal will enable Pathauto (and Token) at the same time if they aren't already
on.

## Verify it worked

Go to **Configuration → Search and metadata → Parent**
(`/admin/config/search/parent`) and enable nesting for a content type. Then edit a
node of that type, set its parent, and save — the generated alias should reflect
the parent chain (for example `/parent-page/child-page`).
