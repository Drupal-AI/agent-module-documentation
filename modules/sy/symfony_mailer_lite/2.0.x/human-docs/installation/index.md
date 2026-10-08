# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The contributed **Mail System** module (`mailsystem` `^4.4`), enabled
  automatically as a dependency — it is how you tell Drupal to route mail through
  Symfony Mailer Lite.
- Composer libraries (installed automatically with the command below):
  - `symfony/mailer` `^6.4 || ^7.1` — the mailer engine.
  - `html2text/html2text` `^4.0.1` — generates the plain‑text alternative body.
  - `tijsverkoyen/css-to-inline-styles` `^2.2` — inlines CSS into the HTML.

There is no PHP version constraint beyond what those libraries and your Drupal
version require.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_lite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mail System and the
Symfony Mailer libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_lite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_lite -y
```

Mail System is enabled automatically. Enabling the module does **not** yet change
how mail is sent — you must select Symfony Mailer Lite in Mail System first. Head
to [Configuration](../configuration/index.md) to assign the mailer and set up a
transport. There are no submodules.
