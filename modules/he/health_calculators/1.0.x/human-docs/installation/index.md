# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other module dependencies.

> **Not security-advisory covered.** This project is not covered by Drupal's
> security advisory policy. Because the Caffeine Calculator exposes a public form,
> review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/health_calculators -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/health_calculators -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and a calculator

The umbrella module on its own does nothing — enable it together with the
calculator you want. In this release that's the Caffeine Calculator:

```bash
drush en caffeine_calculator -y
```

Enabling the Caffeine Calculator automatically pulls in the parent
`health_calculators` module, so you don't have to enable it separately. (You can
enable just `health_calculators` if you only want the package present as a base
for calculators you'll add later.)

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Caffeine Calculator** | `caffeine_calculator` | A public form that estimates caffeine intake from a chosen drink and serving size, with a recommended daily amount. Admin-configurable drink list. |

## Verify it worked

Visit the public form at `/body-calculators/caffeine-calculator` — you should see
a form to choose a drink and enter a size. To set up the available drinks, go to
**Configuration → Development tools → Caffeine Calculator**
(`/admin/config/tools/caffeine-calculator`), covered in
[Configuration](../configuration/index.md).
