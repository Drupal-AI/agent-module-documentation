# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Database Logging** module (`dblog`) enabled — this is the only dependency and
  the source of the log entries Autoban scans. Drupal enables it automatically as a
  dependency.
- **A ban‑provider submodule** enabled (see below), otherwise rules have nothing to
  execute the ban with.
- For CIDR range bans, the contributed **Advanced Ban** (`advban`) module, which the
  `autoban_advban` submodule integrates with.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/autoban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autoban -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autoban -y
```

## Submodules — you need at least one ban provider

Autoban itself finds offending IPs; the actual banning is done by a **ban provider**
supplied by a submodule. Enable the one that matches how you want to block IPs:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Autoban Ban** | `autoban_ban` | The **Core Ban** provider (`ban`) — bans single IPs through Drupal core's Ban module. This is the usual starting point. |
| **Autoban Advanced Ban** | `autoban_advban` | The **Advanced Ban** providers — `advban` (single IP) and `advban_range` (whole CIDR ranges), backed by the contributed Advanced Ban module. |
| **Autoban dblog** | `autoban_dblog` | Adds one‑click "ban this IP" action links to the core **Recent log messages** report. |

For a typical setup, enable Autoban Ban:

```bash
drush en autoban_ban -y
```

Only providers from **enabled** submodules appear as choices when you build a rule. With
just Autoban Ban enabled, **Core Ban** is your only provider — a rule that references a
provider whose submodule is disabled will have nothing to carry out the ban.

## Verify it worked

Log in as an administrator and visit **Configuration → People → Autoban**
(`/admin/config/people/autoban`). You should see the (empty) rules list and links to the
Analyze, Test, and Settings screens. Next, create your first rule — see
[Configuration](../configuration/index.md).
