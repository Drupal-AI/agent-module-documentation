# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No extra modules are required beyond Drupal core.
- Visitors must have **JavaScript enabled**, since parameters are appended
  client‑side at render time.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_param_propagator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_param_propagator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_param_propagator -y
```

No new content types or text‑format changes are needed — the module uses a small
JavaScript behaviour and `drupalSettings`.

## Verify it worked

Visit **Configuration → System → Link Param Tracking**
(`/admin/config/system/link_param_propagator`) and confirm the settings form
loads. After adding a rule (see [Configuration](../configuration/index.md)), load
a page with tracking parameters in the URL and inspect a link inside your target
region — it should now carry the propagated parameters.
