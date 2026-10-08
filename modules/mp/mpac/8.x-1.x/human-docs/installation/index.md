# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Path** module (`path`) — this is the only dependency, and it also
  enables autocompletion against URL aliases. Drupal enables Path automatically
  as a dependency when you turn on Multi-Path Autocomplete.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mpac -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mpac -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mpac -y
```

That's all it takes — there is no configuration. The path field on the menu-link
form immediately becomes a title-based autocomplete.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep mpac
```

Then go to **Structure → Menus → *(any menu)* → Add link** and start typing a
page title in the **Link** field — you should see matching suggestions, and
choosing one should fill in the correct internal path.
