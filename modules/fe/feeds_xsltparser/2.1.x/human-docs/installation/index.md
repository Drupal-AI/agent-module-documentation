# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Feeds** module (`feeds:feeds`) enabled — and the **Feeds UI** submodule if
  you want to set importers up through the admin interface.
- PHP's **XSL extension** available in your Drupal environment (this is what runs
  the XSLT transformations).

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_xsltparser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will bring in Feeds if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_xsltparser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's web
> container already includes the PHP XSL extension.

## Enable the module

```bash
drush en feeds_xsltparser -y
```

This also enables Feeds if it isn't on yet. Enable the Feeds UI too if you want to
configure importers in the admin interface:

```bash
drush en feeds_ui -y
```

## Verify it worked

Go to **Structure → Feed types** (`/admin/structure/feeds`) and add or edit a Feed
type. **XSLT Pipeline Parser** should now appear in the **Parser** list. If it's
missing, confirm the PHP XSL extension is installed.
