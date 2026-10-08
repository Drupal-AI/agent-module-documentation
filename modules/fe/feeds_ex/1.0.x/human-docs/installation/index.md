# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Feeds** module (`drupal/feeds`) — the hard dependency. Install it if you don't
  already have it.
- PHP's **libxml** and **SimpleXML** extensions (`ext-libxml`, `ext-simplexml`), which
  the XML/HTML XPath parsers use. These ship with most PHP builds.

Depending on which parsers you plan to use, feeds_ex also pulls in these PHP libraries
via Composer (all are declared as dependencies, so a normal Composer install fetches
them automatically):

- **`softcreatr/jsonpath`** — required for the **JsonPath** parsers.
- **`mtdowling/jmespath.php`** — required for the **JMESPath** parsers.
- **`gravitypdf/querypath`** — required for the **QueryPath** parsers.

> This is a **beta** release. If your project's Composer `minimum-stability` is set to
> `stable`, you may need to allow `beta` releases for this package.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_ex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the JSONPath, JMESPath
and QueryPath libraries along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/feeds_ex -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

If you don't manage libraries with Composer, feeds_ex can also be used with the Ludwig
module to install its parser libraries.

## Enable the module

```bash
drush en feeds_ex -y
```

Enabling feeds_ex adds its parsers to the choices available on a Feeds feed type — it
doesn't import anything on its own. Configure a feed type to use one of the parsers as
described in the [overview](../index.md#how-to-use-it).
