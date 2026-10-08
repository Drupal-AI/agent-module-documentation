# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** system (part of Drupal core) — no contrib dependencies and no
  third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/fb_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fb_filter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fb_filter -y
```

Enabling the module makes the filter available; it does nothing until you add it to
a text format.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure a
format, and confirm the **Facebook filter** filter is listed under *Enabled
filters*. Enable it there (see the "How to use it" section of the
[overview](../index.md)), save, then create test content containing a Facebook
`#hashtag` and view it — the filter should turn the hashtag into a link on output.
