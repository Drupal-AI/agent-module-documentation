# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **JSON:API** module (`jsonapi`) — a hard dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_taxonomy_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_taxonomy_tree -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_taxonomy_tree -y
```

Drupal enables core JSON:API automatically as a dependency if it is not on
already.

## Verify it worked

Request the endpoint for a vocabulary that exists on your site (using its machine
name):

```bash
curl https://your-site.example/api/taxonomy_tree/tags
```

You should get back a JSON:API document with the vocabulary's terms arranged as a
nested tree. Swap `tags` for your own vocabulary's machine name.
