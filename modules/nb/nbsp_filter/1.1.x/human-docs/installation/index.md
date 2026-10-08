# Installation

## Requirements

NBSP Filter has no special requirements:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core only — there are no module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/nbsp_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nbsp_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nbsp_filter -y
```

Enabling the module does not change any content on its own — nothing happens until
you switch the filter on for a specific text format (see "How to use it" in the
[overview](../index.md)).

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), configure a format, and confirm that **NBSP
Filter** now appears in the list of enabled filters with its own settings section.
After enabling it there, save a piece of content that uses the format and check
that the non-breaking-space rules are applied on the rendered page.
