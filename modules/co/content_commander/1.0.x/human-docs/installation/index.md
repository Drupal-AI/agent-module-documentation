# Installation

## Requirements

- **Drupal 11 or newer** (`core_version_requirement: >=11`).
- **PHP 8.3 or higher**.
- The **`dex_console`** module (`drupal/dex_console`), which provides the `dex`
  console that runs Content Commander's commands. Composer pulls it in
  automatically, along with `nikic/php-parser`, `digilist/dependency-graph`, and
  `symfony/console`.

This project is covered by Drupal's security advisory policy. Content Commander is a
developer tool with no web‑facing surface; the Dex console requires shell access to
run.

## Install with Composer

From the project root:

```bash
composer require drupal/content_commander -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Dex console and
the other libraries and resolve them together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_commander -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_commander -y
```

## Verify it worked

Content Commander has no UI to check. Confirm the Dex command is registered — for
example run `dex list` (via `ddev exec dex list` or inside `ddev ssh`) and look for
the `content-commander:create-all` command. Then write an enum under a custom
module's `src/ContentCommander/` directory (see the [overview](../index.md)) and run
`dex content-commander:create-all` to generate it.
