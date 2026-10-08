# Installation

> **Do not install this module.** It is **obsolete** and cannot be enabled on modern
> Drupal. Skip to [What to install instead](#what-to-install-instead).

## Why it can't be enabled

Devel Kint Extras is marked `lifecycle: obsolete` in its `.info.yml`. Attempting to
turn it on fails:

```bash
drush en devel_kint_extras -y
# Error: module 'devel_kint_extras' is obsolete
```

The reason is that the module extended Devel's Kint dumper, and **Devel removed its
Kint integration in version 5.4.0** — there is no longer a Devel `kint` dumper for it
to build on. Its historical requirements were Drupal 9/10/11, the **Devel** module
(`^5.4`), and the `kint-php/kint` library, but none of that matters now because the
integration it relied on is gone.

## What to install instead

For Kint‑based variable dumping while debugging, use the standalone **Kint** module:

```bash
composer require drupal/kint -W
drush en kint -y
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kint -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

Feature requests for the "show methods and statics" behavior that Devel Kint Extras
once provided should be filed in the [Kint module](https://www.drupal.org/project/kint)
issue queue.
