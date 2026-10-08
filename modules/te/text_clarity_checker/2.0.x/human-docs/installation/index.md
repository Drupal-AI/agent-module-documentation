# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`; the project tracks toward 12).
- Drupal core only — there are no additional dependent modules or third-party
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/text_clarity_checker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_clarity_checker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en text_clarity_checker -y
```

## Verify it worked

The module installs ready to use. Go to **Structure → Block layout**, place the
**Text Clarity Checker** block into a region of your theme, and configure which
node types and roles it should apply to. When you then edit or view matching
content, the clarity metrics (text length, estimated reading time, image count,
heading structure) should appear. No additional configuration is required for
basic functionality.
