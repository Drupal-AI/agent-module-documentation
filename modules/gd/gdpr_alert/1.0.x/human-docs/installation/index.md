# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **JS Cookie** module (`js_cookie`), which provides the JavaScript cookie
  library the alert uses to remember a visitor's acknowledgement. Composer pulls it
  in as a dependency.
- No other special requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/gdpr_alert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the JS Cookie
module and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gdpr_alert -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gdpr_alert -y
```

## Verify it worked

Log in as an administrator and open the settings form at
`/admin/config/gdpr-alert`. Fill in the required fields and save — then load a
front‑end page to confirm the alert bar appears. Continue to
[Configuration](../configuration/index.md) for the details of each field.
