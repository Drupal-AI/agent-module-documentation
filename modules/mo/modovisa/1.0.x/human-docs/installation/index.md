# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No PHP version constraint beyond what your Drupal core requires.
- **No module dependencies** and no third‑party PHP or JavaScript libraries.
- A **Modovisa project and tracking token** — sign up with Modovisa to obtain one.
- *(Optional)* **Drupal Commerce**, only if you want purchase/conversion reporting
  on checkout complete.

## Install with Composer

From the project root:

```bash
composer require drupal/modovisa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modovisa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modovisa -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Enabling the module alone does not start tracking — you still need to enter your
token and tick the enable box on the settings form (see
[Configuration](../configuration/index.md)). After you have done that and cleared
caches, load a public page of your site and view its source: you should see a
`<script id="modovisa-tracker" …>` tag in the `<head>`, loading
`https://cdn.modovisa.com/modovisa.min.js`.
