# Installation

## Requirements

- **Drupal 10.3.12+ or 11** — precisely `^10.3.12 || ^11.0.11 || ^11.1.2`.
  Single‑Directory Components are a core feature in these versions, which is what
  the module inspects.
- The **`twig/twig` library at `~3.19`**, a Composer dependency that is installed
  automatically when you require the module.

There are no other module dependencies, and the module declares no PHP version
requirement of its own beyond what Drupal core needs.

## Install with Composer

From the project root:

```bash
composer require drupal/sdc_devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (such as `twig/twig`) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sdc_devel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdc_devel -y
```

This is a development/CI tool, so you would normally enable it in your local and
CI environments rather than on production. There are no submodules and nothing to
configure — once it is on, go to **Reports → UI Components** or run
`drush sdc-devel:validate <project>` to validate your components.
