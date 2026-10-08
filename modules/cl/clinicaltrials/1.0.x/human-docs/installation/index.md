# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) — this is a dependency and Drupal will
  enable it automatically.
- **Outbound network access** to the ClinicalTrials.gov API, since the module
  fetches trial data from it.
- **Drush** and/or a working **cron** run if you want to automate imports.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/clinicaltrials -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/clinicaltrials -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en clinicaltrials -y
```

Enabling the module creates the **Clinical Trial** content type used for imported
trials.

## Grant the permission

Assign the **`administer clinical trials config`** permission to the roles that
should manage the API settings, under **People → Permissions**.

## Verify it worked

Configure your query parameters on the settings page (see
[Configuration](../configuration/index.md)), then run an import:

```bash
drush ct-import-studies
```

The command should fetch matching trials from ClinicalTrials.gov and create
Clinical Trial nodes, with logging showing what was imported.
