# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That's the only requirement — no other contrib modules, no third-party Composer
libraries, no submodules. It depends on Drupal core's Twig, which is always
present.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_remove_html_comments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twig_remove_html_comments -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_remove_html_comments -y
```

There is nothing to configure. As soon as the module is enabled, the
`remove_html_comments` and `remove_html_comments_as_string` filters are registered
and available in every Twig template.

## Verify it worked

In a template you can override, add a value that contains an HTML comment and pipe
it through the filter, then rebuild caches (`drush cr`) and reload the page — the
comment should be gone from the output. For example:

```twig
{{ '<p>Hello</p><!-- hidden note -->'|remove_html_comments }}
```

should render just `<p>Hello</p>`.

For usage details, see the "How to use it" section on the
[overview page](../index.md).
