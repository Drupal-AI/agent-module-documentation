# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11.0 || ^12`).
- The contributed **Webform** module (`webform`) and core's **Options** module —
  the relay is a Webform handler, so Webform must be present. Drupal enables
  Options automatically as a dependency.
- A **monday.com account** with API access, and an **API token** — you add the
  token to `settings.php` during configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/monday_crm_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have the Webform module, add it too
(`composer require drupal/webform -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monday_crm_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monday_crm_integration -y
```

## Verify it worked

Open any webform's **Settings → Emails / Handlers → Add handler**. The
**monday.com — Create board item** handler should appear in the list. Before it
can actually reach monday.com you need to add your API token and configure the
handler — see [Configuration](../configuration/index.md).
