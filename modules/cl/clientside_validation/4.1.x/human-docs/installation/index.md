# Installation

## Requirements

Clientside Validation needs:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 7.4 or newer** (`php: >=7.4.0`).
- No other contrib modules for the base module.
- For live validation, the **jQuery Validate** JavaScript library — either loaded
  from a CDN or installed locally under `/libraries/jquery-validation/` (the jQuery
  engine submodule handles this; see below).

## Install with Composer

From the project root:

```bash
composer require drupal/clientside_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clientside_validation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module — you need both parts

Enabling the base module alone does **almost nothing visible** — it only writes
validation attributes onto form elements. To get live in‑browser validation you
must also enable the jQuery engine submodule:

```bash
drush en clientside_validation clientside_validation_jquery -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Clientside Validation jQuery** | `clientside_validation_jquery` | Loads the jQuery Validate library and runs the actual before‑submit validation with inline messages. Also adds the pattern and equal‑to rules and a settings form. **This is the part that makes validation happen.** |

A demo submodule (`clientside_validation_demo`) also exists, but it is for
testing only — don't enable it on a real site.

## The jQuery Validate library

The engine needs the jQuery Validate JavaScript. By default the submodule can load
it from a CDN, or you can install a local copy under
`/libraries/jquery-validation/dist/` for privacy or offline use. You choose which
in the jQuery settings form — see [Configuration](../configuration/index.md).

## Verify it worked

With both modules enabled, open a form that has a required field (for example the
contact form) and try to submit it empty. The browser should flag the required
field before the page reloads.
