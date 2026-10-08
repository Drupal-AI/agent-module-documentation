# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **File** (`file`) and **Link** (`link`) modules — the two field types the
  formatters work with. They are enabled automatically as dependencies.
- Internet access from the visitor's browser to the **RapiDoc** library on the
  public CDN `https://unpkg.com/rapidoc`, unless you mirror the library locally
  (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/rapidoc_elements_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rapidoc_elements_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rapidoc_elements_field_formatter -y
```

## A note on the CDN library

By default the RapiDoc JavaScript is pulled from `https://unpkg.com/rapidoc` at
runtime. If your site has a strict Content Security Policy, or must work offline,
download the library, serve it locally, and override the library definition in
`rapidoc_elements_field_formatter.libraries.yml` from your theme or a custom
module.

## Verify it worked

Add a file or link field to a content type, then open its **Manage display**
screen. The **RapiDoc Elements UI** formatter should be selectable for that
field. Point it at a valid OpenAPI spec and view the content — you should see the
interactive RapiDoc API reference render on the page.
