# Installation

## Requirements

- **Drupal 11 only** (`core_version_requirement: ^11`). This package does not run
  on Drupal 10 or earlier.
- No module dependencies of its own. In practice it is used alongside the
  **Commerce Kickstart demo recipe**, which brings in the Commerce modules the
  demo needs.

This project **is** covered by Drupal's security advisory policy.

## How it normally arrives

You usually do **not** install this package by hand. It is listed as a dependency
of the **Commerce Kickstart demo recipe**, so applying that recipe downloads and
enables this package for you. If you are following the Kickstart demo setup, there
is nothing separate to do here.

## Installing it directly (if you need to)

Should you want to add the package on its own — for example while developing or
testing the recipe — install it with Composer from the project root:

```bash
composer require drupal/commerce_kickstart_demo_assets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_kickstart_demo_assets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

Then enable it:

```bash
drush en commerce_kickstart_demo_assets -y
```

## A word on removal

Remember that the **demo is for evaluation, not production**, and that a **recipe
does not uninstall**. If you apply the Kickstart demo to a site you later want to
take live, plan to remove the demo content and this asset package manually — decide
how you will clean up *before* you apply it, not after.

## Verify it worked

There is no admin page to check. On Drupal 11 the module will appear as enabled in
**Extend** (`/admin/modules`), and its assets become available to the Kickstart
demo recipe. That is the extent of what this package does on its own.
