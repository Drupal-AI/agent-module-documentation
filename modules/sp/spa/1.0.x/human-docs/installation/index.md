# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Plugin Form Element** module (`plugin_form_element`) and the **Multivalue
  Form Element** module (`multivalue_form_element`) — required dependencies that
  power the module's configuration forms. Composer pulls them in with the command
  below.

There are no additional PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/spa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the two
form-element dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/spa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en spa -y
```

> **This is a beta release** (1.0.0-beta2). Try it on a non-production environment
> first.

## Next steps

1. Define an **SPA config entity** describing your application — its HTML snippet,
   the Drupal libraries that provide its JavaScript and CSS, and any inline
   scripts.
2. Place the SPA **block** in your chosen region via **Structure → Block layout**.
3. Confirm that any API endpoints your SPA calls enforce their own authentication
   — Drupal does not secure them for you.

## Verify it worked

Visit a page where you placed the SPA block and confirm your single-page
application mounts and runs, with its JavaScript and CSS loaded through Drupal's
library system.
