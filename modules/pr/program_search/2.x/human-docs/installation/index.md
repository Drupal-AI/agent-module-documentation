# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Open Y** distribution context — this module depends on the `daxko` and
  `openy_socrates` modules and expects an Open Y (YMCA) site with program
  content. It is not intended for a stand-alone Drupal site.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/program_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Open Y
dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/program_search -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The project is `program_search`, but the module's machine name is
`openy_programs_search` — enable it by its machine name:

```bash
drush en openy_programs_search -y
```

## Verify it worked

Go to **Structure → Block layout** and click **Place block**. The
programs-search block should appear in the list, ready to place into a region.
See the [main guide](../index.md#how-to-use-it) for placing and configuring it.
