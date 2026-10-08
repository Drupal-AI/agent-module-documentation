# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **JSON:API Extras** module (`jsonapi_extras`) — a hard
  dependency, and where you apply the enhancer. JSON:API Extras in turn needs
  core's JSON:API.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_text_enhancer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in JSON:API Extras
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_text_enhancer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_text_enhancer -y
```

Drupal enables JSON:API Extras (and core JSON:API) automatically as dependencies
if they are not on already.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep jsonapi_text_enhancer
```

Then go to **Configuration → Web services → JSON:API**, edit a resource type, and
check that the new text enhancer appears as an option on a formatted-text field —
see the [overview](../index.md) for how to apply it.
