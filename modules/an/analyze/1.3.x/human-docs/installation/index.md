# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 | ^11`).
- No third‑party Composer or PHP library requirements for the base module.
- Optional, depending on which analyzers you use:
  - **Statistics** — the Node Statistics analyzer relies on core's (now deprecated)
    Statistics module for view counts.
  - **Drush** — required for the `analyze:batch` command.

## Install with Composer

From the project root:

```bash
composer require drupal/analyze -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/analyze -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze -y
```

The base module gives you the framework — the tab, the plugin API, and the settings
form — but no metrics on its own. Enable one or more analyzer submodules to get data.

## Submodules

Enable the analyzers you want with `drush en <machine_name> -y`:

| Submodule | Machine name | What it shows |
|-----------|--------------|---------------|
| Basic Content Info | `analyze_basic_content_info` | Fundamental stats — word count, image count. A good first analyzer to switch on. |
| Node Statistics | `analyze_page_views` | Traffic from core's Statistics module — total views, today's views. |
| Google Analytics | `analyze_google_analytics` | Google Analytics data per page. |
| Plugin Example | `analyze_plugin_example` | A worked example that documents the plugin API — for developers, not production data. |

Other analyzers (Search Console, broken links, and the AI brand‑voice / sentiment /
marketing / security audits) come from separate projects.

## Verify it worked

Go to **Configuration → Content authoring → Content Analysis**
(`/admin/config/content/analyze-settings`). You should see your content types listed with
a checkbox for each applicable analyzer. Enable at least one, then open a node and look
for the **Analyze** tab — see [Configuration](../configuration/index.md) for the details.
