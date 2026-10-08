# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — this is the only Drupal dependency, and it's
  enabled automatically as a dependency.
- The **Ruffle JavaScript library**, which the player loads either from a CDN or from
  a local copy. If you prefer not to depend on a CDN at runtime, host the library
  locally.

This project is young and is not covered by Drupal's security advisory policy, so
weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ruffle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ruffle -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ruffle -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Then, on a content
type's **Manage display**, open the **Format** dropdown for a File field — you should
see **Ruffle Flash Player** as an option. The definitive test is to upload a `.swf`
file to a node using that field and confirm it plays in the browser.
