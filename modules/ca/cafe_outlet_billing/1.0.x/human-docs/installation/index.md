# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **Field** (`field`) and **Views** (`views`) modules — Drupal enables
  these as dependencies.
- The **TCPDF** PHP library (`tecnickcom/tcpdf`), used to render the PDF
  invoice. Composer pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/cafe_outlet_billing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including installing the TCPDF library — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cafe_outlet_billing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cafe_outlet_billing -y
```

Core's Field and Views modules are enabled automatically as dependencies.
