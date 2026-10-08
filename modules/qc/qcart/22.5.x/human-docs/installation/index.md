# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- No PHP libraries or other modules are required.
- Visitors' browsers must be able to reach `https://qcart.app` to load the widget
  script.

> **Note:** this project is minimally maintained, marked "no further development",
> and is **not** covered by Drupal's security advisory policy. It also loads remote
> third-party JavaScript on every page — review that before deploying to
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/qcart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qcart -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qcart -y
```

That is all there is to it — the Qcart button script is now attached to every page.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep qcart`.
2. Load any front-end page and view the source — you should see the external
   `https://qcart.app/btn.js` script referenced in the page head, and the Qcart
   button should render.
