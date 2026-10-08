# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other contrib modules and no PHP or Composer libraries are required by the
  base module.

Note this project is **not** covered by the security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entitylogic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entitylogic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entitylogic -y
```

## Optional: the UI submodule

EntityLogic ships an optional submodule, **entitylogic_ui**, that adds a
read‑only report listing your registered logic classes at
`/admin/reports/entitylogic`. Enable it only if you want that overview:

```bash
drush en entitylogic_ui -y
```

Grant the `entitylogic_ui view list` permission to the roles that should see the
report.

## Verify it worked

Because this is a developer API with no UI of its own, the quickest check is the
Drush generator. Run:

```bash
drush generate
```

and confirm that **EntityLogic** appears in the list of generators. From there,
follow [How to use it](../index.md#how-to-use-it) to scaffold and wire up your
first logic class.
