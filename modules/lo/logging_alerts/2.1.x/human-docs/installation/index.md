# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- `emaillog` depends on core's **User** module (enabled by default); `errorlog`
  has no dependencies.
- For `errorlog`, be aware that where messages actually land is controlled by your
  server's PHP `error_log` setting — the module routes to the server error log,
  your PHP/OS configuration decides the file or facility.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

You install the **project** with Composer, then enable the individual submodules
with Drush. From the project root:

```bash
composer require drupal/logging_alerts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/logging_alerts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module(s)

> **Do not run `drush en logging_alerts`** — there is no module at the project
> root, so it will fail. Enable the submodules you actually want:

```bash
# Email alerts routed by severity:
drush en emaillog -y

# Watchdog messages to the web server error log:
drush en errorlog -y
```

You can enable either one or both.

## Submodules

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Email Logging and Alerts** | `emaillog` | Routes watchdog messages to email addresses by severity — different severities to different recipients, or nowhere. |
| **Web Server Logging and Alerts** | `errorlog` | Writes chosen severities to the web server's error log (destination governed by PHP `error_log`). |

## Verify it worked

After enabling a submodule, open its settings form (see
[Configuration](../configuration/index.md)) and confirm it loads at
`/admin/config/development/emaillog` or `/admin/config/development/errorlog`. Then
trigger a log message at a severity you've routed and confirm it arrives — an
email in the configured inbox for `emaillog`, or an entry in your server error log
for `errorlog`.
