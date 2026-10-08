# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The [Gutenberg](https://www.drupal.org/project/gutenberg) editor module, which
  provides the editing experience this feature extends. (While the package does
  not declare a hard module dependency, the span control only appears inside the
  Gutenberg editor, so Gutenberg must be installed and enabled on the content you
  edit.)

There are no third-party Composer or PHP library requirements.

> **Note:** this module is **not covered by Drupal's security advisory policy**.
> Weigh that against your site's risk tolerance before using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_span -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gutenberg_span -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gutenberg_span -y
```

## Verify it worked

Edit a piece of content in the Gutenberg editor, select some text, and look for
the **span** option among the inline formatting controls. Apply it, add a class,
save, and check that the `<span class="…">` survives on the rendered page (it
will only do so if the text format allows the `span` tag and `class` attribute).
