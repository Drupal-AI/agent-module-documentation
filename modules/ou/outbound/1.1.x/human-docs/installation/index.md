# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** module (`link`) — the only dependency, enabled automatically as
  a dependency. You'll use the formatter on Link fields.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/outbound -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/outbound -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en outbound -y
```

## Verify it worked

Go to a content type that has a Link field, open **Manage display**, and confirm
the **Outbound** formatter appears in the field's Format list. Select it, save, and
then view a piece of content with an external link — clicking the link should take
you to the interstitial "leaving the site" page before the external destination.
