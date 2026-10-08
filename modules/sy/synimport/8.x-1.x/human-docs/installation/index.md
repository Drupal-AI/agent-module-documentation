# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **idna** module (`idna`), which Drupal will pull in as a dependency.
- Shell / Drush access to the site — everything SynImport does is run from the
  command line.
- If you plan to export or import Commerce products, the relevant Commerce modules
  and your product/variation fields need to exist on the site.
- No PHP extensions or external libraries are listed as required.

## Install with Composer

From the project root:

```bash
composer require drupal/synimport -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synimport -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synimport -y
```

## Verify it worked

Run `drush list` and confirm the `synimport` and `synexport` commands appear. A
safe first test is to export a small, published slice of content — for example
`drush synexport:taxonomy /tmp/synexport-test 1` — and check that YAML files (and a
`files` subfolder for any binaries) are written into the target directory.

Before importing onto a destination site, make sure the matching content types,
taxonomy vocabularies and fields already exist there — SynImport does not create or
validate them.
