# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module (`comment`) — SCN depends on it, and Drupal will
  enable it automatically as a dependency.
- For Telegram delivery, a **Telegram bot token** and one or more **chat IDs**
  (set up separately in Telegram — see the Configuration guide).
- There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/scn -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scn -y
```

## After enabling

SCN sends nothing until you configure recipients. Go to
**Configuration → System → Simple Comment Notify**
(`/admin/config/system/scn`) and choose who to notify — see
[Configuration](../configuration/index.md). Grant the **Administer SCN
configuration** permission to any non‑admin roles that should manage these
settings, at **People → Permissions**.
