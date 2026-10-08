# Installation

## Requirements

- **Drupal core `^8.8 || ^9 || ^10`**.
- For the **Tidy** beautifier only: PHP's **`tidy` extension** must be installed
  on the server. The bundled **HTMLBeautify** plugin is pure PHP and needs
  nothing extra, so you can use the module without Tidy.

There are no Composer library or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/beautify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/beautify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en beautify -y
```

After enabling, grant the beautifier permission (upstream typo:
`admninister beautifiers`) under **People → Permissions**, then choose the active
beautifier on the settings form — see [Configuration](../configuration/index.md).
