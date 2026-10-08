# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`).
- A **multilingual site** to see any effect — the module emits tags only when more
  than one language is enabled. (It won't break a single-language site; it just
  does nothing there.)

Hreflang has **no module dependencies** and no third-party Composer or PHP library
requirements. It works well alongside core's **Content Translation** module.

## Install with Composer

From the project root:

```bash
composer require drupal/hreflang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hreflang -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hreflang -y
```

The module ships **no submodules**. It works out of the box — the settings form
only fine-tunes behavior.

## Verify it worked

On a multilingual site, visit any page and view its HTML source. You should see
one `<link rel="alternate" hreflang="…">` tag for each enabled language, plus an
`hreflang="x-default"` tag (unless you turn that off). If you see no tags, confirm
that your site actually has more than one language enabled. See
[Configuration](../configuration/index.md) for the optional settings.
