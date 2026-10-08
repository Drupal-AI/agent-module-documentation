# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) and **Field** module (`field`).
- The contributed **Mailchimp** module (`mailchimp`) — Nodeletter's bundled sender uses
  its API service. Composer pulls it in for you.
- A **Mailchimp account**, with an API key and at least one audience/list and a template
  set up on the Mailchimp side.

There are no third‑party PHP library requirements beyond what Mailchimp brings.

## Install with Composer

From the project root:

```bash
composer require drupal/nodeletter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Mailchimp module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodeletter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodeletter -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Nodeletter Blocks** | `nodeletter_blocks` | Exposes the newsletter sending form as a **block** so it can be placed outside the per‑node tab. Enable it only if you need that. |

Enable it when you need it:

```bash
drush en nodeletter_blocks -y
```

## Verify it worked

After enabling, you should see the **Nodeletter** global settings page at
**Configuration → Web services → Nodeletter** (`/admin/config/services/nodeletter`).
Next, connect Mailchimp and enable a content type — see
[Configuration](../configuration/index.md).
