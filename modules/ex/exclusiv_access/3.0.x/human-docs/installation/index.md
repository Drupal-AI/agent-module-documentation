# Installation

## Requirements

- **Drupal 10.1 or newer, or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and is enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/exclusiv_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exclusiv_access -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exclusiv_access -y
```

## Verify it worked

Add the **Exclusiv Access** field to a content type (under **Manage fields**),
then create a node of that type and enable the gate on its **Exclusiv access
control** tab. After saving you should see a message containing the tokenised
URL. Open that URL in a private/incognito window (as an anonymous visitor) to
confirm the content is reachable *with* the token — and that visiting the plain
URL without the token is blocked. See the "How to use it" section of the
[overview](../index.md) for the full workflow, including the **see content without
token** bypass permission.
