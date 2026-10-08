# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No modules outside Drupal core, and no third‑party Composer or PHP libraries.
- Useful in combination with Drupal's serialization/REST or Views JSON exports —
  that is the output this module rewrites.

## Install with Composer

From the project root:

```bash
composer require drupal/relative_to_absolute_urls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/relative_to_absolute_urls -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en relative_to_absolute_urls -y
```

That's all — there is no configuration step.

## Verify it worked

Produce a JSON export (for example a Views REST export, or content serialized to
JSON) that contains rendered markup with a relative link. With the module enabled,
the links in that JSON output should now be absolute (starting with your site's
scheme and domain) rather than relative paths.
