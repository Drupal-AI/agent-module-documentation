# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/nobots -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nobots -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nobots -y
```

Enabling the module does **not** switch the header on — you activate it per
environment via state or `settings.php`. See the "How to use it" section of the
[overview](../index.md).

## Verify it worked

After activating the module on an environment (for example
`drush state:set nobots 1`), request any page and inspect the response headers —
for example:

```bash
curl -sI https://your-site.example/ | grep -i x-robots-tag
```

You should see `X-Robots-Tag: noindex, nofollow, noarchive`. If the header is
absent, the module is enabled but not yet activated for that environment.
