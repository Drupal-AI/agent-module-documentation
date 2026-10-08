# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **Filter** module (`filter`) — used to render the privacy‑policy
  body through a text format. It is part of a standard install and enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fz152 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fz152 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fz152 -y
```

## Submodules — enable only what you need

FZ152 ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **FZ152 Contact** | `fz152_contact` | Wires the consent checkbox into Drupal core Contact forms, per contact form bundle. |
| **FZ152 Consent** | `fz152_consent` | Logs each consent — client IP, form ID, and selected submitted values — as `fz152_consent` records you can review and bulk‑delete in an admin View. |

For example, to add consent logging:

```bash
drush en fz152_consent -y
```

Both submodules require the base FZ152 module, which is already present once you
have installed it above. After enabling, head to
[Configuration](../configuration/index.md) to turn the feature on and choose your
forms.
