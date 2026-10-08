# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other module dependencies and no third‑party PHP libraries.
- Note the **URL shortener service** the module references (Google's URL Shortener)
  is deprecated/shut down — verify the link‑repair behavior for your version before
  running it against real content.

## Install with Composer

From the project root:

```bash
composer require drupal/brokenlinks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/brokenlinks -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brokenlinks -y
```

Because this module rewrites content and is an early release
(8.x‑2.0‑alpha3), test it on a non‑production copy first, review its
configuration, and grant its permission only to trusted roles.
