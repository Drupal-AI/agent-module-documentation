# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Feeds Extensible Parsers** (`drupal/feeds_ex`, version `^1.0`), which is a hard
  dependency. That in turn requires the **Feeds** module, so a working Feeds +
  feeds_ex setup is the real prerequisite.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_ex_xml_mapping -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in **feeds_ex** (and
Feeds) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_ex_xml_mapping -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_ex_xml_mapping -y
```

Enabling it also enables **feeds_ex** if it isn't already on. There are no
submodules and no configuration step at install time — you turn the feature on
per feed type afterward (see the [overview](../index.md)).

## Verify it worked

Go to a feed type that uses the **XML** parser
(**Structure → Feeds → *(your feed type)* → Mapping**). You should now see an
**Override mapping per feed** section with the two override checkboxes. If the feed
type uses a different parser, the checkboxes won't appear — that's expected, since
the module only extends the XML parser.
