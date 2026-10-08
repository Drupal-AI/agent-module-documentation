# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Typed Data** module (`typed_data`), which is pulled in as a dependency.
- No third-party PHP library requirements are declared by the module.

This is a beta release (8.x-2.0-beta9); test it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/social_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Typed Data.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_share -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_share -y
```

## Verify it worked

After enabling, add the configurable share buttons to your content and confirm
they render where you expect. Check which sharing mechanism a configuration uses
(plain share URLs versus a network SDK script) so it fits your theme and privacy
posture, and restrict administration of the buttons to trusted roles.
