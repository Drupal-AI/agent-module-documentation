# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- No other contrib modules and no PHP library requirements.

By default MathJax loads its JavaScript from a public CDN, so there is nothing to
download. If your site must not call out to a CDN, you can host the library
locally instead — see [Configuration](../configuration/index.md#serving-the-library-locally).

## Install with Composer

From the project root:

```bash
composer require drupal/mathjax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mathjax -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mathjax -y
```

## Next steps

Enabling the module is not quite enough on its own — in the recommended **Text
Format** mode you also need to add the **MathJax** filter to at least one text
format before any maths is typeset. See
[Configuration](../configuration/index.md) for that step and for all the settings.
