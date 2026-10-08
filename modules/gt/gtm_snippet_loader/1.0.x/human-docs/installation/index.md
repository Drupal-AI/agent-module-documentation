# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No dependencies beyond Drupal core.
- A **Google Tag Manager container**, server‑side GTM endpoint, or other trusted
  tag‑manager snippet — needed only if you actually want to load an external tag
  manager (which is the usual reason to install this).

Note: this module is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/gtm_snippet_loader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gtm_snippet_loader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gtm_snippet_loader -y
```

## Recommended companions

- **Config Split** — useful for enabling or changing the snippet per environment
  (for example, no tracking on staging).
- **Config Ignore** — useful when the snippet configuration should vary outside
  your normal deployment workflow.

## Verify it worked

Go to **Configuration → System → GTM Snippet Loader**
(`/admin/config/system/gtm-snippet-loader`). If the configuration form loads, the
module is installed. After you paste in your head snippet (see
[Configuration](../configuration/index.md)), load a front‑end page and view its
source to confirm the snippet appears in the `<head>`.
