# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Contact Formatter. You will
  also need at least one contact form for the formatter to render.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_formatter -y
```

There is **no configuration form, no permissions and no submodules**. Once
enabled, the **"Rendered Contact Form"** formatter is available to select on any
entity‑reference field that targets a contact form — see
[How to use it](../index.md#how-to-use-it).

## Verify it worked

On a bundle that has an entity‑reference field pointing at a contact form, open
**Manage display** and confirm that **"Rendered Contact Form"** appears in that
field's **Format** dropdown.
