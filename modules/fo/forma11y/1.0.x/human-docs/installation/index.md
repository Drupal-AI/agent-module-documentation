# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Inline Form Errors** module (`inline_form_errors`) — this is a hard
  dependency and provides the inline error rendering that Forma11y makes
  accessible. Drupal enables it automatically as a dependency when you turn on
  Forma11y.
- **Webform** (contrib) is recommended but not required, if your forms are built
  with Webform.

There are no third‑party Composer or PHP library requirements. The module does
not have security‑advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/forma11y -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/forma11y -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forma11y -y
```

This also enables core's **Inline Form Errors** module if it isn't already on.

## Verify it worked

There is no settings page to open. Instead, go to any form (for example the login
form), submit it with a required field left blank, and confirm the error appears
as Drupal's **inline** message tied to the field — not as a browser validation
pop‑up. If the browser bubble no longer appears, `novalidate` is in place and
Forma11y is working.
