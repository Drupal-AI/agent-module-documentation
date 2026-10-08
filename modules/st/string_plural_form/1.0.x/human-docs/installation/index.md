# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Locale** module (`locale`), which ships with Drupal and provides the
  translation system. Drupal enables it automatically as a dependency.

There are no other dependencies — no third-party Composer packages or PHP
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/string_plural_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/string_plural_form -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en string_plural_form -y
```

## Verify it worked

After enabling, browse to **Configuration → Regional and language → Languages →
String Plural Form** (`/admin/config/regional/language/string-plural-form`). You
should see each of your enabled languages listed with a selector for its plural
rule. Setting those rules is the one required step — see
[Configuration](../configuration/index.md).
