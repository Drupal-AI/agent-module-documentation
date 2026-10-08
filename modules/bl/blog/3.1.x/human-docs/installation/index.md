# Installation

## Requirements

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`).
- Several core modules, which Drupal enables automatically as dependencies:
  **Block**, **Comment**, **Menu UI**, **Node**, **Path**, **Taxonomy**, **Text**,
  **User**, and **Views**. On most sites these are already on.

There are no third-party Composer libraries to add.

## Install with Composer

From the project root:

```bash
composer require drupal/blog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blog -y
```

Enabling the module installs the `blog_post` content type, the `blog` View (with its
listing pages, block, and RSS feeds), and the "My blog" account-menu link. There are
no submodules and no configuration form — see the [overview](../index.md) for the
few optional pieces (the Recent blog posts block and the profile link) you may want
to switch on.

> **Heads-up on uninstalling:** the module blocks its own uninstall while any blog
> posts still exist. Delete all Blog post content first if you ever need to remove
> it.
