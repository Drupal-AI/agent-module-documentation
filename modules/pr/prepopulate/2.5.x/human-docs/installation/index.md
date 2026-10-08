# Installation

## Requirements

Prepopulate is refreshingly undemanding:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other module
  dependencies for the base module.

The optional **OG Prepopulate** submodule (`og_prepopulate`) additionally
requires the **Organic Groups** module (`drupal/og`); only enable it if you use OG.

## Install with Composer

From the project root:

```bash
composer require drupal/prepopulate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/prepopulate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prepopulate -y
```

That is the entire setup. There is no configuration form and no permission to
grant — the module starts working immediately. Any link that carries an
`edit[...]` query parameter will now prefill the matching form fields.

## Optional submodule

If you use Organic Groups and want to prefill OG audience fields the same way,
enable the submodule:

```bash
drush en og_prepopulate -y
```

It requires the base Prepopulate module (already present) and the `og` module.

## Verify it worked

Visit a form with a prefill query string, for example
`/node/add/article?edit[title][widget][0][value]=Hello` (adjust for a content
type you have). The title field should open already containing *Hello*. If it
does not, double-check the field path against the input's `name` attribute in the
page source — see the [main guide](../index.md) for how to work it out.
