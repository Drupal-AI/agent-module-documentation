# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`) for this 4.1.x
  branch of the dashboard.
- Core's **Taxonomy**, **Update**, and **Views** modules.
- A number of contrib dependencies that Composer will pull in with the dashboard:
  **Advanced Queue** (`advancedqueue`), **DRD Agent** (`drd_agent`), **Encrypt**
  (`encrypt`), **Real AES** (`real_aes`), **Entity Views Attachment** (`eva`),
  **Key value field** (`key_value_field`), **External Links** (`extlink`),
  **Hacked!** (`hacked`), **Monitoring** (`monitoring`), and **Security Review**
  (`security_review`).
- On **each remote site** you intend to manage: the **DRD Agent** module,
  installed and enabled there.

## Install with Composer

Install the dashboard on your central management site, from the project root:

```bash
composer require drupal/drd -W
```

The `-W` (`--with-all-dependencies`) flag is important here — DRD has a large
dependency tree, and `-W` lets Composer pull in and update all of the required
modules together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drd -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drd -y
```

Drush enables DRD's required dependency modules automatically.

## Submodules — enable only what you need

DRD ships several optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **DRD ECA** | `drd_eca` | Event‑driven automation for actions across the fleet. |
| **DRD Migrate** | `drd_migrate` | Migration helpers for DRD data. |
| **DRD Install Core** | `drd_install_core` | Core installation support for managed sites. |
| **DRD PI** | `drd_pi` | Base hosting‑provider integration ("provider interface"). |
| **DRD PI Acquia** | `drd_pi_acquia` | Acquia hosting integration. |
| **DRD PI Pantheon** | `drd_pi_pantheon` | Pantheon hosting integration. |
| **DRD PI Platform.sh** | `drd_pi_platformsh` | Platform.sh hosting integration. |

For example, to add Acquia hosting integration:

```bash
drush en drd_pi_acquia -y
```

The DRD PI provider submodules hold hosting‑provider API credentials — store
those as secrets and treat them as sensitive.

## Install the DRD Agent on remote sites

DRD is a hub‑and‑spoke system: the dashboard connects to a **DRD Agent** running
on each remote site. On every site you want to manage, install and enable the
agent:

```bash
composer require drupal/drd_agent -W
drush en drd_agent -y
```

Then register that site from the dashboard and establish its authenticated,
TLS‑verified connection.

## Verify it worked

1. On the dashboard site, confirm the DRD administration screens load under the
   site administration menu.
2. Confirm the DRD Agent is enabled on at least one remote site.
3. Register that remote site from the dashboard and confirm the connection
   succeeds and its status data appears.

For connecting sites and the full workflow, follow the project's community
documentation on drupal.org and the "How to use it" section of the
[overview](../index.md).
