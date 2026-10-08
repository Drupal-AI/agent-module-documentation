# Installation

## Requirements

Entity Print needs **Drupal 9.4, 10, or 11** and two core modules, which it enables
automatically as dependencies:

- **File** (`file`) — core's file-handling module.
- **Image** (`image`) — core's image module.

It also needs a **PDF library** to actually generate documents. Entity Print does
not bundle one on its own; you install it with Composer. The default print engine
is **Dompdf**, which the module declares as a Composer requirement
(`dompdf/dompdf >= 2.0.7`). Dompdf is pure PHP and works with **no system binary**,
which makes it the easiest engine to get running.

Two other engines are supported as optional extras, each backed by its own PHP
library:

- **wkhtmltopdf** — install `mikehaertl/phpwkhtmltopdf`. This engine renders more
  faithfully (better CSS/JS support) but also requires the `wkhtmltopdf`
  **system binary** to be installed on the server.
- **TCPDF** — install `tecnickcom/tcpdf`. A pure-PHP alternative for cases where
  Dompdf's rendering is insufficient.

You only need one engine to start. This guide uses Dompdf.

## Install with Composer

From the project root, require the module together with its PDF library:

```bash
composer require drupal/entity_print -W
composer require dompdf/dompdf
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (If you plan to use wkhtmltopdf or TCPDF instead, require
`mikehaertl/phpwkhtmltopdf` or `tecnickcom/tcpdf` in place of `dompdf/dompdf` — and,
for wkhtmltopdf, make sure the `wkhtmltopdf` binary is installed on the server.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_print -W`,
> `ddev composer require dompdf/dompdf`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_print -y
```

This also enables core's `file` and `image` modules if they are not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → Content authoring → Entity
Print** (`/admin/config/content/entityprint`). You should see the **Entity Print**
settings page with a **PDF** engine dropdown listing **Dompdf** (only engines whose
PHP library is installed appear in that list):

![The Entity Print settings page after installation](../images/settings.png)

If the page loads and Dompdf is offered as the PDF engine, the module and its
library are installed correctly. Next, review the
[configuration](../configuration/index.md) to pick an engine, set your paper size,
and expose a print link on your content.
