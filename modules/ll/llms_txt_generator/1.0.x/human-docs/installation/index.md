# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules or third‑party libraries are required — the module has no
  dependencies.

Bear in mind this is a **1.0.0-alpha1** release, so test it on a non‑production
environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llms_txt_generator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llms_txt_generator -y
```

## Verify it worked

Visit `https://yoursite.com/llms.txt` in a browser. Once you have configured and
enabled the file (see [Configuration](../configuration/index.md)), the generated
content should appear there. You can then head to **Configuration → Search and
metadata → LLMs.txt Generator** to choose what the file lists.
