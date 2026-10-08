# Installation

## Requirements

- **Drupal 10.2 / 11.1 or newer** (`core_version_requirement: ^10.2 || ^11.1`).
- The **`zircote/swagger-php`** PHP library, which does the attribute scanning.
  Composer installs it as a dependency of the module.
- The **Swagger UI** distribution assets (`swagger-api/swagger-ui`), installed
  into your site's `/libraries/swagger-ui` directory so the `/api/docs` page can
  render.

There are no other Drupal module dependencies and no submodules.

## Install the module with Composer

From the project root:

```bash
composer require drupal/swagger_php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`zircote/swagger-php` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swagger_php -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Install the Swagger UI library

The interactive docs page needs the Swagger UI dist assets under
`/libraries/swagger-ui` (so the files are available at, for example,
`/libraries/swagger-ui/dist/`). Follow the same approach used by the
`openapi_ui_swagger` module's
[Composer installation notes](https://www.drupal.org/project/openapi_ui_swagger#installation-composer)
to place the Swagger UI distribution there. Without this library, `/api/docs` has
nothing to render.

## Enable the module

```bash
drush en swagger_php -y
```

## Next steps

Before the spec is useful you need to choose which folder to scan, grant the
spec/docs permissions, and annotate your code with OpenAPI attributes — see
[Configuration](../configuration/index.md).
