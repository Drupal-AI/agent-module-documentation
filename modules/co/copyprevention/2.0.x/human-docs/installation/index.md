# Installation

## Requirements

Copy Prevention is lightweight and has no third‑party library requirements. It
needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **RobotsTxt** (`drupal/robotstxt`) — *only* if you want the module to write
  image `Disallow` rules into your robots.txt. Every other option works without
  it. This is a suggested, optional companion, not a hard dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/copyprevention -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/copyprevention -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en copyprevention -y
```

Enabling the module changes nothing on its own — every deterrent starts **off**.
Head to [Configuration](../configuration/index.md) to turn on the protections you
want.

## Optional: add RobotsTxt for image robots.txt rules

If you plan to use the "Disallow image files in robots.txt" option, install and
enable the RobotsTxt module too:

```bash
composer require drupal/robotstxt -W
drush en robotstxt -y
```

Without it, the other search‑engine options (the HTTP header and the `<meta>`
tag) still work fine.
