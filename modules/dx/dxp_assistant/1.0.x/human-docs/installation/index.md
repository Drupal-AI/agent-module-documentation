# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- No hard Drupal module dependencies are declared, and no separate PHP or
  third‑party Composer library is required by the module itself.
- The **script URL** of the DXP assistant service you want to load.

## Install with Composer

From the project root:

```bash
composer require drupal/dxp_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dxp_assistant -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dxp_assistant -y
```

## Set the assistant script URL

Go to **Configuration → User interface → DXP Assistant**
(`/admin/config/user-interface/dxp-assistant`, permission *administer dxp assistant*)
and enter the assistant's **script URL**. That URL is stored in the module's
configuration and loaded on the page for permitted users — the module does not store
or require any API key or secret of its own. Point it only at a provider you trust,
since the script runs in your visitors' browsers.

## Verify it worked

Confirm the module is enabled (`drush pm:list --status=enabled | grep dxp_assistant`),
set the script URL as above, then grant *access dxp assistant* to the roles that should
load the assistant under **People → Permissions**. Because this is an early
work‑in‑progress release, check the project page for the current steps to confirm the
assistant is connecting to your DXP service.
