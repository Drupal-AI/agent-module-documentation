# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module, version 6 or later (`webform:webform`) — this is a hard
  dependency and Drupal will require it.
- Drupal's **private file system** must be configured, because recommendation
  PDFs must be stored privately, never in public files.
- A working **GhostScript** binary (`gs`) that PHP can execute — GhostScript is
  what merges the application answers and recommendation PDFs into one file.

## Install with Composer

From the project root:

```bash
composer require drupal/academic_applications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Webform) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/academic_applications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en academic_applications -y
```

## Confirm the prerequisites

Before collecting any real applications:

- **Private files** — make sure the private file system is set up so
  recommendation uploads land in private storage, not public.
- **GhostScript** — confirm the `gs` binary is installed and executable by PHP.
  If it is missing, bundling the final PDF will fail.

## Try it with the example

The project ships an **Academic Applications Example** submodule that sets up a
working configuration you can inspect. Enable it if you want a reference setup:

```bash
drush en academic_applications_example -y
```
