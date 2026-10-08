# Installation

## Requirements

Twig Views needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module — enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_views -y
```

That's all. The `render_view()` Twig function is immediately available in every
template — there is no configuration step.

## Verify it worked

Add a call such as `{{ render_view('frontpage', 'page_1') }}` to any template (for
example your theme's `page.html.twig`), clear the cache (`drush cr`), and load a
page that uses that template — the view should render in place. See the
[overview](../index.md) for usage and argument details.
