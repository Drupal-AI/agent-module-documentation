# Installation

## Requirements

Textfield Counter is self-contained. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1.0`).
- Core's **Text** module (`text`), which is part of standard Drupal and is enabled
  automatically as a dependency.
- No third-party Composer packages or JavaScript libraries. (The module ships its
  own small JavaScript for the live counter.)

## Install with Composer

From the project root:

```bash
composer require drupal/textfield_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/textfield_counter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en textfield_counter -y
```

Enabling it makes the five counter widgets available on your *Manage form display*
screens. There is no settings page and no configuration step — you select and
configure a widget per field.

## Verify it worked

Go to any bundle's **Manage form display** screen (for example **Structure →
Content types → Article → Manage form display**), find a text field, and confirm a
"…with counter" option appears in its **Widget** dropdown. See the
[how-to-use section on the overview page](../index.md#how-to-use-it) for what to do
next.
