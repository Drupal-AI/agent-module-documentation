# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- No dependent modules, and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/social_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_links -y
```

## Verify it worked

There is no settings page to visit. Instead, go to **Structure → Content types →
[a type] → Manage display**, and confirm that a **Social Links** component now
appears in the list of fields you can enable for that display. Enable it, save,
and view a piece of content in that view mode — you should see Twitter/X,
Facebook and email share links. From there you can extend the provider set in
code as described in the [main guide](../index.md).
