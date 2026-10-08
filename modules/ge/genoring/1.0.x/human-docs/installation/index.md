# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **File** (`file`) module.
- The **xnttdm** module (external‑entity data models), which supplies the data
  models datasets are created against.

> **Prefer the platform install.** GenoRing is designed to be installed as part
> of the wider **GenoRing platform**, which bundles the bioinformatics tools that
> surround this module. Installing the module on its own gives you the
> data‑management UI but not the rest of the platform. If your project expects the
> full platform, follow the GenoRing platform's own deployment instructions
> instead of the standalone steps below.

## Install with Composer

From the project root:

```bash
composer require drupal/genoring -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `xnttdm` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/genoring -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en genoring -y
```

Drupal will enable `file` and `xnttdm` alongside it if they aren't already on.

## Submodules

GenoRing ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GenoRing JBrowse** | `genoring_jbrowse` | Integrates the **JBrowse** genome browser, adding a JBrowse view for exploring genomic data. Enable it only if you need the genome browser. |

Enable it when you need it:

```bash
drush en genoring_jbrowse -y
```

## Verify it worked

Log in as a user with the **administer genoring** (or **access administration
pages**) permission and open the dashboard at `/genoring`. If the dashboard loads
and shows the data‑management overview, the module is active. Next steps —
defining data models, configuring locators, creating datasets, and running
processors — are covered in [Configuration](../configuration/index.md).
