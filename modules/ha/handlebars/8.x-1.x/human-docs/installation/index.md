# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies.

There are no third-party Composer or PHP library requirements to add by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/handlebars -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/handlebars -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en handlebars -y
```

Enabling the module has **no visible effect on its own** — it does nothing until
you define Handlebars templates (as Drupal libraries) and call the renderer from
your JavaScript. See the [main guide](../index.md#how-to-use-it-drupal-1011) for
the steps.

## Verify it worked

Define a small test template as a library, attach it to a page, and call
`handlebarsRenderer.render('your.template.name', { … })` from JavaScript. If the
rendered HTML appears in your target container, the integration is working.
