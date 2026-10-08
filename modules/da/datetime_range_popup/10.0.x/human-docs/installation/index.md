# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Datetime** (`datetime`) and **Datetime Range** (`datetime_range`) modules — these are
  hard dependencies and Drupal enables them automatically. You also need at least one
  **Date-range (`daterange`)** field for the widget to apply to.

There are no third‑party Composer or PHP library requirements bundled in Composer — but note the
external CDN assets below.

## Install with Composer

From the project root:

```bash
composer require drupal/datetime_range_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/datetime_range_popup -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datetime_range_popup -y
```

Enabling it also enables **Datetime** and **Datetime Range** if they are not already on. Then
switch a Date-range field's widget to **DateTime Range Popup** on the relevant *Manage form
display* screen (see [How to use it](../index.md#how-to-use-it)).

## Important: external CDN assets

The picker's asset library loads several resources from **third-party CDNs** rather than bundling
them locally:

- Bootstrap (maxcdn.bootstrapcdn.com)
- bootstrap-material-design ripples/material JS + CSS (cdnjs.cloudflare.com)
- Moment.js with locales (momentjs.com)
- Roboto font + Material Icons (fonts.googleapis.com)

Consequences to weigh before using it on a production or privacy-sensitive site:

- The widget **depends on outbound requests to those hosts** — if they are unreachable, the
  picker may not work.
- It is subject to their **versioning and availability**, outside your control.
- It sends editor browser requests to third parties, which has **privacy implications**.

For privacy and reliability, consider **self-hosting these assets** or overriding the module's
library definition (`datetime_range_popup.libraries.yml`) to point at local copies. The module's
own JS/CSS (`css/datetime_range_popup.css` and the two JS files) are bundled locally.

There are no submodules.
