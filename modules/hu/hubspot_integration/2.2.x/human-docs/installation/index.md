# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Paragraphs** (`paragraphs`) and **Entity Reference Revisions**
  (`entity_reference_revisions`) modules — Composer installs these for you.
- A **HubSpot account** with an API key and portal, so the module can call the
  HubSpot Contacts API and embed your forms.

## Install with Composer

From the project root:

```bash
composer require drupal/hubspot_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including Paragraphs and Entity Reference Revisions — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hubspot_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hubspot_integration -y
```

This enables Paragraphs and Entity Reference Revisions as dependencies at the
same time.

Grant the **Administer hubspot integration** permission to the administrators who
will manage the settings, mapping, and sort forms.

## Verify it worked

Go to **`/admin/config/hubspot_integration/admin`**. You should reach the
module's Settings form, where you enter your HubSpot API key/portal details. Once
the key is in place, the Mapping and Sort forms let you connect HubSpot contact
properties to your taxonomy. See [Configuration](../configuration/index.md).
