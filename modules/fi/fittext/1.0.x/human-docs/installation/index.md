# Installation

## Requirements

FitText is deliberately lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fittext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fittext -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fittext -y
```

## Verify it worked

After enabling, load a page whose headline text FitText targets and resize your
browser window (or view it on a phone and a desktop). The display text should
grow and shrink to fill the width of its container rather than staying at a fixed
size. If it does, the FitText.js integration is working.
