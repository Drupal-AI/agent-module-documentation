# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** and **File** modules (both in core; enabled as dependencies).
- The PHP **XMLReader** and **Zip** extensions. These are usually installed by
  default on PHP 5+, and are present in standard Drupal hosting stacks (including
  DDEV). If a `.odt` fails to import, confirm both extensions are loaded with
  `php -m | grep -iE 'xmlreader|zip'`.

## Install with Composer

From the project root:

```bash
composer require drupal/odt_importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/odt_importer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en odt_importer -y
```

## Verify it worked

Add a field of type **".odt file importer"** to a content type (see "How to use it"
in the [overview](../index.md)), point its **Destination field** at a text field,
then create a piece of content and upload a small `.odt` file. On save, the
destination field should contain the converted HTML — headings, bold/italic text,
lists, and so on — confirming the import pipeline works end to end.
