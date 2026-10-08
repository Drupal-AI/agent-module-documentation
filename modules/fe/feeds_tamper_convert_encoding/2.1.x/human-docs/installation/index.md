# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Tamper** module (`tamper:tamper`) enabled.
- PHP's **mbstring** extension (it supplies the `mb_list_encodings()` list of
  encodings) — standard on almost all Drupal hosts.
- To use it inside a Feeds import you also need the **Feeds** and **Feeds Tamper**
  modules (`drupal/feeds`, `drupal/feeds_tamper`).

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper_convert_encoding -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will bring in Tamper if it isn't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_tamper_convert_encoding -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_tamper_convert_encoding -y
```

This also enables Tamper if it isn't on yet. If you haven't already, enable Feeds
and Feeds Tamper too, so the plugin is available inside a Feed type's Tamper tab:

```bash
drush en feeds feeds_tamper -y
```

## Verify it worked

Open a Feed type's **Tamper** tab at **Structure → Feed types**
(`/admin/structure/feeds`). When you add a plugin to a field, the Convert Encoding
plugin should appear in the list of available tampers, offering input and output
encoding selects.
