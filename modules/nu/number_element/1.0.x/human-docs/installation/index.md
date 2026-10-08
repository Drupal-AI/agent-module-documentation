# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Webform** module (`webform`) — this is a required dependency, since the
  element extends Webform's Textfield.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/number_element -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/number_element -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en number_element -y
```

Drupal will enable Webform first if it is not already on. You can also enable it
from **Extend** — search for "Webform Numeric Element Validation" and install it.

## Verify it worked

Edit any webform, open its **Source (YAML)** editor, and confirm you can add the
numeric element and its properties without error. Submit a test entry to check the
validation rules apply.
