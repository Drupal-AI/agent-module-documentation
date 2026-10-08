# Installation

## Requirements

- **Drupal 9.2 or later** (`core_version_requirement: >=9.2` — see the note about
  this open‑ended constraint in the [overview](../index.md)).
- Core's **User** module (`user`), part of every Drupal install.
- A **Marketo** subscription. For API‑based capture and sync you will need REST API
  credentials (a client ID and client secret) and your Marketo REST endpoint and
  identity URLs; for Munchkin tracking you will need your Munchkin account ID.

This 3.x branch is built on a maintained GuzzleHttp‑based Marketo client (unlike the
older 2.x branch, which relied on an abandoned Guzzle 3 library).

## Install with Composer

From the project root:

```bash
composer require drupal/marketo_ma -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Marketo client
library and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/marketo_ma -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en marketo_ma -y
```

## Submodules — enable only what you need

Marketo MA ships several submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Contact** | `marketo_ma_contact` | Surfaces Marketo contact/lead data back inside Drupal. |
| **Contact block** | `marketo_ma_contact_block` | A block for displaying Marketo contact data. |
| **Legacy client** | `marketo_ma_legacy_client` | The older client, for compatibility with legacy setups. |
| **User** | `marketo_ma_user` | Captures leads from Drupal user accounts (creation, update, login) and maps user fields to Marketo fields. |
| **Webform** | `marketo_ma_webform` | Integrates with the Webform module — capture leads from webform submissions, set a custom LeadSource per webform, and map components to Marketo fields. |

For example, to capture leads from user accounts:

```bash
drush en marketo_ma_user -y
```

Each submodule requires the base Marketo MA module, which is already present once you
have installed it above. The Webform submodule additionally needs the contributed
**Webform** module.

## Verify it worked

At **Extend** (`/admin/modules`) confirm **Marketo MA** (and any submodules you
chose) are checked. Then open the **Marketo MA settings** form to connect to your
Marketo instance — see [Configuration](../configuration/index.md).
