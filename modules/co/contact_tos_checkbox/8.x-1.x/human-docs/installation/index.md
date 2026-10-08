# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Contact** module (`contact`) — the only dependency, enabled
  automatically as needed.

There are no additional PHP libraries or third‑party Composer requirements.

> **Heads up:** this project is marked **Unsupported / Obsolete** and is **not
> covered** by Drupal's security advisory policy. Weigh a maintained alternative
> before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_tos_checkbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_tos_checkbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_tos_checkbox -y
```

## Verify it worked

The checkbox does **not** appear until you enable and configure it. Head to
[Configuration](../configuration/index.md), turn the checkbox on, and set your
label and description — then load the site‑wide contact form and confirm the
required consent checkbox is shown near the bottom and blocks submission until
ticked.
