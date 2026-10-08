# Installation

## Requirements

- **Drupal 8.8, 9, 10 or 11** (`core_version_requirement: ^8.8 || ^9.0 || ^10.0 ||
  ^11`).
- The **PHP Simple HTML DOM Parser** library (`simplehtmldom/simplehtmldom`). From
  the 2.x branch onward the library is not included in the module package — it is a
  Composer dependency, so installing the module with Composer brings it in
  automatically.
- No other Drupal modules are required.

## Install with Composer

Installing with Composer is the recommended route precisely because it also pulls in
the parser library. From the project root:

```bash
composer require drupal/simplehtmldom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplehtmldom -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplehtmldom -y
```

## Verify it worked

There is no admin page to check. Once enabled, the parser functions
(`str_get_html()`, `file_get_html()`, and the DOM traversal helpers) are available to
custom code. A quick way to confirm is to declare `drupal/simplehtmldom` as a
dependency of your custom module and call `str_get_html('<p>hi</p>')` from it.
