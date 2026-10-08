# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Drupal's Token replacement system (core provides token replacement; the
  contrib **Token** module adds the token browser UI if you want to pick tokens
  visually).
- No third‑party Composer or external library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupalforge_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalforge_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalforge_token -y
```

## Verify it worked

The module's Drupal Forge tokens should now be available wherever token
replacement runs. Open a token browser (for example the "Browse available tokens"
link near a supported field, provided by the Token module) and confirm the Drupal
Forge tokens appear. Insert one into content and view the page — it should render
the "Launch on Drupal Forge" widget. See
[How to use it](../index.md#how-to-use-it) for details.
