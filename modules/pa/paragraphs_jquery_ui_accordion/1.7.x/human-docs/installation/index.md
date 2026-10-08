# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`) — you need multi‑value paragraph
  reference fields for the formatter to apply to.
- The **jQuery UI Accordion** module (`drupal/jquery_ui_accordion:^2.0`), which
  provides core's bundled jQuery UI Accordion library. Composer pulls it in
  automatically; no extra JavaScript libraries need to be downloaded.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_jquery_ui_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in jQuery UI Accordion
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_jquery_ui_accordion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_jquery_ui_accordion -y
```

This also enables Paragraphs and jQuery UI Accordion if they are not already on.

## Verify it worked

On an entity that has a **multi‑value** paragraph reference field, open its **Manage
display** tab and check that **Paragraphs jQuery UI Accordion** is offered as a
formatter for that field. If it is, you're ready — see the
[main page](../index.md#how-to-use-it) for how to configure the formatter. There is
no separate configuration page.
