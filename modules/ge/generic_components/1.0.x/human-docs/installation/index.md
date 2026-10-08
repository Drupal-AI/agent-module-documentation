# Installation

## Requirements

Generic components is self‑contained:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal's **Single Directory Components (SDC)** system, which is part of core —
  no separate module to enable.

There are no third‑party Composer or PHP library requirements, and no other
contrib modules are required. It pairs naturally with the **Display Builder**
module, but that is optional.

## Install with Composer

From the project root:

```bash
composer require drupal/generic_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/generic_components -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en generic_components -y
```

That's all. The module registers its components immediately; there is nothing to
configure.

## Verify it worked

Add a component include to a template — for example
`{{ include('generic_components:generic_html_wrapper', { content: 'Hello' }) }}`
— and render the page. If the wrapped markup appears, the components are
registered and working. If you use Display Builder, you should also see the
Generic components entries available when composing a display.
