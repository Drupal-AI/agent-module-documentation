# Installation

## Requirements

- **Drupal 9.3+, 10.1+, or 11** (`core_version_requirement: ^9.3 || ^10.1 || ^11`).
- The **Translation Management Tool** suite:
  - **TMGMT** (`tmgmt`, `~1.14`)
  - **TMGMT File** (`tmgmt_file`) — supplies the XML/XLIFF export formats.
  - **TMGMT Extension Suite** (`tmgmt_extension_suit`, `~9.4`) — schedules and
    processes the upload/download queues.
  - Core **Serialization** (`serialization`).
- The **`smartling/api-sdk-php`** PHP library (v5), used to authenticate and talk to
  the Smartling API. Composer installs it automatically.
- An **active Smartling subscription** and a Smartling project's **Project Id**,
  **User Id**, and **Token Secret**.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_smartling -W
```

This pulls in TMGMT, TMGMT File, the TMGMT Extension Suite, and the Smartling PHP
SDK as dependencies. The `-W` (`--with-all-dependencies`) flag lets Composer update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_smartling -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_smartling -y
```

Drupal enables the TMGMT dependencies at the same time. The Smartling **provider
plugin** is now available in TMGMT, but nothing translates until you create and
configure a provider — see [Configuration](../configuration/index.md).

## Keep your Smartling Token Secret out of exported config

The Token Secret is a credential. Rather than committing it to exported
configuration, store it in an environment variable and reference it — for example
via a **Key** entity or a `settings.php` override. With DDEV you can set the variable
once with `ddev dotenv set .ddev/.env --smartling-token-secret=<value>` (never commit
`.ddev/.env`), then `ddev restart`, and consume it from a Key or from settings.

## Submodules

| Submodule | Machine name | When to enable |
|-----------|--------------|----------------|
| Context Debug | `tmgmt_smartling_context_debug` | Troubleshooting the visual-context feature — adds a form to inspect what context HTML would be sent. |
| Log Settings | `tmgmt_smartling_log_settings` | Fine-tune per-channel log severity for Smartling logging. |
| Acquia Cohesion | `tmgmt_smartling_acquia_cohesion` | Only if you run Acquia Cohesion (Site Studio) and need its components translated. Hidden; requires the `cohesion` module. |
| Test | `tmgmt_smartling_test` | Test-only helper. Do not enable on a real site. |

Enable the ones you need with `drush en <machine_name> -y`.

## Verify it worked

Go to **Translation → Providers** (`/admin/tmgmt/translators`) and start adding a
provider — **Smartling** should appear in the plugin list. Make sure **cron is
running** on the site, because uploads and downloads are processed through queues on
cron. Then continue to [Configuration](../configuration/index.md).
