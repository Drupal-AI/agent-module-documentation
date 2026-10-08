# Installation

## Requirements

- **Drupal 10.4, 11, or 12** (`core_version_requirement: ^10.4 || ^11 || ^12`).
- **CKEditor 5 Plugin Pack Templates**
  (`ckeditor5_plugin_pack:ckeditor5_plugin_pack_templates`) — this module is built
  to work with it and declares it as a dependency. Composer pulls it in for you.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_div_as_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the CKEditor 5
Plugin Pack Templates dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_div_as_block -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_div_as_block -y
```

This also enables the CKEditor 5 Plugin Pack Templates module if it is not already
on.

## Verify it worked

Configure a CKEditor 5 text format used for div‑based/template content and edit a
piece of content in it. Divs should now behave as selectable block containers in
the editor. Because the module was built with LLM assistance and is minimally
maintained, test the behavior against your real content before relying on it.
