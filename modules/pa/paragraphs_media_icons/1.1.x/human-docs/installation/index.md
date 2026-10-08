# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`).
- **PHP 8.1 or newer**.
- Core **Media** (`media`) and **File** (`file`) modules, and the **Paragraphs**
  module (`paragraphs`) — Drupal enables these as dependencies when you turn on
  Paragraphs Media Icons.

There are no third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_media_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_media_icons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_media_icons -y
drush cr
```

The module works immediately after a cache rebuild — no extra setup is required to
start assigning Media-based icons.

## Migrate your existing icons

If you already have paragraph types with base64-encoded config icons, convert them
to Media entities with the bundled Drush commands (both are safe to run multiple
times):

```bash
drush pmi:stats     # shows current config bloat and icon usage
drush pmi:migrate   # converts all existing base64 icons to Media entities
drush pmi:stats     # should now report ~0 MB bloat
drush cex           # export the now-smaller config
```

## Verify it worked

Go to **Structure → Paragraphs types**, edit a type, and confirm a **Media Icon**
field is present on the form. After running `drush pmi:migrate`, a second
`drush pmi:stats` should show the config bloat dropped to roughly zero, and your
next `drush cex` should be noticeably faster with far cleaner diffs. Icons should
still display exactly as they did before.
