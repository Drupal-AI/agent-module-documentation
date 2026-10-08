# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A **Google AdSense account** with an approved publisher ID (`ca-pub-…`) and, for
  most ad types, at least one ad unit that gives you an *ad slot* ID.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/adsense -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adsense -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adsense -y
```

After enabling, go straight to the settings form and enter your publisher ID —
see [Configuration](../configuration/index.md). No ads appear until that is set
(and while placeholder mode is on you will see grey boxes rather than real ads,
which is the intended safe default during setup).

## Submodules — enable only what you need

AdSense ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AdSense ads.txt** | `adsense_adstxt` | Automatically serves an `/ads.txt` file generated from your publisher ID, which Google recommends for verifying authorized sellers. |
| **AdSense old code** | `adsense_oldcode` | Support for deprecated pre-2007 ad and search code (`oldcode` / `oldsearch` ad plugins). Only needed for very old ad inventory. |

For example:

```bash
drush en adsense_adstxt -y
```
